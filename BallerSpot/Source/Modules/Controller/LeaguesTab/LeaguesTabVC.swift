//
//  LeaguesTabVC.swift
//  Football_App
//
//  Created by Zero ITSolutions on 21/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import SDWebImage
import Foundation
import MBProgressHUD


class LeaguesTabVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, Storyboardable {
    var allbanner = [[String:Any]]()
    //var class1 =  PrivateLeagueViewController()
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var bannerCollection: UICollectionView!
    @IBOutlet weak var redNotiView: UIView!
    
    @IBOutlet weak var collectionMatches: UICollectionView!
    var timer = Timer()
    var counter = 0
    var bannerArray = [String]()
    var dataLeagues = LeaguesModel()
    var arrLeagues = [League]()
    var allLeagues = [[String:Any]]() // public data
    var allPrivateLeagues = [[String:Any]]() //private data
    var getmessage = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.redNotiView.layer.cornerRadius = 6
        //    self.homeimg.sd_setImage(with: URL.init(string: "http://zeroitsolutions.com/football/uploads/banners/football15.png" as! String), completed: nil)
        bannerCollection.delegate = self
        bannerCollection.dataSource = self
        collectionMatches.delegate = self
        collectionMatches.dataSource = self
        collectionMatches.register(UINib(nibName: "MatchCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MatchCollectionCellReuse")
        //self.homeimg.sd_setImage(with: URL.init(string: allbanner[7]["image"] as! String), completed: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getLeagues), name: Notification.Name("private"), object: nil)
        checkbanners()
        notification()
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.getLeagues), name: Notification.Name("private"), object: nil)
        getLeagues()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //    func getbanner (url,image)

    func checkbanners(){
//        print(MyVariables.bannerData[0])
        for (index, name) in MyVariables.bannerData.enumerated()
        {
            //YOUR LOGIC....
            print(name)
            if name["title"] as! String == "home" {
                self.bannerArray.append(MyVariables.imageUrl + (name["image"] as! String))
            }
        }
        print(self.bannerArray)//0, 1, 2, 3 ...
        pageView.numberOfPages = self.bannerArray.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }

    }
    
        @IBAction func notibtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
        self.redNotiView.isHidden = true
    }
    
    func notification(){
        var dict = [String:String]()
         dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        let headers = [
             "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
             "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
         ]

         APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.app_notify,header: headers, parameters: dict ) {(response, status, data) in

             if status{
                 do{

                     let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary

                     print("json data is--->",jsondata)
                     let decoder = JSONDecoder()
                    self.getmessage = jsondata["notification"] as! String
                    print(self.getmessage)

                     if self.getmessage == "0"{
                        self.redNotiView.isHidden = true
                        
                    }else {
                            self.redNotiView.isHidden = false
                         }
                     
//                     self.collectionMatches.reloadData()
                 }catch{
                     print(error.localizedDescription)
                 }
             }
         }
    }
    
    @objc func getLeagues(){

        var dict = [String:String]()
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
       let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]

        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.getLeagues,header: headers, parameters: dict ) {(response, status, data) in

            if status{
                do{

                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary

                    print("json data is--->",jsondata)
                    self.allLeagues = jsondata["Leagues"] as! [[String : Any]]
                    self.allPrivateLeagues  = jsondata["Private"] as! [[String:Any]]

                    if self.allPrivateLeagues.count > 0{

                        for item in self.allPrivateLeagues {
                            self.allLeagues.append(item)
                        }
                    }
                    self.collectionMatches.reloadData()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
     @IBAction func menuClick_action(_ sender: Any) {
        print("ASfdgsdag")

    }

    @objc func changeImage() {

        if counter < bannerArray.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        }
        else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == collectionMatches{
            return 1
        }
        else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionMatches{
            return allLeagues.count
        }
        else{
            return bannerArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionMatches) {
            let cell = collectionMatches.dequeueReusableCell(withReuseIdentifier: "MatchCollectionCellReuse", for: indexPath) as! MatchCollectionCell

            print("\(self.allLeagues[indexPath.item]["logo"] as! String)")
            cell.imgLogo.sd_setImage(with: URL.init(string: self.allLeagues[indexPath.item]["logo"] as! String), completed: nil)
            cell.lblLeagueName.text = "\(self.allLeagues[indexPath.item]["name"] ?? "")"
            cell.userentry.text = "\(self.allLeagues[indexPath.item]["users"] ?? "")"
            let leagueType = "\(self.allLeagues[indexPath.item]["league_type"] ?? "" )"

            if leagueType == "private"
            {
                let type = "\(self.allLeagues[indexPath.item]["league_type"] ?? "" )"
                cell.privatelbl.text = type.uppercased()
            }
            else{
                cell.privatelbl.isHidden = true
            }

            cell.viewLowerLeft.createGradientLayer(myColor1: .white, myColor2: UIColor.init(white: 0.5, alpha: 0.5))
            if indexPath.row%2 == 0
            {
                cell.viewLowerLeft.isHidden = true
                cell.viewLowerRight.isHidden = false
                cell.viewRightLine.isHidden = false
            }
            else
            {
                cell.viewLowerLeft.isHidden = false
                cell.viewLowerRight.isHidden = true
                cell.viewRightLine.isHidden = true
            }
            if collectionMatches.numberOfItems(inSection: 0) % 2 == 0
            {
                if indexPath.row == collectionMatches.numberOfItems(inSection: 0) - 1 || indexPath.row == collectionMatches.numberOfItems(inSection: 0) - 2
                {
                    cell.viewLowerRight.isHidden = true
                    cell.viewLowerLeft.isHidden = true
                    if indexPath.row%2 == 0
                    {
                        cell.viewRightLine.isHidden = false
                    }
                    else
                    {
                        cell.viewRightLine.isHidden = true
                    }
                }
            }
            else
            {
                if indexPath.row == collectionMatches.numberOfItems(inSection: 0) - 1
                {
                    cell.viewLowerRight.isHidden = true
                    cell.viewLowerLeft.isHidden = true
                    if indexPath.row%2 == 0
                    {
                        cell.viewRightLine.isHidden = false
                    }
                    else
                    {
                        cell.viewRightLine.isHidden = true
                    }
                }
            }
            if indexPath.row == 0 {
                cell.viewRightLine.fadeRightLineEdge()
            }
            cell.viewLowerRight.fadeLowerRightLineEdge()
            cell.viewLowerLeft.fadeLowerLeftLineEdge()

            cell.viewRightLine.clipsToBounds = true
            return cell
        }
        else{


            let cell2 = bannerCollection.dequeueReusableCell(withReuseIdentifier: "bannerCollection1", for: indexPath) as! bannerCollection1
           // cell2.banner.contentMode = UIView.ContentMode.scaleAspectFill
//            cell2.contentMode = UIView.ContentMode.scaleAspectFill
//            cell2.clipsToBounds = true
            cell2.banner.sd_setImage(with: URL.init(string:bannerArray[indexPath.row]), completed: nil)
            return cell2

        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionMatches{
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MatchTypeVC") as! MatchTypeVC
        vc.LeagueDetail = self.allLeagues[indexPath.item]

        vc.allbanners = self.allbanner
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              if collectionView == collectionMatches {
        return CGSize.init(width: collectionMatches.bounds.width/2, height: collectionMatches.bounds.width/2)
                } else {
                   return CGSize(width: self.bannerCollection.bounds.width, height: self.bannerCollection.bounds.height)
                }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets.init(top: 0.1, left: 0.0, bottom: 0.1, right: 0.0)
    }
    @IBAction func BtnActionOpenSideMenu(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}
