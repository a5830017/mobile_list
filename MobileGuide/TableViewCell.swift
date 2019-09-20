//
//  TableViewCell.swift
//  MobileGuide
//
//  Created by Jiratip Hemwutthipan on 17/9/2562 BE.
//  Copyright © 2562 whoami. All rights reserved.
//

import UIKit
import Kingfisher

protocol MobileTableViewCellDelegate: class {
//    func didFavouriteButton(cell: Int)
    func didFavouriteButton(cell: Int)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var mobileName: UILabel!
    @IBOutlet weak var mobileDescription: UILabel!
    @IBOutlet weak var mobilePrice: UILabel!
    @IBOutlet weak var mobileRating: UILabel!
    @IBOutlet weak var mobileImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var delegate: MobileTableViewCellDelegate?
    
    func setupUI(mobile : MobileModel, index : Int){
        mobileName.text = mobile.name
        mobileDescription.text = mobile.description
        mobilePrice.text = "Price : $" + String(mobile.price)
        mobileRating.text = "Ratting : " + String(mobile.rating)
        mobileImageView.kf.setImage(with: URL(string: mobile.thumbImageURL))
        favoriteButton.tag = index
        favoriteButton.isSelected = mobile.isFavourite ?? false
//        if mobile.isFavourite {
//            //favoriteButton.imageView =
//        } else {
//            //favoriteButton.imageView =
//        }
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        delegate?.didFavouriteButton(cell: sender.tag)
        //favoriteButton.isSelected = !favoriteButton.isSelected
//        if favoriteButton.isSelected == true {
//            favoriteButton.isSelected = false
//        } else {
//            favoriteButton.isSelected = true
//        }
//        print("tag button ", sender.tag)
//        sender.isSelected = !sender.isSelected
        
        
//        if favoriteButton.isSelected != !favoriteButton.isSelected {
//            favoriteButton.isSelected = true
//        } else {
//            favoriteButton.isSelected = false
//        }
    }
}
