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
  let id: Int?
  private let trackName: String?
  var artworkUrl30: String?
  var artworkUrl60: String?
  var artworkUrl100: String?
  var trackPrice: Double?
  var primaryGenreName: String?
  var description: String?
  var artistName: String
  var currency: Currency
  var longDescription: String?
  var shortDescription: String?

  enum CodingKeys: String, CodingKey {
    case trackName
    case id = "trackId"
    case artworkUrl30
    case artworkUrl60
    case artworkUrl100
    case trackPrice
    case primaryGenreName
    case description
    case artistName
    case currency
    case longDescription
    case shortDescription
  }
}

//MARK: - Displayable

extension Track: Displayable {
  var hasPrice: Bool {
    trackPrice != nil
  }
  
  var priceTextWithCurrency: String? {
    guard let price = trackPrice else {
      return nil
    }
    
    return currencySymbol + " " + String(price)
  }
  
  var priceText: String {
    guard let price = trackPrice else {
      return "0.00"
    }

    return String(price)
  }
  
  ///If trackName is Nil, set as 'Untitled Track'
  var name: String {
    guard let name = trackName else {
      return "Untitled Track"
    }
    
    return name
  }
  
  var currencySymbol: String {
    switch currency {
    case .unknown:
      return ""
    case .usd:
      return "$"
    }
  }

}

//MARK: - Purchaseable

extension Track: Purchaseable {
  var canPurchase: Bool {
    hasPrice
  }
  
  
}


//MARK: - Enum


enum Currency: String {
  case usd = "USD"
  case unknown = "unknown"
}

//MARK: - Decodable


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
