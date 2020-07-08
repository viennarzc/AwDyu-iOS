//
//  ImageLoader.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/8/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit

//String as key, and Image as object
var imageCache = NSCache<NSString, UIImage>()

/// Manages loading from cache, caching, and downloading from URL
final class ImageLoader {
  public static let shared = ImageLoader()

  
  /// Downloads image from URL and caches
  /// - Parameters:
  ///   - url: url of image
  ///   - completion: completes with UIImage or Error
  static func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {

    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
      completion(cachedImage, nil)
    } else {

      //put background task coz it takes time to fetch images
      DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url) {
          if let image = UIImage(data: data) {

            completion(image, nil)

          }
        }
      }
    }

  }

}
