//
//  MoviesList.swift
//  Swift MVVM Compose
//
//  Created by Jesus Luongo Lizana on 6/27/20.
//  Copyright © 2020 Jesus Luongo Lizana. All rights reserved.
//

import Combine
import SwiftUI

struct MoviesListView: View {
  @ObservedObject var viewModel: MoviesListViewModel
  
  var body: some View {
    NavigationView {
      content
        .navigationBarTitle("Trending Movies")
    }
    .onAppear { self.viewModel.send(event: .onAppear) }
  }
  
  private var content: some View {
    switch viewModel.state {
    case .idle:
      return Color.clear.eraseToAnyView()
    case .loading:
      return Spinner(isAnimating: true, style: .large).eraseToAnyView()
    case .error(let error):
      return Text(error.localizedDescription).eraseToAnyView()
    case .loaded(let movies):
      return list(of: movies).eraseToAnyView()
    }
  }
  
  private func list(of movies: [MoviesListViewModel.ListItem]) -> some View {
    return List(movies) { movie in
      NavigationLink(
        destination: MovieDetailView(viewModel: MovieDetailViewModel(movieID: movie.id)),
        label: { MovieListItemView(movie: movie) }
      )
    }
  }
}

struct MovieListItemView: View {
  let movie: MoviesListViewModel.ListItem
  @Environment(\.imageCache) var cache: ImageCache
  
  var body: some View {
    VStack {
      title
      poster
    }
  }
  
  private var title: some View {
    Text(movie.title)
      .font(.title)
      .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
  }
  
  private var poster: some View {
    movie.poster.map { url in
      AsyncImage(
        url: url,
        cache: cache ?? nil,
        placeholder: self.spinner,
        configuration: { $0.resizable().renderingMode(.original) }
      ).aspectRatio(nil, contentMode: ContentMode.fit).frame(idealHeight: UIScreen.main.bounds.width / 2 * 3) // 2:3 aspect ratio
    }
    

  }
  
  private var spinner: Spinner { Spinner(isAnimating: true, style: .large)}

}
