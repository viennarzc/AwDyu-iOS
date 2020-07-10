//
//  TrackTableCellViewModel.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/8/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import Foundation

struct TrackTableCellViewModel {
  let priceText: String
  let artworkUrl: String
  let genre: String
  let trackName: String
  let currencySymbol: String
  
  private(set) var model: Track
  
  init(model: Track) {
    self.priceText = model.priceText
    self.artworkUrl = model.artworkUrl60 ?? ""
    self.genre = model.primaryGenreName ?? ""
    self.trackName = model.name
    self.currencySymbol = model.currencySymbol
    self.model = model
  }
}


