//
//  PhotoCollectionViewCell.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 02/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 0.5961579623)
    }
    
    override func prepareForReuse() {
        configure(cellViewModel: nil)
    }
    
    func configure(cellViewModel: CellViewModel?){
        if let cellViewModel = cellViewModel{
            let image = cellViewModel.photoImage
            self.imageView.image = image
            self.activityIndicator.stopAnimating()
        }else{
            self.imageView.image = nil
            self.activityIndicator.startAnimating()
        }
    }

}
