//
//  TrackDetail.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/9/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import Foundation

protocol TrackDetail {
  var albumArtUrl100: URL? { get set }
  var description: String? { get set }
  var artistName: String? { get set }
  var trackName: String? { get set }
  var priceText: String? { get set }
  var genre: String? { get set }
  var canPurchase: Bool { get set }
}
