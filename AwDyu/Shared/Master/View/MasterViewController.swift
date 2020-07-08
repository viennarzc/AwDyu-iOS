//
//  MasterViewController.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/7/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  var detailViewController: DetailViewController? = nil

  var tableViewModel: MasterTableViewModel? {
    didSet {
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    tableView.register(TrackTableViewCell.nib,
      forCellReuseIdentifier: TrackTableViewCell.reuseIdentifierString)

    if let split = splitViewController {
      let controllers = split.viewControllers
      detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
    }

    NetworkManager.shared.fetchList { (tracks, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }

      if let tracks = tracks {
        self.tableViewModel = MasterTableViewModel(tracks: tracks)
      }
    }

  }

  override func viewWillAppear(_ animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }

  // MARK: - Segues

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow, let vm = tableViewModel {
        let object = vm.trackItems[indexPath.row]
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.detailItem = object.model
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
        detailViewController = controller
      }
    }
  }

  // MARK: - Table View

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let vm = tableViewModel else { return 0 }

    return vm.trackItems.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell: TrackTableViewCell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseIdentifierString, for: indexPath) as! TrackTableViewCell

    if let vm = tableViewModel {
      cell.trackNameLabel.text = vm.trackItems[indexPath.row].trackName
      cell.priceLabel.text = vm.trackItems[indexPath.row].priceText
      cell.genreLabel.text = vm.trackItems[indexPath.row].genre
      
      if let url = URL(string: vm.trackItems[indexPath.row].artworkUrl) {
        cell.albumArtUrl = url
      }
      
    }

    return cell
  }

}

