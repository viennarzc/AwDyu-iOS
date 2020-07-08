//
//  Track.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/8/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import Foundation

/// Individual Track Item details
struct Track: Decodable {
  var id: Int
  var name: String
  var artworkUrl30: String
  var artworkUrl60: String
  var artworkUrl100: String
  var trackPrice: Float
  var primaryGenreName: String
}

extension Track: Displayable {
  var priceText: String {
    String(trackPrice)
  }
  
  
}

extension Track {
  enum CodingKeys: String, CodingKey {
    case id = "trackId"
    case name = "trackName"
    case artworkUrl30
    case artworkUrl60
    case artworkUrl100
    case trackPrice
    case primaryGenreName
  }

}
