//
//  PremierManViewController.swift
//  BallerSpot
//
//  Created by zeroit on 9/18/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import MBProgressHUD

class PremierManViewController: UIViewController {

    @IBOutlet weak var bannerCollection: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    var allbanners = [[String:Any]]()
    var bannerArray = [String]()
    var timer = Timer()
    var counter = 0

    
    @IBOutlet weak var LMStittle: UILabel!
    @IBOutlet weak var potamount: UILabel!
    @IBOutlet weak var RagularSeason: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var LeagueDetails = [String:Any]()
    var allbanner = [[String:Any]]()
    var allLastMan = [[String:Any]]()
    var predicttions = [[String:Any]]()
    var  data = [PredictScoreFixtureModel?].self
    var pool_amount = String()
    var predicttedteamID = String()
    var winstatus = String()
//    var LeagueDetail = [String:Any]()
    
    var position = Int()
    var PremierManTableViewCel = PremierManTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()

        checkbanners()
        bannerCollection.delegate = self
        bannerCollection.dataSource = self
//        bannerCollection.register(UINib(nibName: "PremierManViewBannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PremierManViewBannerCollectionViewCell")
        pageView.numberOfPages = bannerArray.count
        pageView.currentPage = 0
//        DispatchQueue.main.async {
//
//        }
       LMStittle.text = "\(LeagueDetails["name"] ?? "") "+"Last Man Standing"
        tableview.delegate = self
        tableview.dataSource = self

        print(LeagueDetails)
        getLeaderBoard()



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkbanners(){
       // print(MyVariables.bannerData[0])
        for (index, name) in MyVariables.bannerData.enumerated()
        {
            //YOUR LOGIC....
           // print(name)
            if name["title"] as! String == "standings" {
                bannerArray.append(MyVariables.imageUrl + (name["image"] as! String))
            }
         //   print(bannerArray)//0, 1, 2, 3 ...
        }
        pageView.numberOfPages = bannerArray.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
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
    
    

    func getLeaderBoard(){

        var dict = [String:String]()
        dict["league_id"] = LeagueDetails["league_id"] as? String
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        dict["league_type"] = LeagueDetails["league_type"] as? String
        dict["id"] = LeagueDetails["id"] as? String
        

        //        dict["pin"] = "1234"

        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        print(dict)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.getApiRequest(controller: self, method: "\(APIList.shared.get_lastManStandingMatch)",header: headers, parameters: dict) {(response, status, data) in
            print(response as Any)
            MBProgressHUD.hide(for: self.view, animated: true)
            if status{
                MBProgressHUD.hide(for: self.view, animated: true)
                do{
                    //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary

                    print("json data is--->",jsondata)


                    //  let decoder = JSONDecoder()
                    //let myArr1 = jsondata["Leagues"]
                    guard let pool_amount = jsondata["pool_amount"] else {
                        return
                    }
                    self.pool_amount = "\(pool_amount)"
                    self.potamount.text = self.pool_amount
                    guard let standingsmatch:[[String : Any]] = jsondata["standingsmatch"]as? [[String : Any]] else {
                        return
                    }
                    self.RagularSeason.text = standingsmatch[0]["round"] as? String
                    self.allLastMan = standingsmatch
                    self.predicttions = jsondata["prediction"] as! [[String : Any]]
                    self.winstatus = jsondata["win_status"] as! String
                    guard let predicttedteam:[[String : Any]] = jsondata["predicted_team"]as? [[String : Any]] else {
                        return
                    }
                    if predicttedteam.count > 0 {
                    self.predicttedteamID = (predicttedteam[0]["predict_team_id"] as? String)!
                    }
                    self.tableview.reloadData()
                }catch{
                    MBProgressHUD.hide(for: self.view, animated: true)
                    print(error.localizedDescription)
                }
            }
        }
    }


    
    
    @IBAction func headtoheadBtn(_ sender: UIButton) {
        // showMiracle()
        self.position = sender.tag
        print(sender.tag)
        headtoheads()

        
    }
    @IBAction func headtohead(_ sender: UIButton) {
        self.position = sender.tag
        print(sender.tag)
        //       headtoheads()
        //  showMiracle()
        
        
    }
    @IBAction func bckbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }

    func headtoheads() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "HeadtoHeadViewController") as! HeadtoHeadViewController
        
        let away =  allLastMan[position]["awayTeam"] as![String:Any]
        let home = allLastMan[position]["homeTeam"] as![String:Any]
        let  homeTeamId = home["team_id"]
        let  AwayTeamId = away["team_id"]
        //   let win = allLastMan[position]["statistics"] as! [String:Any]
        viewController.awayId = AwayTeamId as! Int
        viewController.homeId = homeTeamId as! Int

        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)

        //        let transition = CATransition()
        //        transition.duration = 0.5
        //        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        //        transition.type = CATransitionType.moveIn
        //        transition.subtype = CATransitionSubtype.fromTop
        //        self.navigationController?.view.layer.add(transition, forKey: nil)
        //        self.navigationController?.pushViewController(viewController, animated: true)

    }
    
    func poststandingPrediction
    (cellindex:Int,predictteam:String) {
        var dict = [String:String]()

        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        dict["match_id"] = "\(self.allLastMan[cellindex]["fixture_id"] ?? "")"
        
//        let aString = self.RagularSeason.text
//        let newString = aString!.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
        dict["round"] = self.RagularSeason.text
        if LeagueDetails["league_type"] as? String == "private"{
            dict["league_id"] =  "\(LeagueDetails["id"] ?? "")"
        }
        else{
            dict["league_id"] =  "\(LeagueDetails["league_id"] ?? "")"
        }
        dict["league_type"] =  LeagueDetails["league_type"] as? String
        
        if predictteam == "home"{
            let HomeTeam = self.allLastMan[cellindex]["homeTeam"] as![String:Any]
            dict["predict_team_id"] = "\(HomeTeam["team_id"] ?? "")"
            dict["predicted_team"] = HomeTeam["home"] as? String
            dict["predict_flag"] =  HomeTeam["logo"] as? String
        }else{
            let AwayTeam = self.allLastMan[cellindex]["awayTeam"] as![String:Any]
            dict["predict_team_id"] = "\(AwayTeam["team_id"] ?? "")"
            dict["predicted_team"] = AwayTeam["away"] as? String
            dict["predict_flag"] =  AwayTeam["logo"] as? String
        }
        // print(dict)
        let headers = [String:String]()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.postApiRequest(controller: self, method: APIList.shared.save_standingPrediction,header: headers , parameters: dict) {(response, status,data) in
            print(response as Any)
            //                                 do{
            MBProgressHUD.hide(for: self.view, animated: true)
            guard let responseData:[String:Any] = response as? [String : Any] else{
                return
            }
            guard let status = responseData["status"]  else{
                return
            }
            
            if "\(status)" == "success"{
                self.getLeaderBoard()
            }
        }
    }
}



extension PremierManViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLastMan.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PremierManTableViewCell") as! PremierManTableViewCell
        let AwayTeam = self.allLastMan[indexPath.item]["awayTeam"] as![String:Any]
        let HomeTeam = self.allLastMan[indexPath.item]["homeTeam"] as![String:Any]
        let dateTime = self.allLastMan[indexPath.item]["event_timestamp"] as! Int

        let date = Date(timeIntervalSince1970: TimeInterval(dateTime))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "E,dd MMM yyyy"
 //Specify your format that you want
        cell.date.text = dateFormatter.string(from: date)
        cell.date.textColor = UIColor(red: 0/256, green: 84/256, blue: 43/256, alpha: 1.0)
        cell.date.font = .boldSystemFont(ofSize: 15)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.locale = NSLocale.current
        dateFormatter2.dateFormat = "H:mm" //Specify your format that you want
        cell.time.text = dateFormatter2.string(from: date)
        
        cell.lftname.text = HomeTeam["team_name"] as? String
        cell.lftimg.sd_setImage(with: URL(string: HomeTeam["logo"] as! String), completed: nil)
        cell.rgtimg.sd_setImage(with: URL(string: AwayTeam["logo"] as! String), completed: nil)
        cell.rgtname.text = AwayTeam["team_name"] as? String
        cell.headtohead.tag = indexPath.row
        let Fixtureid = "\(self.allLastMan[indexPath.item]["fixture_id"] ?? "")"

        //            cell.leftCheck.addTarget( self, action:#selector(self.lftbtn(sender:)), for: .touchUpInside)
        //           cell.rightCheck.addTarget( self, action:#selector(self.rightbtn(sender:)), for: .touchUpInside)

        if predicttions.count>0{
            for item in predicttions {

                let matchid = item["match_id"] as! String
                if matchid == Fixtureid{
                    if (item["predicted_team"] as! String) == HomeTeam["team_name"] as? String{
                        cell.leftCheck.isSelected = true
                        cell.rightCheck.isSelected = false
                    }
                    else{
                        cell.leftCheck.isSelected = false
                        cell.rightCheck.isSelected = true
                    }
                }
                else{
                    cell.leftCheck.isSelected = false
                    cell.rightCheck.isSelected = false
                }
            }
        }
        else{
            cell.leftCheck.isSelected = false
            cell.rightCheck.isSelected = false
        }
        let shortstatus = self.allLastMan[indexPath.item]["statusShort"] as! String

        //      checked
        if shortstatus == "NS" || shortstatus == "TBD"{
            cell.leftCheck.addTarget( self, action:#selector(self.lftbtn(sender:)), for: .touchUpInside)
            cell.rightCheck.addTarget( self, action:#selector(self.rightbtn(sender:)), for: .touchUpInside)
            cell.CellBackgroundView.backgroundColor = UIColor.white

        }
          else{
            cell.CellBackgroundView.backgroundColor = UIColor.lightGray
        }
        cell.leftCheck.tag = indexPath.row
        cell.rightCheck.tag = indexPath.row
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func showalert(){
        let alert = UIAlertController(title: "Alert", message: "You can\'t predict this team as You already predicted", preferredStyle: .alert)


        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            print("You've pressed cancel")
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in
            print("You've pressed the destructive")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func lftbtn(sender : UIButton){

        let AwayTeam = self.allLastMan[sender.tag]["awayTeam"] as![String:Any]
        let HomeTeam = self.allLastMan[sender.tag]["homeTeam"] as![String:Any]
        let shortstatus = self.allLastMan[sender.tag]["statusShort"] as! String
        if winstatus != "win"{
                   showalert()
                   return;
               }
        if shortstatus == "NS" || shortstatus == "TBD"{
            if predicttedteamID ==  "\(HomeTeam["team_id"] as! Int)" || predicttedteamID == "\(AwayTeam["team_id"] as! Int)"{
                     showalert()

                 }else{
                if predicttions.count>0{
                          for item in predicttions {
                              let matchid = "\(item["match_id"] as! String)"
                            for item in self.allLastMan{
                                let matchidofall = "\(item["fixture_id"] as! Int)"
                                if matchid == matchidofall {
                                    let shortstatus = item["statusShort"] as! String
                                    if shortstatus == "FT" {
                                        showalert()
                                        return
                                    }
                                }
                             }
                          }
                      }
                     
                     let indexPath = IndexPath(row:sender.tag, section: 0)
                     let currentCellTxt = tableview.cellForRow(at:indexPath ) as? PremierManTableViewCell
                     let leftlbl = ((currentCellTxt?.leftCheck)!)
                     print(leftlbl)

                     // let indexPath1 = IndexPath(row:sender.tag, section: 0)
                     //    let currentCellTxt1 = tableview.cellForRow(at:indexPath ) as? PremierManTableViewCell
                     let rightbtn = ((currentCellTxt?.rightCheck)!)
                     print(rightbtn)

                     if leftlbl.isSelected{
                         leftlbl.isSelected = false

                     }else{
                         leftlbl.isSelected = true
                         rightbtn.isSelected = false

                     }
                     poststandingPrediction(cellindex:sender.tag,predictteam: "home")
                 }
        }
      }

    @objc func rightbtn(sender : UIButton){
        let AwayTeam = self.allLastMan[sender.tag]["awayTeam"] as![String:Any]
        let HomeTeam = self.allLastMan[sender.tag]["homeTeam"] as![String:Any]
        let shortstatus = self.allLastMan[sender.tag]["statusShort"] as! String
        if winstatus != "win"{
            showalert()
            return;
        }
        
        if shortstatus == "NS" || shortstatus == "TBD"{
            if predicttedteamID ==  "\(HomeTeam["team_id"] as! Int)" || predicttedteamID == "\(AwayTeam["team_id"] as! Int)"{
                    showalert()

                }else{
                if predicttions.count>0{
                                        for item in predicttions {
                                            let matchid = "\(item["match_id"] as! String)"
                                          for item in self.allLastMan{
                                              let matchidofall = "\(item["fixture_id"] as! Int)"
                                              if matchid == matchidofall {
                                                  let shortstatus = item["statusShort"] as! String
                                                  if shortstatus == "FT" {
                                                      showalert()
                                                      return
                                                  }
                                              }

                                          }
                                        }
                                    }
                                   
                    let indexPath2 = IndexPath(row:sender.tag, section: 0)
                    let currentCellTxt2 = tableview.cellForRow(at:indexPath2 ) as? PremierManTableViewCell
                    let leftlbl = ((currentCellTxt2?.leftCheck)!)

                    //    let indexPath3 = IndexPath(row:sender.tag, section: 0)
                    //    let currentCellTxt3 = tableview.cellForRow(at:indexPath3 ) as? PremierManTableViewCell
                    let rightbtn = ((currentCellTxt2?.rightCheck)!)

                    if rightbtn.isSelected{
                        rightbtn.isSelected = false
                    }else{
                        rightbtn.isSelected = true

                        leftlbl.isSelected = false
                    }
                    poststandingPrediction(cellindex:sender.tag,predictteam: "away")

                }
        }
    
    }

}

extension PremierManViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension PremierManViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollection.dequeueReusableCell(withReuseIdentifier: "PremierManViewBannerCollectionViewCell", for: indexPath) as! PremierManViewBannerCollectionViewCell
        cell.bannerImage.sd_setImage(with: URL.init(string: bannerArray[indexPath.row]), completed: nil)

        return cell
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
                return CGSize(width: view.frame.width, height: 1000)
             }

    
}

class PremierManViewBannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    
}
