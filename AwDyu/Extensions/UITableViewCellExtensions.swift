//
//  UITableViewCellExtensions.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/8/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit

extension UITableViewCell {
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: nil)
  }
  
  class var reuseIdentifierString: String {
     return String(describing: self)
   }
   
}
