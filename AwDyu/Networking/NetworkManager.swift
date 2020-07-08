//
//  NetworkManager.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/8/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import Foundation
import Alamofire

/// This is where we do Network calls, or API Requests
class NetworkManager {
  public static let shared = NetworkManager()

  func fetchList(completion: @escaping (Tracks?, AFError?) -> Void) {
    let urlString = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all"
    
    AF.request(urlString)
      .validate()
      .responseDecodable(of: Tracks.self) { (response) in

        if let error = response.error {
          completion(nil, error)
          return
        }

        if let result = response.value {
          completion(result, nil)
        }

    }
  }
  
}
