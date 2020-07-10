//
//  PrimarySplitViewController.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/10/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit

class PrimarySplitViewController: UISplitViewController,
                                  UISplitViewControllerDelegate {
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
      ///setting these will allow to show split views Master and Detail when landscape mode always
      self.preferredDisplayMode = .allVisible
    }

    func splitViewController(
             _ splitViewController: UISplitViewController,
             collapseSecondary secondaryViewController: UIViewController,
             onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }
}
