//
//  PictureViewController.swift
//  BallerSpot
//
//  Created by Zeroit on 11/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    let basicURL = "http://52.66.253.186/uploads/user/"
    var allSmallPic = [[String:Any]]()
    var position = Int()
    var lar = LargePictureViewController()
    @IBOutlet weak var picturecollectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picturecollectionview.delegate = self
        picturecollectionview.dataSource = self
        getSmallPic()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func imgbtn(_ sender: UIButton) {
        self.position = sender.tag
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LargePictureViewController") as! LargePictureViewController
        let imagess = allSmallPic[position]["images"] as! String
        let combineURL = basicURL + imagess
        vc.largeimgs = combineURL
        vc.positioncount = sender.tag
        vc.allSmallPic = self.allSmallPic
        self.navigationController?.pushViewController(vc, animated: true)
      }
    @objc func rgtbtn(sender : UIButton) {
        print("yes")
}
@IBAction func menubar(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
    self.tabBarController?.tabBar.isHidden = false
    }
   func getSmallPic(){

        // var dict = [String:String]()
        //        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        //        dict["pin"] = "1234"

        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]

        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.picturegallery,header: headers, parameters: ["" : ""] ) {(response, status, data) in
            // print(response as Any)
            if status{
                do{
                    //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: []) as! [String : AnyObject]

                    print("json data is--->",jsondata)


                    //  let decoder = JSONDecoder()
                    //let myArr1 = jsondata["Leagues"]
                    //self.allSmallPic = jsondata["data"] as! [String:AnyObject]
                    let myArr1 = jsondata["data"] as! [String : AnyObject]
                    let urlPath = myArr1["url"] as! String
                    self.allSmallPic = myArr1["result_data"] as! [[String : AnyObject]]
                    self.picturecollectionview.reloadData()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }

}

extension PictureViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allSmallPic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionViewCell", for: indexPath ) as! PictureCollectionViewCell
        cell.imgbtn.tag = indexPath.row

        

        let picURL = self.allSmallPic[indexPath.item]["images"] as! String
        let combineURL = basicURL + picURL
        
        //self.allSmallPic[indexPath.item]["images"]
        cell.img.sd_setImage(with: URL.init(string:  combineURL  ),completed: nil)
        
        //  lar.btnLeftUp.addTarget(self, action: #selector(self.rgtbtn(sender:)), for: .touchUpInside)
        return cell
    }
    
    
}
