//
//  UpcomingMoviesCollectionViewCell.swift
//  MovieApp
//
//  Created by Achem Samuel on 9/22/19.
//

import UIKit
import Kingfisher

class UpcomingMoviesCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifer = "cell"
    @IBOutlet weak var posterImageView: UIImageView!
    
    func setupView(url : URL) {
        posterImageView.kf.setImage(with: url)
    }
}
