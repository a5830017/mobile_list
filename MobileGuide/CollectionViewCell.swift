//
//  CollectionViewCell.swift
//  MobileGuide
//
//  Created by Jiratip Hemwutthipan on 17/9/2562 BE.
//  Copyright © 2562 whoami. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailRating: UILabel!
    @IBOutlet weak var detailPrice: UILabel!
    @IBOutlet weak var mobileImageView: UIImageView!
    
    
    func setupUI(mobile : MobileModel, img : ImageModel){
        detailDescription.text = mobile.description
        detailRating.text = "Rating : " + String(mobile.rating)
        detailPrice.text = "Price : $" + String(mobile.price)
        mobileImageView.kf.setImage(with: URL(string: img.url))
    }
    
}
