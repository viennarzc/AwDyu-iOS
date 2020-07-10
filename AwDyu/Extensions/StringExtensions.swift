//
//  StringExtensions.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/10/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import Foundation

extension String {
  /// Remove html tags
  /// - Parameter string: texts to be clean
  /// - Returns: returns cleaned texts or nik
  func clean() -> String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }

  func toNSMutableAttributedString() -> NSMutableAttributedString? {

    let data = Data(self.utf8)
    let attributedString = try? NSMutableAttributedString(
      data: data,
      options: [.documentType: NSMutableAttributedString.DocumentType.html],
      documentAttributes: nil)


    return attributedString

  }
}
