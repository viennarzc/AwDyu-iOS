//
//  DetailViewModel.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/9/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import Foundation

protocol Detail {
  var albumArtUrl100: URL? { get set }
  var description: String? { get set }
  var artistName: String? { get set }
  var trackName: String? { get set }
  var priceText: String? { get set }
  var genre: String? { get set }
}

struct DetailViewModel: Detail {
  var genre: String?
  
  var artistName: String?
  
  var trackName: String?
  
  var priceText: String?
  
  var albumArtUrl100: URL?
  
  var description: String?
  
  
  /// Initialize when presenting from Master View page
  /// - Parameter model: Track model, that contains detail of a track / song
  init(track model: Track) {
    self.albumArtUrl100 = URL(string: model.artworkUrl100 ?? "")
    self.trackName = model.name
    self.priceText = "\(model.currency.rawValue)  \(model.priceText)"
    self.genre = model.primaryGenreName
    self.description = model.description
    self.artistName = model.artistName
    
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
    albumUrlString: String?) {
    
    self.artistName = artist
    self.genre = genre
    self.priceText = price
    self.albumArtUrl100 = URL(string: albumUrlString ?? "")
    self.trackName = trackName
    self.description = description
    
  }
  
}
