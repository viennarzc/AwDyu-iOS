//
//  UITableViewCellExtensions.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/8/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit

extension UITableViewCell {
  ///returns an instantiated nib
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: nil)
  }
  
  ///Identifier to be use for table header view
  class var reuseIdentifierString: String {
     return String(describing: self)
   }
   
}
