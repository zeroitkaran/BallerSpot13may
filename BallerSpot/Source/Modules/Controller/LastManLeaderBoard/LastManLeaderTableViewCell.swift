//
//  LastManLeaderTableViewCell.swift
//  BallerSpot
//
//  Created by zeroit on 9/18/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class LastManLeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var counting: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastname: UILabel!
   
    @IBOutlet private weak var collectionview: UICollectionView!
    
    var allLastMens = [[String:Any]]()
    override func awakeFromNib() {
        super.awakeFromNib()
        //getLastMan()
        print(allLastMens)
//        
        // Initialization code
    }

    
    

 

    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    


}


extension LastManLeaderTableViewCell {
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
           collectionview.delegate = dataSourceDelegate
           collectionview.dataSource = dataSourceDelegate
           collectionview.tag = row
           collectionview.reloadData()
       }
    var collectionViewOffset: CGFloat {
           set { collectionview.contentOffset.x = newValue }
           get { return collectionview.contentOffset.x }
       }
}

//extension LastManLeaderTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
//        
//     
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMSLBCollectionViewCell", for: indexPath) as! LMSLBCollectionViewCell
//                return cell
//        }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return win[collectionView.tag].count
//
//        }
//        private func collectionView(collectionView: UICollectionView,cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMSLBCollectionViewCell", for: indexPath as IndexPath) as! LMSLBCollectionViewCell
//    //cell.img = allLastMan[collectionView.tag][indexPath.item]
//            cell.img.sd_setImage(with: URL(string:  win[indexPath.item] ), completed: nil)
//            //cell.img.image = win[indexPath.row]
//            return cell
//    }
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//               print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
//           }
//
//    }
//
//
//
//
//
