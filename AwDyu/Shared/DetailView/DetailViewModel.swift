//
//  DetailViewModel.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/9/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import Foundation

struct DetailViewModel: TrackDetail {
  var canPurchase: Bool
  
  var shortDescription: String?
  
  var genre: String?
  
  var artistName: String?
  
  var trackName: String?
  
  var priceText: String?
  
  var albumArtUrl100: URL?
  
  var description: String?
  
  var attributed: NSMutableAttributedString? = nil
  
  /// Initialize when presenting from Master View page
  /// - Parameter model: Track model, that contains detail of a track / song
  init(track model: Track) {
    self.albumArtUrl100 = URL(string: model.artworkUrl100 ?? "")
    self.trackName = model.name
    self.priceText = model.priceTextWithCurrency ?? (model.currency.rawValue + model.priceText)
    self.genre = model.primaryGenreName
    self.description = model.description
    self.artistName = model.artistName
    self.canPurchase = model.canPurchase
    self.attributed = model.fullAttributedDescription
    
    //set No Description as default
    var contatDescription: String = ""
    
    //append if long description exist
    if let long = model.longDescription {
      contatDescription.append(long)
    }
    
    //append if short description exist
    if let short = model.shortDescription {
      contatDescription.append("\n")
      contatDescription.append(short)
    }
    
    //appedn if description exist
    if let desc = model.description {
      contatDescription.append("\n")
      contatDescription.append(desc)
    }
    
    if contatDescription.isEmpty {
      contatDescription = "No Description."
    }
    
    self.description = contatDescription.clean()
    
    
    
  }
  
  /// Initialize from state restoration
  /// - Parameters:
  ///   - trackName: Name of Track / song
  ///   - description: Description of song
  ///   - genre: Genre of song
  ///   - artist: Artist / Singer
  ///   - price: Price of track
  ///   - albumUrlString: url string of album art
  init(
    trackName: String?,
    description: String?,
    genre: String?,
    artist: String?,
    price: String?,
    albumUrlString: String?,
    canPurchase: Bool) {
    
    self.artistName = artist
    self.genre = genre
    self.priceText = price
    self.albumArtUrl100 = URL(string: albumUrlString ?? "")
    self.trackName = trackName
    self.description = description
    self.canPurchase = canPurchase
  }
  
}

private extension String {
  /// Remove html tags
   /// - Parameter string: texts to be clean
   /// - Returns: returns cleaned texts or nik
   func clean() -> String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
   }
}
