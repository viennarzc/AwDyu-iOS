//
//  MasterViewController.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/7/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  //MARK: - Properties

  var detailViewController: DetailViewController? = nil

  var tableViewModel: MasterTableViewModel? {
    didSet {
      tableView.reloadData()
    }
  }

  //MARK: - LifeCycle


  override func viewDidLoad() {
    super.viewDidLoad()

    setupTable()

    setupSplitVC()

    fetchTrackList()
  }

  override func viewWillAppear(_ animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }

  //MARK: - Methods

  fileprivate func setupTable() {
    // Do any additional setup after loading the view.

    tableView.backgroundColor = .systemGray6
    tableView.separatorStyle = .none

    tableView.register(LastVisitSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
    tableView.register(TrackTableViewCell.nib,
      forCellReuseIdentifier: TrackTableViewCell.reuseIdentifierString)
  }

  fileprivate func setupSplitVC() {
    if let split = splitViewController {
      let controllers = split.viewControllers
      detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
    }
  }

  fileprivate func fetchTrackList() {
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

  // MARK: - Segues

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {

      if let _ = tableView.indexPathForSelectedRow,
        let vm = tableViewModel,
        let model = vm.selectedTrack {

        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController

        controller.viewModel = DetailViewModel(track: model)

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

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header")
  }

  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    view.tintColor = .clear
  }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let vm = tableViewModel, vm.shouldShowLastVisitHeader else {
      return 0
    }


    return 40
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let vm = tableViewModel else { return 0 }

    return vm.trackItems.count
  }

  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    tableViewModel?.select(row: indexPath.row)

    return indexPath
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showDetail", sender: self)
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell: TrackTableViewCell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseIdentifierString, for: indexPath) as! TrackTableViewCell

    // Inject data to table cell
    
    if let vm = tableViewModel {
      cell.trackNameLabel.text = vm.trackItems[indexPath.row].trackName
      cell.priceLabel.text = vm.trackItems[indexPath.row].priceText
      cell.genreLabel.text = vm.trackItems[indexPath.row].genre
      cell.backgroundColor = .clear
      cell.currencyLabel.text = vm.trackItems[indexPath.row].currencySymbol

      if let url = URL(string: vm.trackItems[indexPath.row].artworkUrl) {
        cell.albumArtUrl = url
      }

    }

    return cell
  }

}

