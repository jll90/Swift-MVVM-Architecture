//
//  Spinner.swift
//  Swift MVVM Compose
//
//  Created by Jesus Luongo Lizana on 6/27/20.
//  Copyright © 2020 Jesus Luongo Lizana. All rights reserved.
//

import SwiftUI
import UIKit

struct Spinner: UIViewRepresentable {
  
  let isAnimating: Bool
  let style : UIActivityIndicatorView.Style
  
  func makeUIView(context: Context) -> UIActivityIndicatorView {
    let spinner = UIActivityIndicatorView(style: style)
    spinner.hidesWhenStopped = true
    return spinner
  }
  
  func updateUIView(_ uiView: UIActivityIndicatorView, context: Context){
    isAnimating ? uiView.startAnimating(): uiView.stopAnimating()
  }
}
