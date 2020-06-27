//
//  MovieDetailView.swift
//  Swift MVVM Compose
//
//  Created by Jesus Luongo Lizana on 6/27/20.
//  Copyright © 2020 Jesus Luongo Lizana. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
  @ObservedObject var viewModel: MovieDetailViewModel
  @Environment(\.imageCache) var cache: ImageCache
  
  var body: some View {
    content
      .onAppear {self.viewModel.send(event: .onAppear)}
  }
  
  private var content: some View {
    switch viewModel.state {
    case .idle:
      return Color.clear.eraseToAnyView()
    case .loading:
      return spinner.eraseToAnyView()
    case .error(let error):
      return Text(error.localizedDescription).eraseToAnyView()
    case .loaded(let movie):
      return self.movie(movie).eraseToAnyView()
    }
  }
  
  private func movie(_ movie: MovieDetailViewModel.MovieDetail) -> some View {
    ScrollView {
      VStack {
        fillWidth
        
        Text(movie.title).font(.largeTitle).multilineTextAlignment(.center)
        
        Divider()
        
        HStack {
          Text(movie.releasedAt)
          Text(movie.language)
          Text(movie.duration)
        }.font(.subheadline)
        
        poster(of: movie)
        
        genres(of: movie)
        
        Divider()
        
        movie.overview.map {
          Text($0).font(.body)
        }
      }
    }
  }
  
  private var fillWidth: some View {
    HStack {
      Spacer()
    }
  }
  
  private func poster(of movie: MovieDetailViewModel.MovieDetail) -> some View {
    movie.poster.map { url in
      AsyncImage(
        url: url,
        cache: cache ?? nil,
        placeholder: self.spinner,
        configuration: {$0.resizable()}
      ).aspectRatio(nil, contentMode: ContentMode.fit)
    }
  }
  
  private var spinner: Spinner { Spinner(isAnimating: true, style: .large)}
  
  private func genres(of movie: MovieDetailViewModel.MovieDetail) -> some View {
    HStack {
      ForEach(movie.genres, id: \.self) { genre in
        Text(genre).padding(5).border(Color.gray)
      }
    }
  }
}

//struct MovieDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    MovieDetailView()
//  }
//}
