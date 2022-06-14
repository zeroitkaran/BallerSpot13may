//
//  LeaderBoardViewController.swift
//  BallerSpot
//
//  Created by Imac on 17/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import MBProgressHUD
class LeaderBoardViewController: UIViewController {
    
    

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var bannerCollection: UICollectionView!
    
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    //var dataLEA = Leader()
    var bannerArray = [String]()
    var allbanner = [[String:Any]]()
    var LeagueDetails = [String:Any]()
    var AllPicks = [[String:Any]]()
    var timer = Timer()
    var counter = 0
    //       var arrLeader = [LeaderBoardData]()
    var allLeader = [[String:Any]]()
    var titleStr = String()
    var showpredictdetails = false
    var rank = 1
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var points: UILabel!
    
    @IBAction func showDetails(_ sender: Any) {


    }
    //var item = [LeaderBoardData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bannerCollection.delegate = self
        self.bannerCollection.dataSource = self
        self.tableview.delegate = self
        self.tableview.dataSource = self
        // checkbanners()
        let arrayOfKeys = LeagueDetails.keys
        if arrayOfKeys.count > 0 {
            self.getPersonalLeaderBoard()
            self.titleLbl.text = "\(LeagueDetails["name"] ?? "") "+"Leader Board"
            menuBtn.isHidden = true
            backBtn.isHidden = false
            showpredictdetails = true
        }
        else{
            backBtn.isHidden = true
            showpredictdetails = true
            getLeaderBoard()
          //  checkbanners()

        }
        pageView.numberOfPages = bannerArray.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        checkbanners()
        
    }
    func checkbanners(){
        print(MyVariables.bannerData[0])
        for (index, name) in MyVariables.bannerData.enumerated()
        {
            //YOUR LOGIC....
          //  print(name)
            if name["title"] as! String == "common_leaderboard"{
            bannerArray.append(MyVariables.imageUrl + (name["image"] as! String))
           }
           else if name["title"] as! String == "league_leaderboard" {
                bannerArray.append(MyVariables.imageUrl + (name["image"] as! String))
            }
//            else{
//                 let gt: [UIImage] = loadimages("someurl&wt=json")
//                self.bannerArrayN
//            }
            print(bannerArray)//0, 1, 2, 3 ...
        }
        pageView.numberOfPages == bannerArray.count
            pageView.currentPage = 0
            DispatchQueue.main.async {
//                self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            }
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
    //MARK:- popupxib call
    @objc func showMiracle() {
        let slideVC = OverlayView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.AllPicks = self.AllPicks
        self.present(slideVC, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    //    func getBanner(){
    //
    //        // var dict = [String:String]()
    //        //        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
    //        //        dict["pin"] = "1234"
    //
    //        let headers = [
    //            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
    //            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
    //        ]
    //        MBProgressHUD.showAdded(to: self.view, animated: true)
    //        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.banners,header: headers, parameters: ["" : ""] ) {(response, status, data) in
    //            MBProgressHUD.hide(for: self.view, animated: true)
    //            if status{
    //                do{
    //                    //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
    //                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: []) as! [String : AnyObject]
    //
    //                    print("json data is--->",jsondata)
    //
    //
    //                    //  let decoder = JSONDecoder()
    //                    //let myArr1 = jsondata["Leagues"]
    //                    let myArr1 = jsondata["banners"] as! [String : AnyObject]
    //                    self.allbanner = myArr1["result_data"] as! [[String : AnyObject]]
    //                    for item in self.allbanner{
    //                        let aa = item["title"] as! String
    //                        if aa == "comman_leaderboard"{
    //
    //                            let image = item["image"] as! String
    //                            let url = "http://zeroitsolutions.com/football/uploads/banners/"
    //                            let combineurl = url + image
    //                            print(combineurl)
    //                            self.bannerimage.sd_setImage(with: URL.init(string: combineurl), completed: nil)
    //                            break
    //                        }
    //                    }
    //                    //  self.LiveNewsTableView.reloadData()
    //                }catch{
    //                    MBProgressHUD.hide(for: self.view, animated: true)
    //                    print(error.localizedDescription)
    //                }
    //            }
    //        }
    //    }
//    @IBAction func backBtnClicked(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//        Utilities.OpenMEnu(FromVC: self)
//               self.tabBarController?.tabBar.isHidden = true
//    }
    @IBAction func bckbtn1(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
       }
    @IBAction func backbtn(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
               self.tabBarController?.tabBar.isHidden = true    }
    func getPersonalLeaderBoard(){
        
        var dict = [String:String]()
        dict["league_id"] =  "\(LeagueDetails["league_id"] ?? "")"
        dict["league_type"] = "\(LeagueDetails["league_type"] ?? "")"
        dict["id"] =  "\(LeagueDetails["id"] ?? "")"
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        dict["round"] = "\(LeagueDetails["current_round"] ?? "")"

        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        print(dict)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.personalleaderboard,header: headers, parameters: dict ) { [self](response, status, data) in
            // print(response as Any)
            MBProgressHUD.hide(for: self.view, animated: true)
            if status{
                do{
                    //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary
                    
                    print("json data is--->",jsondata)
 
                    //  let decoder = JSONDecoder()
                    //let myArr1 = jsondata["Leagues"]
                    
                    guard let data:[[String : Any]] = jsondata["data"]as? [[String : Any]] else {
                        return
                    }
                    self.allLeader = data
                    for Index  in self.allLeader.indices {
                        var value = self.allLeader[Index] as [String : Any]
                        if Index == 0{
                            self.rank = 1
                            value.updateValue(self.rank, forKey: "ranking")
                        }
                        else{
                            if ("\(self.allLeader[Index]["pot_amount"] ?? "")") == ("\(self.allLeader[Index - 1]["pot_amount"] ?? "")") {
                                value.updateValue(self.rank, forKey: "ranking")
                            }
                            else{
                                self.rank = self.rank + 1
                                value.updateValue(self.rank, forKey: "ranking")
                            }
                        }
                        self.allLeader.remove(at: Index)
                        self.allLeader.insert(value, at: Index)
                    }
                    self.tableview.reloadData()
                }catch{
                    print(error.localizedDescription)
                    MBProgressHUD.hide(for: self.view, animated: true)

                }
            }
        }
    }

    
    func getLeaderBoard(){
        
        var dict = [String:String]()
        dict["league_id"] = ""
        dict["league_type"] = ""
        dict["pin"] = ""
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        
        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.leaderboard,header: headers, parameters: dict ) { [self](response, status, data) in
            // print(response as Any)
            if status{
                MBProgressHUD.hide(for: self.view, animated: true)
                do{
                    //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary
                    
                    print("json data is--->",jsondata)
                    
                    
                    //  let decoder = JSONDecoder()
                    //let myArr1 = jsondata["Leagues"]
                    
                    guard let data:[[String : Any]] = jsondata["data"]as? [[String : Any]] else {
                        return
                    }
                    
                    self.allLeader = data
                    for Index  in self.allLeader.indices {
                        var value = self.allLeader[Index] as [String : Any]
                        if Index == 0{
                            self.rank = 1
                            value.updateValue(self.rank, forKey: "ranking")
                        }
                        else{
                            if "\(self.allLeader[Index]["pot_amount"])" == "\(self.allLeader[Index - 1]["pot_amount"])" {
                                value.updateValue(self.rank, forKey: "ranking")
                            }
                            else{
                                self.rank = self.rank + 1
                                value.updateValue(self.rank, forKey: "ranking")
                            }
                        }
                        self.allLeader.remove(at: Index)
                        self.allLeader.insert(value, at: Index)
                    }
                    //                            self.allLeader = jsondata["data"] as! [[String : Any]]
                    self.tableview.reloadData()
                }catch{
                    print(error.localizedDescription)
                    MBProgressHUD.hide(for: self.view, animated: true)

                }
            }
        }
    }
    
    
    
    
}

extension LeaderBoardViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension LeaderBoardViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLeader.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bell = tableView.dequeueReusableCell(withIdentifier: "bell") as! LeaderTableViewCell
        bell.tag = indexPath.row + 1
        bell.img.layer.borderWidth = 2
        bell.img.layer.borderColor = UIColor.white.cgColor
        bell.img.clipsToBounds = true
        //        let aa = String(bell.tag)
        //        if indexPath.row == 0{
        //            bell.rankid.text = "\(rank)"
        //        }
        //        else{
        //            if (self.allLeader[indexPath.item]["pot_amount"] as! String) == (self.allLeader[indexPath.row - 1]["pot_amount"] as! String) {
        //                bell.rankid.text = "\(rank)"
        //            }
        //            else{
        //               rank = rank + 1
        //                bell.rankid.text = "\(rank)"
        //            }
        //        }
        bell.rankid.text = "\(self.allLeader[indexPath.item]["ranking"] ?? "")"
        
        //MARK:-  winner Image code:-
        
        if (self.allLeader[indexPath.item]["ranking"] as! Int == 1) {
            bell.winner.isHidden = false
        }
        else {
            bell.winner.isHidden = true
        }
        
        //                if (self.allLeader[indexPath.item]["pot_amount"] as! Int == 100) {
        //                    bell.winner.isHidden = false
        //                }
        //                else {
        //                    bell.winner.isHidden = true
        //                }
        
        let upDown = "\(self.allLeader[indexPath.item]["user_up"] ?? "")"
        if upDown == "\(1)"{
            bell.upDownImage.image = UIImage(named: "arrow_up.png")
        } else if upDown == "\(0)"{
            bell.upDownImage.image = UIImage(named: "arrow_down.png")
        } else{
            bell.upDownImage.image = UIImage(named: "ellipse.png")
        }
        
        bell.username.text =  "\(self.allLeader[indexPath.item]["username"] ?? "")"
        let name1 = "\(self.allLeader[indexPath.item]["first_name"] ?? "")"
        let last1 = "\(self.allLeader[indexPath.item]["last_name"] ?? "")"
        bell.pname.text =  "\(name1)"+" \(last1)"
        bell.viewline.fadeLowerRightLineEdge()
        bell.viewline.fadeLowerLeftLineEdge()
        if (self.allLeader[indexPath.item]["id"] as! String ==  (D_Get_LoginData?.data?.id ?? "")) {
            bell.backgroundColor = UIColor.lightGray
        }
        else {
            bell.backgroundColor = UIColor.clear
            
        }
        
        //    let count = self.allLeader[indexPath.item]
        //     bell.rankid.text = indexPath.row
        bell.point.text = "\(self.allLeader[indexPath.item]["pot_amount"] ?? "")"
        
        
        if isNsnullOrNil(object: self.allLeader[indexPath.item]["image"] as AnyObject)
        {
            
            bell.img.sd_setImage(with: URL.init(string:" " as! String), placeholderImage: UIImage(named: "dummy.png"))
            
        }
        else
        {
            
            bell.img.sd_setImage(with: URL.init(string: self.allLeader[indexPath.item]["image"] as! String), completed: nil)
        }
        
        
        
        
        
        
        return bell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if showpredictdetails {
            // show user prediction
            let userid = self.allLeader[indexPath.row]["id"] as! String
            getUserprediction(user: userid)
        }
        
    }
    func getUserprediction(user: String){
        
        var dict = [String:String]()
        dict["league_id"] = "\(LeagueDetails["league_id"] ?? "")"
        dict["league_type"] = "\(LeagueDetails["league_type"] ?? "")"
        dict["id"] = "\(LeagueDetails["id"] ?? "")"
        dict["user_id"] = user
        
        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.getUserPicksByLeague,header: headers, parameters: dict ) { [self](response, status, data) in
            // print(response as Any)
            if status{
                MBProgressHUD.hide(for: self.view, animated: true)
                do{
                    //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary
                    
                    print("json data is--->",jsondata)

                    let myArr1 = jsondata["myEnteries"] as! [String : Any]
                    self.AllPicks = myArr1["result_data"] as! [[String : Any]]
                                            self.showMiracle()
//                    let responseStatus = jsondata["status"] as! String
//                    if responseStatus == "success" {
//                        let myArr1 = jsondata["myEnteries"] as! [String : Any]
//                        AllPicks = myArr1["result_data"] as! [[String : Any]]
//                        self.showMiracle()
//
//                    }
//                    else {
//                        let alert = UIAlertController(title:  n;erry"Alert", message: "No Data Found", preferredStyle: .alert)
//
//
//                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
//                            print("You've pressed cancel")
//                        }))
//                        self.present(alert, animated: true, completion: nil)
//                    }

                }catch {
                    print(error.localizedDescription)
                }
            }
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title:  "Alert", message: "No Data Found", preferredStyle: .alert)


            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                print("You've pressed cancel")
            }))
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    func isNsnullOrNil(object : AnyObject?) -> Bool
    {
        if (object is NSNull) || (object == nil)
        {
            return true
        }
        else
        {
            return false
        }
    }
}

extension LeaderBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollection.dequeueReusableCell(withReuseIdentifier: "bannerCells", for: indexPath) as! bannercell
        cell.bannerImg.sd_setImage(with: URL.init(string: bannerArray[indexPath.row]), completed: nil)

        return cell
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
                return CGSize(width: view.frame.width, height: 1000)
             }
     }
