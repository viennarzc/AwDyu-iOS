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
  func dropShadow(scale: Bool = true, shadowColor: UIColor = .systemGray5) {
    layer.masksToBounds = false
    layer.shadowColor = shadowColor.cgColor
    layer.shadowOpacity = 0.3
    layer.shadowOffset = .zero
    layer.shadowRadius = 10
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
