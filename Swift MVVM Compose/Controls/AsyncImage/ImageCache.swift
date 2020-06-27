//
//  ImageCache.swift
//  Swift MVVM Compose
//
//  Created by Jesus Luongo Lizana on 6/27/20.
//  Copyright © 2020 Jesus Luongo Lizana. All rights reserved.
//

import UIKit
import SwiftUI

protocol ImageCache {
  subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
  private let cache = NSCache<NSURL, UIImage>()
  
  subscript(_ key: URL) -> UIImage? {
    get { cache.object(forKey: key as NSURL) }
    set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
  }
}

struct ImageCacheKey: EnvironmentKey {
  static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
  var imageCache: ImageCache {
    get { self[ImageCacheKey.self] }
    set { self[ImageCacheKey.self] = newValue }
  }
}
