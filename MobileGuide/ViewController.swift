//
//  ViewController.swift
//  MobileGuide
//
//  Created by Jiratip Hemwutthipan on 17/9/2562 BE.
//  Copyright © 2562 whoami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mobileListDefault : [MobileModel] = []
    var mobileList : [MobileModel] = []
//    var favList : NSMutableArray = []
    var saveFavList : [MobileModel] = []
    var favList : [MobileModel] = []
    var allMobileList : [MobileModel] = []
    var segmentState : Int = 0
    //var favDict: [Int: Bool] = [:]
    
    @IBOutlet weak var tableViewMobileList : UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var sortButton: UIButton!
    
    @IBAction func tapSortButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: "sort", message:
            "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Price low to high", style: .default, handler: { action in
            self.sortPriceLowToHigh()
            self.tableViewMobileList.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "Price high to low", style: .default, handler: { action in
            self.sortPriceHighToLow()
            self.tableViewMobileList.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "Rating", style: .default, handler: { action in
            self.sortRating()
            self.tableViewMobileList.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "Default", style: .default, handler: { action in
            self.sortDefault()
            self.tableViewMobileList.reloadData()
        }))
        //alertController.addAction(UIAlertAction(title: "1", style: .default))
        //alertController.addAction(UIAlertAction(title: "2", style: .default))
        //alertController.addAction(UIAlertAction(title: "3", style: .default))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func tabChange(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex) {
        case 0:
            // set all mobileList
            segmentState = 0
            mobileList = allMobileList
            print("ALL")
//             reloadTable
            tableViewMobileList.reloadData()
            
        case 1:
//            allMobileList = mobileList
            // filter favorite data
            segmentState = 1
            print("favourite")
            filterFav()
            // reloadTable
            tableViewMobileList.reloadData()
        
        default:
            print("unknown")
        }
    }
    
    var url :String = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        APIManager().getMobile(url: url) { [weak self] (item) in
            DispatchQueue.main.sync {
                guard let item = item else {
                    return
                }
               
                self?.mobileList = item
                //print("mobileList : " , self?.mobileList)
                
//                for i in 0...(self?.mobileList.count)! - 1{
//                    if (self?.mobileList[i].isFavourite == nil){
//                        self?.mobileList[i].isFavourite = false
//                    }
//                }
                self?.allMobileList = self!.mobileList // save mobileList on allMobileList
                self?.mobileListDefault = self!.mobileList
//                print("allMobileList : " , self?.allMobileList)
                self?.tableViewMobileList.reloadData()
            }
        }
        tableViewMobileList.rowHeight = UITableView.automaticDimension
        tableViewMobileList.estimatedRowHeight = 600
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMobileDetail",
            let viewController = segue.destination as? DetailViewController,
            let selectedMobile = sender as? MobileModel {
            viewController.mobile = selectedMobile
        }
    }
    
    func filterFav() {
        var tempFavList : [MobileModel] = []
        for i in 0...mobileList.count - 1 {
            if(mobileList[i].isFavourite == true){
                tempFavList.append(mobileList[i])
                //favList.insert(mobileList[i], at: i)
            }
            favList = tempFavList
        }
    }
    
    func sortPriceLowToHigh(){
        let sortedPrice = mobileList.sorted(by: { $0.price < $1.price })
        //print("sort price low to high \(sortedPrice)")
        allMobileList = sortedPrice
    }
    
    func sortPriceHighToLow(){
        let sortedPrice = mobileList.sorted(by: { $0.price > $1.price })
        //print("sort price high to low \(sortedPrice)")
        allMobileList = sortedPrice
    }
    
    func sortRating() {
        let sortedPrice = mobileList.sorted(by: { $0.rating > $1.rating })
        //print("sort rating high to low \(sortedPrice)")
        allMobileList = sortedPrice
    }
    
    func sortDefault() {
        //print("sort rating high to low \(sortedPrice)")
        allMobileList = mobileListDefault
    }
}
//        for i in 0...mobileList.count - 1{
//            if(mobileList[i].isFavourite == true){
////                favList = [] // set to empty
//                if (favList.count > 0) {
//                    for j in 0...favList.count - 1{
//                        if (mobileList[i].id == favList[j].id){
//                            //favList.remove(at: j)
//                            tempFavList.append(mobileList[i])
//                            // [  0, 1, 2, 3, 4, 5]
//                            // []
//                        }
//                    }
//
////                    favList.append(i)
//                } else if (favList.count == 0){
//                    tempFavList.append(mobileList[i])
//                }
//            }
//        }
//         favList = tempFavList
//    }
//
//}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (segmentState == 1){
            return favList.isEmpty ? 0 : favList.count
        } else {
            return mobileList.isEmpty ? 0 : mobileList.count
        }
        //return mobileList.isEmpty ? 0 : mobileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mobileTableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        //let mobile: MobileModel = mobileList[indexPath.item]
        var mobile: MobileModel = mobileList[indexPath.item]
        if(segmentState == 1){
            //mobile = mobileList[indexPath.item]
            print(indexPath.item)
            mobile = favList[indexPath.item]
            //print(mobile.id)
        } else {
//            mobile = mobileList[indexPath.item]
            mobile = allMobileList[indexPath.item]
            //print(mobile.id)
        }
        cell.setupUI(mobile: mobile, indexPath.item)
        cell.delegate = self
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMobileDetail", sender: mobileList[indexPath.item])
    }
}

extension ViewController: MobileTableViewCellDelegate {
    func didFavouriteButton(cell: Int) {
        //if let index = tableViewMobileList.indexPath(for: cell) {
        

            //var mobileItem = mobileList.remove(at: index.row)
            mobileList[cell].isFavourite = !mobileList[cell].isFavourite!
//            if (mobileItem.isFavourite != true) {
//                mobileItem.isFavourite = true
//            } else if (mobileItem.isFavourite == true) {
//                mobileItem.isFavourite = false
//            }
            
            //let newMobileItem = MobileModel.init(thumbImageURL: mobileItem.thumbImageURL, brand: mobileItem.brand, price: mobileItem.price, description: mobileItem.description, name: mobileItem.name, rating: mobileItem.rating, id: mobileItem.id, isFavourite: mobileItem.isFavourite!)
            //mobileList.insert(newMobileItem, at: index.row)
            tableViewMobileList.reloadData()
//        }
    }
}


