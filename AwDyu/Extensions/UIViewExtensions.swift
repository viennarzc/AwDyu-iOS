//
//  UIViewExtensions.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/10/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit

extension UIView {
  
  
  /// Add Dropshadow
  /// - Parameter scale: Set if should do rasterization scale
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.systemGray3.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = .zero
    layer.shadowRadius = 20
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
