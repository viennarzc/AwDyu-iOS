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

  var fullAttributedDescription: NSMutableAttributedString? {
    //set No Description as default
    var contatDescription: NSMutableAttributedString = NSMutableAttributedString(string: "")
    
    //append if long description exist
    if let long = attributedLongDescription {
      contatDescription.append(long)
    }
    
    //append if short description exist
    if let short = attributedShortDescription {
      contatDescription.append(NSMutableAttributedString(string: "\n"))
      contatDescription.append(short)
    }
    
    //appedn if description exist
    if let desc = attributedDescription {
      contatDescription.append(NSMutableAttributedString(string: "\n"))
      contatDescription.append(desc)
    }
    
    if contatDescription.length == 0 {
      contatDescription = NSMutableAttributedString(string: "No Description")
    }
    
    return contatDescription
    
  }
}

//MARK: - Displayable

extension Track: Displayable {
  var attributedShortDescription: NSMutableAttributedString? {
    guard let desc = shortDescription else { return nil }

    let data = Data(desc.utf8)
    let attributedString = try? NSMutableAttributedString(
      data: data,
      options: [.documentType: NSMutableAttributedString.DocumentType.html],
      documentAttributes: nil)


    return attributedString
  }

  var attributedLongDescription: NSMutableAttributedString? {
    guard let desc = longDescription else { return nil }

    let data = Data(desc.utf8)
    let attributedString = try? NSMutableAttributedString(
      data: data,
      options: [.documentType: NSMutableAttributedString.DocumentType.html],
      documentAttributes: nil)


    return attributedString
  }

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

  var attributedDescription: NSMutableAttributedString? {
    guard let desc = description else { return nil }

    let data = Data(desc.utf8)
    let attributedString = try? NSMutableAttributedString(
      data: data,
      options: [.documentType: NSMutableAttributedString.DocumentType.html],
      documentAttributes: nil)


    return attributedString

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
