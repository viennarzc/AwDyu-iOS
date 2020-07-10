//
//  TrackTableViewCell.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/7/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
  //MARK: - IBOutlets

  @IBOutlet weak var artworkImageView: UIImageView!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var container: UIView!
  @IBOutlet weak var currencyLabel: UILabel!
  
  //MARK: - Properties

  var albumArtUrl: URL? {
    didSet {
      downloadAlbumArt()
    }
  }

  //MARK: - LifeCycle

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    //we set to default to avoid images being reused in other cells
    artworkImageView.image = UIImage(systemName: "music.note")
    artworkImageView.contentMode = .center
  }


  //MARK: - Methods
  
  /// Download Album art
  private func downloadAlbumArt() {
    if let url = albumArtUrl {
      ImageLoader.downloadImage(url: url) { (image, error) in

        guard let image = image else { return }

        //should execute on main thread
        DispatchQueue.main.async {
          self.artworkImageView.image = image
          self.artworkImageView.contentMode = .scaleAspectFill
        }

      }
    }

  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}

