//
//  MasterTableViewModel.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/8/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import Foundation

protocol TrackList {
  var trackItems: [TrackTableCellViewModel] { get set }
  
}

struct MasterTableViewModel: TrackList {
  var trackItems: [TrackTableCellViewModel]
  
  init(tracks: Tracks) {
    self.trackItems = tracks.results.map {
      TrackTableCellViewModel(model: $0) }
  }
  
}

