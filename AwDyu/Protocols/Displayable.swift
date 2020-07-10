//
//  Displayable.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/8/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import Foundation

protocol Displayable {
  var priceText: String { get }
  ///track name
  var name: String { get }
  ///price with currency
  var priceTextWithCurrency: String? { get }
  ///currency symbol representatoin
  var currencySymbol: String { get }
  ///some items have no price
  var hasPrice: Bool { get }
  ///converted from string with html tags to nsmutable string
  var attributedDescription: NSMutableAttributedString? { get }
  ///converted from string with html tags to nsmutable string
  var attributedShortDescription: NSMutableAttributedString? { get }
  ///converted from string with html tags to nsmutable string
  var attributedLongDescription: NSMutableAttributedString? { get }
  ///combines description,short, and long
  var fullAttributedDescription: NSMutableAttributedString? { get }
}
