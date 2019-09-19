//
//  DetailViewController.swift
//  MobileGuide
//
//  Created by Jiratip Hemwutthipan on 17/9/2562 BE.
//  Copyright © 2562 whoami. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var mobile: MobileModel!
    var mobileId : String = ""
    var mobileImageList : [ImageModel] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        mobileId = String(mobile!.id)
        let url = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(mobileId)/images/"
        APIManager().getMobileImage(url: url) { [weak self] (item) in
            DispatchQueue.main.sync {
                guard let item = item else {
                    return
                }
                self?.mobileImageList = item
                self?.collectionView.reloadData()
            }
        }
    }
    
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mobileImageList.isEmpty ? 0 : mobileImageList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mobileCollectionViewCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        let mobileModel: MobileModel = mobile
        let imgModel : ImageModel = mobileImageList[indexPath.row]
        cell.setupUI(mobile: mobileModel, img: imgModel)
        return cell
    }


}

extension DetailViewController: UICollectionViewDelegate {
    
}
