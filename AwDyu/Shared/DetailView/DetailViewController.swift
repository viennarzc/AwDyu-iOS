//
//  DetailViewController.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/7/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  //MARK: - Restore State Encode Keys

  struct kEncodeKey {
    static let artistName = "ArtistName"
    static let trackName = "TrackName"
    static let genre = "Genre"
    static let albumArtUrl = "AlbumArtURL"
    static let description = "Description"
    static let price = "Price"
    static let longDescription = "Description"
    static let canPurchase = "CanPurchase"
  }

  //MARK: - IBOutlets

  @IBOutlet weak var albumArtHeaderImageView: UIImageView!
  @IBOutlet weak var buyButton: UIButton!
  @IBOutlet weak var albumArtBackgroundImage: UIImageView!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!

  //MARK: - Property

  private var trackName: String?

  var viewModel: DetailViewModel? {
    didSet {
      downloadAlbumArt()
    }
  }

  //MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    buyButton.setTitle("Not Purchaseable", for: .disabled)
    descriptionTextView.isEditable = false
    descriptionTextView.isScrollEnabled = true
    
    configureView()
  }


  //MARK: - Methods

  func configureView() {
    // Update the user interface.
    guard let vm = viewModel else { return }
    
  
    if let text = vm.description {
      descriptionTextView.text = text
    }

    if let artist = vm.artistName {
      artistNameLabel.text = artist
    }

    if let genre = vm.genre {
      genreLabel.text = genre
    }

    if let trackName = vm.trackName {
      trackNameLabel.text = trackName
      navigationItem.title = trackName
    }

    if let price = vm.priceText {
      buyButton.setTitle(price, for: .normal)
    }


    buyButton.isEnabled = vm.canPurchase
    buyButton.backgroundColor = vm.canPurchase ? .systemIndigo : .systemGray2

  }

  /// Presents Purchase alert
  private func presentPurchaseAlert() {
    guard let vm = viewModel,
      let trackName = vm.trackName,
      let price = vm.priceText else { return }

    let alertVC = UIAlertController(
      title: "Track Purchase",
      message: "Awesome! Thank you for purchasing \(trackName) for \(price)",
      preferredStyle: .alert)

    let dismissAction = UIAlertAction(title: "Nice!", style: .default) { (_) in
      alertVC.dismiss(animated: true, completion: nil)
    }
    alertVC.addAction(dismissAction)

    present(alertVC, animated: true, completion: nil)
  }

  func restoreItemInterface(_ activityUserInfo: [AnyHashable: Any]) {
    let trackName = activityUserInfo[kEncodeKey.trackName] as? String
    let albumArtUrlString = activityUserInfo[kEncodeKey.albumArtUrl] as? String
    let genre = activityUserInfo[kEncodeKey.genre] as? String
    let description = activityUserInfo[kEncodeKey.description] as? String
    let price = activityUserInfo[kEncodeKey.price] as? String
    let artist = activityUserInfo[kEncodeKey.artistName] as? String
    let canPurchase = activityUserInfo[kEncodeKey.canPurchase] as! Bool

    self.viewModel = DetailViewModel(
      trackName: trackName,
      description: description,
      genre: genre,
      artist: artist,
      price: price,
      albumUrlString: albumArtUrlString,
      canPurchase: canPurchase)

  }

  //MARK: - Actions

  @IBAction func didTapBuyButton(_ sender: Any) {
    presentPurchaseAlert()
  }


  //MARK: - State Restoration

  override func encodeRestorableState(with coder: NSCoder) {
    super.encodeRestorableState(with: coder)

    guard let vm = viewModel else { return }

    if let trackName = vm.trackName {
      coder.encode(trackName, forKey: kEncodeKey.trackName)
    }

    if let url = vm.albumArtUrl100 {
      coder.encode(url.absoluteString, forKey: kEncodeKey.albumArtUrl)
    }

    if let artist = vm.artistName {
      coder.encode(artist, forKey: kEncodeKey.artistName)
    }

    if let genre = vm.genre {
      coder.encode(genre, forKey: kEncodeKey.genre)
    }

    if let price = vm.priceText {
      coder.encode(price, forKey: kEncodeKey.price)
    }

    if let description = vm.description {
      coder.encode(description, forKey: kEncodeKey.description)
    }
    
    coder.encode(vm.canPurchase, forKey: kEncodeKey.canPurchase)

  }

  override func decodeRestorableState(with coder: NSCoder) {
    super.decodeRestorableState(with: coder)

    if let trackName = coder.decodeObject(forKey: kEncodeKey.trackName) as? String {
      self.trackNameLabel.text = trackName
    }

  }

}

extension DetailViewController {
  //MARK: - NSUser Activity

  /** Create the user activity type.
         Note: The activityType string loaded below must be included in your Info.plist file under the `NSUserActivityTypes` array.
             More info: https://developer.apple.com/documentation/foundation/nsuseractivity
     */
  class var activityType: String {
    let activityType = ""

    // Load our activity type from our Info.plist.
    if let activityTypes = Bundle.main.infoDictionary?["NSUserActivityTypes"] {
      if let activityArray = activityTypes as? [String] {
        return activityArray[0]
      }
    }

    return activityType
  }


  /// Add information as activity that will be save for state restoration
  /// - Parameter activity: User Activity
  func applyDetailActivity(_ activity: NSUserActivity) {

    guard let vm = viewModel else { return }

    if let name = vm.trackName {
      let trackName: [String: String] = [kEncodeKey.trackName: name]
      activity.addUserInfoEntries(from: trackName)
    }

    if let url = vm.albumArtUrl100 {
      let url: [String: String] = [kEncodeKey.albumArtUrl: url.absoluteString]
      activity.addUserInfoEntries(from: url)
    }

    if let artist = vm.artistName {
      let artist: [String: String] = [kEncodeKey.artistName: artist]
      activity.addUserInfoEntries(from: artist)
    }

    if let genre = vm.genre {
      let genre: [String: String] = [kEncodeKey.genre: genre]
      activity.addUserInfoEntries(from: genre)
    }

    if let price = vm.priceText {
      let price: [String: String] = [kEncodeKey.price: price]
      activity.addUserInfoEntries(from: price)
    }

    if let description = vm.description {
      let description: [String: String] = [kEncodeKey.description: description]
      activity.addUserInfoEntries(from: description)
    }

  }

  // Used to construct an NSUserActivity instance for state restoration.
  var detailActivity: NSUserActivity {
    let userActivity = NSUserActivity(activityType: DetailViewController.activityType)
    userActivity.title = "Restore Item"
    applyDetailActivity(userActivity)
    return userActivity
  }

}

// MARK: - UIUserActivityRestoring

extension DetailViewController {

  override func updateUserActivityState(_ activity: NSUserActivity) {
    super.updateUserActivityState(activity)
    applyDetailActivity(activity)
  }

  override func restoreUserActivityState(_ activity: NSUserActivity) {
    super.restoreUserActivityState(activity)

    // Check if the activity is of our type.
    if activity.activityType == DetailViewController.activityType {
      // Get the user activity data.
      if let activityUserInfo = activity.userInfo {
        restoreItemInterface(activityUserInfo)
      }
    }
  }

}

//MARK: - Image Loadable


extension DetailViewController: ImageLoadable {
  func downloadAlbumArt() {
    guard let vm = viewModel,
      let url = vm.albumArtUrl100
      else { return }

    ImageLoader.downloadImage(url: url) { (image, error) in

      guard let image = image else { return }

      //should execute on main thread
      DispatchQueue.main.async {
        self.albumArtBackgroundImage.image = image
        self.albumArtHeaderImageView.image = image
        self.albumArtHeaderImageView.contentMode = .scaleAspectFill

      }
    }

  }


}

