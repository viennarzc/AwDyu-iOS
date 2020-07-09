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
  let trackId: Int?
  private let trackName: String?
  var artworkUrl30: String?
  var artworkUrl60: String?
  var artworkUrl100: String?
  var trackPrice: Double?
  var primaryGenreName: String?
  var description: String?
  var artistName: String
  var currency: Currency

  enum CodingKeys: String, CodingKey {
    case trackName
    case trackId
    case artworkUrl30
    case artworkUrl60
    case artworkUrl100
    case trackPrice
    case primaryGenreName
    case description
    case artistName
    case currency
  }
}

extension Track: Displayable {
  var priceText: String {
    guard let price = trackPrice else {
      return "0.00"
    }

    return String(price)
  }
  
  var name: String {
    guard let name = trackName else {
      return "Untitled Track"
    }
    
    return name
  }


}


enum Currency: String {
  case usd = "USD"
  case unknown = "unknown"
}

extension Currency: Decodable {
  private enum CodingKeys: String, CodingKey {
    case usd = "USD"
    case unknown
  }

  enum CodingError: Error {
    case decoding(String)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()

    self = Currency(rawValue: try container.decode(String.self)) ?? .unknown
  }

}
