//
//  DetailViewController.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/7/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  //MARK: - IBOutlets

  @IBOutlet weak var albumArtHeaderImageView: UIImageView!
  @IBOutlet weak var buyButton: UIButton!
  @IBOutlet weak var albumArtBackgroundImage: UIImageView!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!

  //MARK: - Property


  var viewModel: DetailViewModel? {
    didSet {

      downloadAlbumArt()
    }
  }

  //MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    configureView()

    descriptionTextView.isEditable = false
    descriptionTextView.isScrollEnabled = true
  }


  //MARK: - Methods

  func configureView() {
    // Update the user interface.
    guard let vm = viewModel else { return }

    if let text = clean(string: vm.description) {
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
    }
    
    if let price = vm.priceText {
      buyButton.setTitle(price, for: .normal)
    }

  }

  /// Remove html tags
  /// - Parameter string: texts to be clean
  /// - Returns: returns cleaned texts or nik
  func clean(string: String?) -> String? {
    guard let string = string else { return nil }

    return string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
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

      }
    }

  }


}

