//
//  LastVisitSectionHeaderViewModel.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/9/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import Foundation

struct LastVisitSectionHeaderViewModel {
  ///Header text
  var text: String?

  init() {

    self.text = UserDefaultsManager.shared.getDateLastVisit()

  }
}
