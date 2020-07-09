//
//  LastVisitTableHeaderView.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/9/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit
import SnapKit

class LastVisitSectionHeaderView: UITableViewHeaderFooterView {
  //MARK: - IBOutlets

  @IBOutlet var innerContentView: UIView!
  @IBOutlet weak var lastVisitLabel: UILabel!
  
  //MARK: - Property

  
  var viewModel: LastVisitSectionHeaderViewModel? {
    didSet {
      
    }
  }
  
  //MARK: - Init


  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    initialization()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialization()
  }
  
  //MARK: - Methods

  private func initialization() {
    Bundle.main.loadNibNamed("LastVisitSectionHeader", owner: self, options: nil)
    contentView.addSubview(innerContentView)
    innerContentView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    contentView.backgroundColor = .clear
    
    viewModel = LastVisitSectionHeaderViewModel()
    
    if let vm = viewModel,
      let text = vm.text {
      
      self.lastVisitLabel.text = "Your last visit was on " + text
    }
  }


}

