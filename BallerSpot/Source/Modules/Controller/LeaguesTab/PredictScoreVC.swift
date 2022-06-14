//
//  PredictScoreVC.swift
//  Football_App
//
//  Created by Zero ITSolutions on 22/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import MBProgressHUD

enum TextFieldType {
    case home
    case away
}

class PredictScoreVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var roundtableview: UITableView!
    @IBOutlet weak var rankviewheight: NSLayoutConstraint!
    @IBOutlet weak var leadertableview: UITableView!
    @IBOutlet weak var uperview: UIView!
    @IBOutlet weak var rankPlayerPoints: UIView!
    @IBOutlet weak var matchLeaderBtn: UIView!
    @IBOutlet weak var upperheight: NSLayoutConstraint!
    @IBOutlet weak var titlename: UILabel!
    @IBOutlet weak var potamount: UILabel!
    @IBOutlet weak var userentry: UILabel!
    @IBOutlet weak var roundBtnlbl: UILabel!
    @IBOutlet weak var matchBtnWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundBtn: UIButton!
    @IBOutlet weak var matchBtn: UIButton!
    @IBOutlet weak var leaderBtn: UIButton!
    @IBOutlet weak var tblScore: UITableView!
    @IBOutlet weak var NoDataFound: UILabel!
    var LeagueDetail = [String:Any]()
    var allpridict = [[String:Any]]()
    var pridictData = [[String:Any]]()
    var selectRound = String()
    var allRounds = [String]()
    var positions = Int()
    var prictleft = String()
    var pridictrht = String()
    var allLeaderl = [[String:Any]]()
    var roundstatus = false
    var AllPicks = [[String:Any]]()
    var LeagueDetails = [String:Any]()
   // var showpredictdetails = false
    var allLeader = [[String:Any]]()

    @IBOutlet weak var viewPoolAmount: UIView!
    var scoreTableCel = ScoreTableCell()

    var selectedId = ""
    var arrFixtures = [PredictScoreFixtureModel]()
 
    var TimerArr : [String] = ["2021-01-012T18:43:05+05:30","2021-01-012T18:45:40+05:30","2021-01-012T18:59:34+05:30"]
    //    var arrPredictionData = [(data : String, sender : UITextField)]()
    var leftHour = Int()
    var rank = 1
    var allLastMan = [[String:Any]]()
    var position = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        getRoundUsers()
        //tblScore.isHidden = false
        leadertableview.isHidden = true
        rankviewheight.constant = 0
        upperheight.constant = 0
        tblScore.delegate = self
        tblScore.dataSource = self
        leadertableview.delegate = self
        leadertableview.dataSource = self
        self.matchBtn.layer.cornerRadius = 8
        self.leaderBtn.layer.cornerRadius = 8
        NoDataFound.isHidden = true

        titlename.text = LeagueDetail["name"] as? String
        if roundstatus {
            uperview.isHidden = true
            rankPlayerPoints.isHidden = false
            roundtableview.isHidden = true
            getmatches()
        }
        else{
            upperheight.constant = 36
            uperview.isHidden = false
            rankPlayerPoints.isHidden = true
            roundtableview.isHidden = false
            roundtableview.delegate = self
            roundtableview.dataSource = self
            tblScore.isHidden = true
            getroundsdetails()
        }

//        userentry.text = "\(self.LeagueDetail["users"] ?? "")"


        
        tblScore.register(UINib(nibName: "ScoreTableCell", bundle: nil), forCellReuseIdentifier: "ScoreTableCellReuse")
        initialSetup()
        //getTeams()
        
        
    }

    
    
    
    func initialSetup(){

        viewPoolAmount.layer.cornerRadius = self.viewPoolAmount.frame.size.height/2
        viewPoolAmount.clipsToBounds = true
    }
    
    @IBAction func leaderboard(_ sender: Any) {
        self.showLeaderBoard()
    }
    
    func showLeaderBoard() {
        tblScore.isHidden = true
        leadertableview.isHidden = false
        self.getLeaderBoard()
        rankviewheight.constant = 36
        leaderBtn.backgroundColor = UIColor(red: 51.0/255.0, green: 149.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        matchBtn.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func matches(_ sender: Any) {
        leadertableview.isHidden = true
        tblScore.isHidden = false
        rankviewheight.constant = 0
        self.leadertableview.reloadData()
        matchBtn.backgroundColor = UIColor(red: 51.0/255.0, green: 149.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        leaderBtn.backgroundColor = UIColor.lightGray
    }
    
    
    @IBAction func roundbtn(_ sender: Any) {
        upperheight.constant = 36
        uperview.isHidden = false
        rankPlayerPoints.isHidden = true
        matchLeaderBtn.isHidden = true
        roundtableview.isHidden = false
        roundtableview.delegate = self
        roundtableview.dataSource = self
        tblScore.isHidden = true
        leadertableview.isHidden = true


        getRounds()
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
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
               PresentationController(presentedViewController: presented, presenting: presenting)
           }
    func getLeaderBoard(){

        var dict = [String:String]()

        dict["league_id"] =  "\(LeagueDetail["league_id"] ?? "")"
        dict["league_type"] = "\(LeagueDetail["league_type"] ?? "")"
        dict["id"] =  "\(LeagueDetail["id"] ?? "")"
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        //        let aString = selectRound
        //        let newString = aString.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
        dict["round"] = selectRound


        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.leaderboard,header: headers, parameters: dict ) {(response, status, data) in
            print(response as Any)
            MBProgressHUD.hide(for: self.view, animated: true)
            if status{
                do{
                    //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary
                    self.NoDataFound.isHidden = true
                    print("json data is--->",jsondata)


                    //  let decoder = JSONDecoder()
                    //let myArr1 = jsondata["Leagues"]
                    let responsestatus = jsondata["status"] as! String

                    if responsestatus == "Success"  {
                        self.allLeaderl = jsondata["data"] as! [[String : Any]]
                        for Index  in self.allLeaderl.indices {
                            var value = self.allLeaderl[Index] as [String : Any]
                            if Index == 0{
                                self.rank = 1
                                value.updateValue(self.rank, forKey: "ranking")
                            }
                            else{
                                if "\(self.allLeaderl[Index]["pot_amount"])" == "\(self.allLeaderl[Index - 1]["pot_amount"])" {
                                    value.updateValue(self.rank, forKey: "ranking")
                                }
                                else{
                                    self.rank = self.rank + 1
                                    value.updateValue(self.rank, forKey: "ranking")
                                }
                            }
                            self.allLeaderl.remove(at: Index)
                            self.allLeaderl.insert(value, at: Index)
                        }
                        self.leadertableview.reloadData()
                    }else{
                        self.NoDataFound.isHidden = false
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }else{
                self.NoDataFound.isHidden = false
            }
        }
    }
    //    func getLeaderBoardd(){
    //
    //                var dict = [String:String]()
    //                dict["league_id"] = "\(LeagueDetail["league_id"] ?? "")"
    //        dict["league_type"] = "public"
    //                //        dict["pin"] = "1234"
    //
    //               let headers = [
    //                    "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
    //                    "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
    //                ]
    //        MBProgressHUD.showAdded(to: self.view, animated: true)
    //        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.leaderboard,header: headers, parameters: ["" : ""] ) {(response, status, data) in
    //                   // print(response as Any)
    //                    if status{
    //                        MBProgressHUD.hide(for: self.view, animated: true)
    //                        do{
    //    //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
    //                            let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary
    //
    //                                               print("json data is--->",jsondata)
    //                          //  self.tblScore.isHidden = false
    //
    //                          //  let decoder = JSONDecoder()
    //                           //let myArr1 = jsondata["Leagues"]
    //
    //
    //                            self.allLeaderl = jsondata["data"] as! [[String : Any]]
    //                            self.leadertableview.reloadData()
    //                        }catch{
    //                            MBProgressHUD.hide(for: self.view, animated: true)
    //                            print(error.localizedDescription)
    //                        }
    //                    }
    //                }
    //            }

    
    func getRounds(){

        var dict = [String:String]()
        //   dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        // let dict = ["user_id": "\(D_Get_LoginData?.data?.id ?? "")" ]
        // let dict = ["user_id": "\(D?.data?.id ?? "")" ]
        dict["league_id"] = "\(LeagueDetail["league_id"] ?? "")"
        //        dict["pin"] = "1234"
        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.getApiRequest(controller: self, method:APIList.shared.app_getrounds,header: headers, parameters: dict ) {(response, status, data) in
            // print(response as Any)
            if status{
                MBProgressHUD.hide(for: self.view, animated: true)
                do{
                    //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary

                    print("json data is--->",jsondata)


                    //  let decoder = JSONDecoder()
                    let myArr1 = jsondata["rounds"] as! [String:Any]


                    self.allRounds = myArr1["result_data"] as! [String]


                    self.roundtableview.reloadData()

                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }

    
    func getroundsdetails(){
        //http://zeroitsolutions.com/football/index.php/app_getroundsdetails
        var dict = [String:String]()
        //     var lid =  LeagueDetail["league_id"]
        dict["league_id"] = "\(LeagueDetail["league_id"] ?? "")"


        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.getroundsdetails,header: headers, parameters: dict ) { [self](response, status, data) in
            // print(response as Any)
            MBProgressHUD.hide(for: self.view, animated: true)
            if status{
                do{

                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary

                    print("json data is--->",jsondata)

                    let myArr1 = jsondata["rounds"] as! [String:Any]

                    self.selectRound = "\((myArr1["current"] as! [String])[0])"
                    print("\((myArr1["current"] as! [String])[0])")
                    print(self.selectRound)
                  //  self.titlename.text = "\(self.selectRound)"
                    self.roundBtnlbl.text = self.selectRound
                    self.roundtableview.isHidden = true
                    self.rankPlayerPoints.isHidden = false
                    self.matchLeaderBtn.isHidden = false
                    self.tblScore.isHidden = false
                    self.getRoundUsers()
                    self.getmatches()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func getRoundUsers(){

        var dict = [String:String]()

        dict["round"] = selectRound

        if LeagueDetail["league_type"] as? String == "private"{
            dict["league_id"] =  "\(LeagueDetail["id"] ?? "")"
        }
        else{
            dict["league_id"] =  "\(LeagueDetail["league_id"] ?? "")"
        }
        dict["league_type"] =  LeagueDetail["league_type"] as? String

        //        dict["pin"] = "1234"
        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.getApiRequest(controller: self, method:APIList.shared.getRoundUsers,header: headers, parameters: dict ) {(response, status, data) in
            // print(response as Any)
            if status{
                MBProgressHUD.hide(for: self.view, animated: true)
                do{
                    //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary

                    print("json data is--->",jsondata)
                    if jsondata["status"] as! String == "Success"{
                        self.userentry.text = "\(jsondata["users"] as! Int)"
                    }

                    //                    //  let decoder = JSONDecoder()
                    //                    let myArr1 = jsondata["rounds"] as! [String:Any]
                    //
                    //
                    //                    self.allRounds = myArr1["result_data"] as! [String]
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    


    
    
    
    func postPrediction(status:String) {
        var dict = [String:String]()
        dict["away_team_estimate"] =  self.pridictrht
        dict["home_team_estimate"] = self.prictleft
        dict["match_id"] = (allpridict[self.positions]["fixture_id"] as! String)
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        dict["is_predict"] =  "1"
        //let aString = selectRound
        //  let newString = aString.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
        dict["round"] = selectRound
        dict["prediction_type"] =  LeagueDetail["league_type"] as? String
        dict["status"] =  status
        if LeagueDetail["league_type"] as? String == "private"{
            dict["league_id"] =  "\(LeagueDetail["id"] ?? "")"
        }
        else{
            dict["league_id"] =  "\(LeagueDetail["league_id"] ?? "")"
        }
      //  print(dict)
        let headers = [String:String]()
        //  MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.postApiRequest(controller: self, method: APIList.shared.savePredictions,header: headers , parameters: dict) {(response, status,data) in
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
                self.updatepredcitionlocalvalues()
            }
        }

    }
    
    func updatepredcitionlocalvalues(){
        var updatedone = false
         if pridictData.count>0{
             for Index  in self.pridictData.indices{
                var value = self.pridictData[Index] as [String : Any]
                      let matchid = value["match_id"] as! String
                         if matchid == (allpridict[self.positions]["fixture_id"] as! String){
                        value.updateValue(self.prictleft, forKey: "home_team_score")
                        value.updateValue(self.pridictrht, forKey: "away_team_score")
                        self.pridictData.remove(at: Index)
                        self.pridictData.insert(value, at: Index)
                        updatedone = true
                        self.tblScore.reloadData()
                        
                }
            }
            if updatedone != true {
                var dict = [String:String]()
                     dict["away_team_score"] =  self.pridictrht
                     dict["home_team_score"] = self.prictleft
                     dict["match_id"] = (allpridict[self.positions]["fixture_id"] as! String)
                     dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
                     dict["is_predict"] =  "1"
                     //let aString = selectRound
                     //  let newString = aString.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
                     dict["round"] = selectRound
                     dict["prediction_type"] =  LeagueDetail["league_type"] as? String
                     dict["status"] =  "goal"
                     if LeagueDetail["league_type"] as? String == "private"{
                         dict["league_id"] =  "\(LeagueDetail["id"] ?? "")"
                     }
                     else{
                         dict["league_id"] =  "\(LeagueDetail["league_id"] ?? "")"
                     }
                self.pridictData.append(dict)
                self.tblScore.reloadData()
            }
        }
         else{
                            var dict = [String:String]()
                                dict["away_team_score"] =  self.pridictrht
                                dict["home_team_score"] = self.prictleft
                                dict["match_id"] = (allpridict[self.positions]["fixture_id"] as! String)
                                dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
                                dict["is_predict"] =  "1"
                                //let aString = selectRound
                                //  let newString = aString.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
                                dict["round"] = selectRound
                                dict["prediction_type"] =  LeagueDetail["league_type"] as? String
                                dict["status"] =  "goal"
                                if LeagueDetail["league_type"] as? String == "private"{
                                    dict["league_id"] =  "\(LeagueDetail["id"] ?? "")"
                                }
                                else{
                                    dict["league_id"] =  "\(LeagueDetail["league_id"] ?? "")"
                                }
                            self.pridictData.append(dict)
                            self.tblScore.reloadData()
        }

        
    }
    
    func getmatchesafterprediction(){
           var dict = [String:String]()
           dict["league_id"] = LeagueDetail["league_id"] as? String
           let aString = selectRound
           let newString = aString.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
           dict["round"] = newString
           dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
           dict["league_type"] = LeagueDetail["league_type"] as? String
           
           dict["id"] = LeagueDetail["id"] as? String

           let headers = [
               "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
               "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
           ]

           APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.getmatches,header: headers, parameters: dict ) {(response, status, data) in
               if status{

                   do{
                       let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! [String : AnyObject]
                       self.NoDataFound.isHidden = false
                       print(jsondata)
                       if jsondata["status"] as! String != "error"{
                           print("json data is--->",jsondata)
                           let myArr1 = jsondata["data"] as! [String:AnyObject]
                           self.potamount.text = "\(myArr1["pool_amount"]!)"
                           self.allpridict = myArr1["result_data"] as! [[String:AnyObject]]
                           self.pridictData = myArr1["prediction_data"] as! [[String:AnyObject]]

                           self.tblScore.reloadData()
                       }
                       else{

                           self.showLeaderBoard()
                           self.matchBtnWidthConstraint.constant = -30
                           //   self.getLeaderBoardd()
                       }
                   }catch{
                       print(error.localizedDescription)
                   }
               }else{
                   self.NoDataFound.isHidden = true
               }
           }
       }
    
    func getmatches(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        var dict = [String:String]()
        dict["league_id"] = LeagueDetail["league_id"] as? String
        let aString = selectRound
        let newString = aString.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
        dict["round"] = newString
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        dict["league_type"] = LeagueDetail["league_type"] as? String
        
        dict["id"] = LeagueDetail["id"] as? String

        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]

        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.getmatches,header: headers, parameters: dict ) {(response, status, data) in
            if status{

                do{
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! [String : AnyObject]
                    self.NoDataFound.isHidden = true
                    print(jsondata)
                    if jsondata["status"] as! String != "error"{
                        print("json data is--->",jsondata)
                        let myArr1 = jsondata["data"] as! [String:AnyObject]
                        self.potamount.text = "\(myArr1["pool_amount"]!)"
                        self.allpridict = myArr1["result_data"] as! [[String:AnyObject]]
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"

                        self.allpridict.sort(by: {(dateFormatter.date(from: $0["date"] as! String))!.timeIntervalSinceNow < (dateFormatter.date(from: $1["date"] as! String))!.timeIntervalSinceNow})

                        self.pridictData = myArr1["prediction_data"] as! [[String:AnyObject]]
                        MBProgressHUD.hide(for: self.view, animated: true)

                        self.tblScore.reloadData()
                    }
                    else{
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.NoDataFound.isHidden = false
                        self.showLeaderBoard()
                        self.matchBtnWidthConstraint.constant = -30
                        //   self.getLeaderBoardd()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }else{
                self.NoDataFound.isHidden = true
            }
        }
    }
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == roundtableview{
            return allRounds.count
        }
        else if tableView == leadertableview{
            return allLeaderl.count
        }
        else{
            return allpridict.count
            
        }
        // return self.arrFixtures.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
            if tableView == roundtableview {
                let cell = roundtableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RoundTableViewCell
                cell.round1.text = self.allRounds[indexPath.row]
                return cell
            }
            else if tableView == leadertableview{
                let bell = tableView.dequeueReusableCell(withIdentifier: "bell") as! LeaderTableViewCell

    //            bell.tag = indexPath.row + 1
    //            let aa = String(bell.tag)
    //            bell.rankid.text = aa
    //            if (self.allLeaderl[indexPath.item]["ranking"] as! Int == 1) {
    //                bell.winner.isHidden = false
    //            }
    //            else {
    //                bell.winner.isHidden = true
    //            }
                let upDown = "\(self.allLeaderl [indexPath.item]["user_up"] ?? "")"
                if upDown == "\(1)"{
                    bell.upDownImage.image = UIImage(named: "arrow_up.png")
                } else if upDown == "\(0)"{
                    bell.upDownImage.image = UIImage(named: "arrow_down.png")
                } else{
                    bell.upDownImage.image = UIImage(named: "ellipse.png")
                }
                bell.userId.text = "\(self.allLeaderl[indexPath.item]["username"] ?? "")"
                bell.rankid.text = "\(self.allLeaderl[indexPath.item]["ranking"] ?? "")"
                bell.pname.text = "\(self.allLeaderl[indexPath.item]["first_name"] ?? "")"
                bell.point.text = "\(self.allLeaderl[indexPath.item]["pot_amount"] ?? "")"
                bell.viewline.fadeLowerRightLineEdge()
                bell.viewline.fadeLowerLeftLineEdge()
                if isNsnullOrNil(object: self.allLeaderl[indexPath.item]["image"] as AnyObject)
                {
                    bell.img.sd_setImage(with: URL.init(string:" " ), placeholderImage: UIImage(named: "dummy.png"))
                }
                else
                {
                    bell.img.sd_setImage(with: URL.init(string: self.allLeaderl[indexPath.item]["image"] as! String), completed: nil)
                }
                return bell
            }
                // Predict Table
            else{
                scoreTableCel = tblScore.dequeueReusableCell(withIdentifier: "ScoreTableCellReuse", for: indexPath) as! ScoreTableCell
                scoreTableCel.imgHomeTeam.sd_setImage(with: URL.init(string: self.allpridict[indexPath.item]["home_team_logo"] as! String), completed: nil)
                scoreTableCel.lblHomeTeamName.text = "\(self.allpridict[indexPath.item]["home_team_name"] ?? "")"
                scoreTableCel.imgAwayTeam.sd_setImage(with: URL.init(string: self.allpridict[indexPath.item]["away_team_logo"] as! String), completed: nil)
                scoreTableCel.lblAwayTeamName.text = "\(self.allpridict[indexPath.item]["away_team_name"] ?? "")"
                scoreTableCel.mypick.isHidden = true
                scoreTableCel.startingsoon.isHidden = true
 
    // MARK:- Date //

                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd"
                let datefomatterPrint = DateFormatter()
                datefomatterPrint.dateFormat = "E,dd MMM yyyy"

                let date: NSDate? = dateFormatterGet.date(from: self.allpridict[indexPath.item]["date"] as! String ) as NSDate?
//                scoreTableCel.lblDate.text = datefomatterPrint.string(from: date! as Date )
//                scoreTableCel.lblDate.textColor = UIColor(red: 0/256, green: 84/256, blue: 43/256, alpha: 1.0)
//                scoreTableCel.lblDate.font = .boldSystemFont(ofSize: 15)
                scoreTableCel.date2.text = datefomatterPrint.string(from: date! as Date )
                scoreTableCel.date2.textColor = UIColor(red: 0/256, green: 84/256, blue: 43/256, alpha: 1.0)
                scoreTableCel.date2.font = .boldSystemFont(ofSize: 15)

                
    // MARK:- Timer //
                if(leftHour <= 01){
                let dCurrent = Date()
//                let strEventDate : String = TimerArr[indexPath.row] as! String
                let strEventDate = self.allpridict[indexPath.row]["event_date"] as! String
                let dFormatter : DateFormatter = DateFormatter()
                dFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let dEventDate : Date = dFormatter.date(from: strEventDate)!
//               print(dEventDate.timeIntervalSinceNow)
                
                var interval = dEventDate.timeIntervalSince(dCurrent)// make sure current time
                    print("Total Interval : \(interval)")
                    let strPrint = self.stringFromTimeInterval(interval: interval)
                    print(" Interval : \(strPrint)")
                   
                    let Time = String(strPrint).split(separator: ":")
                    print(Int(Time[0]))
                    let timeinint = Int(Time[0])
//                    scoreTableCell.lblDate.text = String(DateandTime[0])
//                print("time in long\(dCurrent.timeIntervalSince1970)")
                    if timeinint! < 1
                       {
                           //timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                       
                          Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                           //  print("Inter val : \(interval)")
                              let strPrint = self.stringFromTimeInterval(interval: interval)
                            
                            self.scoreTableCel.lblTime?.text = "\(strPrint)"
                           // print("Cell \(indexpath.row) - Time Remaining To Start : \(strPrint)")
                            
                                                interval = interval - 1
                                                
                                                if interval <= 0.0
                                                    {
                                                         print("----------- Match Started -------------")
                                                        timer.invalidate()
                                                        self.scoreTableCel.lblTime?.text = " Match Started Now"
                                                }
                        }.fire()
                          
                       }else
                       {
                           print("----------- Match Started -------------")
//                        scoreTableCel.lblTime?.text = "Match Started Now"
                       }
                }else{
                       // MARK:- Time //
                             let DateandTime = (self.allpridict[indexPath.row]["event_date"] as! String).split(separator: "T")
                             let Time = String(DateandTime[1]).split(separator: "+")
                             let time2 = String(Time[0]).split(separator: ":")
                            scoreTableCel.lblTime?.text = String(time2[0] + ":" + time2[1])
                            scoreTableCel.lblTime.textColor = UIColor.darkGray
                            scoreTableCel.lblTime.font = .boldSystemFont(ofSize: 12)
                    }
         
                let Fixtureid = self.allpridict[indexPath.item]["fixture_id"] as! String
                if LeagueDetail.count > 0{
                    let shortstatus = allpridict[indexPath.item]["statusShort"] as! String
                    let status = allpridict[indexPath.item]["status"] as! String

                    if shortstatus == "NS" || shortstatus == "TBD" || status == "Not Started"
                    {
                        scoreTableCel.btnLeftUp.isEnabled = true
                        scoreTableCel.btnLeftDown.isEnabled = true
                        scoreTableCel.btnRightUp.isEnabled = true
                        scoreTableCel.btnRightDown.isEnabled = true
                        scoreTableCel.startingsoon.isHidden = true
                        scoreTableCel.mainView.backgroundColor = .white
                        scoreTableCel.shadowView.backgroundColor = .white
                        scoreTableCel.leftsideView.backgroundColor = .white
                        scoreTableCel.centerView.backgroundColor = .white
                        scoreTableCel.rightsideView.backgroundColor = .white
                        scoreTableCel.matchFinished.isHidden = true
                        scoreTableCel.txtLeftScore.isUserInteractionEnabled = true
                        scoreTableCel.txtRightScore.isUserInteractionEnabled = true
                        scoreTableCel.lblTime.isHidden = false
                        if ( selectRound.lowercased().contains("final")) {
                        scoreTableCel.LeftCheckBtn.isUserInteractionEnabled = true
                        scoreTableCel.RightCheckBtn.isUserInteractionEnabled = true
                        }
                    }
                    else{
                        scoreTableCel.btnLeftUp.isEnabled = false
                        scoreTableCel.btnLeftDown.isEnabled = false
                        scoreTableCel.btnRightUp.isEnabled = false
                        scoreTableCel.btnRightDown.isEnabled = false
                        scoreTableCel.startingsoon.isHidden = true
                        scoreTableCel.mainView.backgroundColor = .lightGray
                        scoreTableCel.shadowView.backgroundColor = .lightGray
                        scoreTableCel.leftsideView.backgroundColor = .lightGray
                        scoreTableCel.centerView.backgroundColor = .lightGray
                        scoreTableCel.rightsideView.backgroundColor = .lightGray
                        scoreTableCel.txtLeftScore.isUserInteractionEnabled = false
                        scoreTableCel.txtRightScore.isUserInteractionEnabled = false
                        scoreTableCel.matchFinished.isHidden = false
                        scoreTableCel.lblTime.isHidden = true
                       if ( selectRound.lowercased().contains("final")) {                       scoreTableCel.LeftCheckBtn.isUserInteractionEnabled = false
                       scoreTableCel.RightCheckBtn.isUserInteractionEnabled = false
                       }
                    }
                }
         
               if ( selectRound.lowercased().contains("final")) {
                    scoreTableCel.btnLeftUp.isHidden = true
                    scoreTableCel.btnLeftDown.isHidden = true
                    scoreTableCel.btnRightUp.isHidden = true
                    scoreTableCel.btnRightDown.isHidden = true
                    scoreTableCel.txtLeftScore.isHidden = true
                    scoreTableCel.txtRightScore.isHidden = true
                    scoreTableCel.LeftCheckBtn.tag = indexPath.row
                    scoreTableCel.RightCheckBtn.tag = indexPath.row
                    scoreTableCel.LeftCheckBtn.addTarget(self, action: #selector(LeftCheckAction), for: .touchUpInside)
                    scoreTableCel.RightCheckBtn.addTarget(self, action: #selector(RightCheckAction), for: .touchUpInside)

                       }
                else{
                    scoreTableCel.LeftCheckBtn.isHidden = true
                    scoreTableCel.RightCheckBtn.isHidden = true
                    scoreTableCel.txtLeftScore.tag = indexPath.row
                    scoreTableCel.txtRightScore.tag = indexPath.row
                    scoreTableCel.selectionStyle = .none
                    scoreTableCel.btnLeftUp.tag = indexPath.row
                    scoreTableCel.btnLeftDown.tag = indexPath.row
                    scoreTableCel.btnRightUp.tag = indexPath.row
                    scoreTableCel.btnRightDown.tag = indexPath.row
                    scoreTableCel.headToheadBtn.tag = indexPath.row
                    scoreTableCel.regularSeason.isHidden = true
                    scoreTableCel.pts.isHidden = true
                    scoreTableCel.btnLeftUp.addTarget(self, action: #selector(self.btnActionLeftUp(sender:)), for: .touchUpInside)
                    scoreTableCel.btnLeftDown.addTarget(self, action: #selector(self.btnActionLeftDown(sender:)), for: .touchUpInside)
                    scoreTableCel.btnRightUp.addTarget(self, action: #selector(self.btnActionRightUp(sender:)), for: .touchUpInside)
                    scoreTableCel.btnRightDown.addTarget(self, action: #selector(self.btnActionRightDown(sender:)), for: .touchUpInside)
                    scoreTableCel.txtLeftScore.addTarget(self, action: #selector(textFieldLeftPredictionChanged), for: .editingDidEnd)
                    scoreTableCel.txtLeftScore.addTarget(self, action: #selector(textFieldLeftPredictionbegin), for: .editingDidBegin)
                    scoreTableCel.txtRightScore.addTarget(self, action: #selector(textFieldRightPredictionChanged), for: .editingDidEnd)
                    scoreTableCel.txtRightScore.addTarget(self, action: #selector(textFieldRightPredictionbegin), for: .editingDidBegin)
                    scoreTableCel.headToheadBtn.addTarget(self, action: #selector(headToHeadAction), for: .touchUpInside)

                }
                
                
                if pridictData.count>0{

                             for item in pridictData {
                                let matchid = item["match_id"] as! String

                                 if ( selectRound.lowercased().contains("final")) {
                                    if matchid != Fixtureid{
                                            scoreTableCel.LeftCheckBtn.isSelected = false
                                            scoreTableCel.RightCheckBtn.isSelected = false
                                   }
                                   else{
                                       if (item["home_team_score"] ?? "") is NSNull {
                                           scoreTableCel.LeftCheckBtn.isSelected = false
                                       }
                                       else{
                                           let homeTeamScore:String = "\(item["home_team_score"] ?? "")"
                                        if homeTeamScore == "1"{
                                            scoreTableCel.LeftCheckBtn.isSelected = true
                                        }
                                        else{
                                            scoreTableCel.LeftCheckBtn.isSelected = false
                                        }
                                       }
                                       if (item["away_team_score"] ?? "") is NSNull {
                                           scoreTableCel.RightCheckBtn.isSelected = false
                                       }
                                       else{
                                           let awayTeamScore:String = "\(item["away_team_score"] ?? "")"
                                        if awayTeamScore == "1"{
                                               scoreTableCel.RightCheckBtn.isSelected = true
                                            }
                                        else{
                                            scoreTableCel.RightCheckBtn.isSelected = false
                                        }
                                       }
                                       break
                                   }
                                 }else{
                                    scoreTableCel.LeftCheckBtn.isHidden = true
                                    scoreTableCel.RightCheckBtn.isHidden = true
                                 if matchid != Fixtureid{
                                     scoreTableCel.txtLeftScore.text = "-"
                                     scoreTableCel.txtRightScore.text = "-"
                                 }
                                 else{
                                     if (item["home_team_score"] ?? "") is NSNull {
                                         scoreTableCel.txtLeftScore.text = "-"
                                     }
                                     else{
                                         let homeTeamScore:String = "\(item["home_team_score"] ?? "")"
                                         scoreTableCel.txtLeftScore.text = homeTeamScore
                                     }
                                     if (item["away_team_score"] ?? "") is NSNull {
                                         scoreTableCel.txtRightScore.text = "-"
                                     }
                                     else{
                                         let awayTeamScore:String = "\(item["away_team_score"] ?? "")"
                                         scoreTableCel.txtRightScore.text = awayTeamScore
                                     }
                                     break
                                 }
                             }
                             }
                         }else{
                             if ( selectRound.lowercased().contains("final")) {
                                 scoreTableCel.LeftCheckBtn.isSelected = false
                                 scoreTableCel.RightCheckBtn.isSelected = false
                             }else{
                             scoreTableCel.txtLeftScore.text = "-"
                             scoreTableCel.txtRightScore.text = "-"
                             }
                         }
                
                return scoreTableCel
            }
        }
    func stringFromTimeInterval(interval: TimeInterval) -> NSString {

             let ti = NSInteger(interval)
               
             let seconds = ti % 60
             let minutes = (ti / 60) % 60
             let hours = (ti / 3600)
        
             leftHour = hours
             return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == leadertableview{
            return 50
        }
        else if  tableView == roundtableview{
            return 50//UITableView.automaticDimension
        }
        else{
            return 220
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if tableView == leadertableview {
           //  if showpredictdetails {
             // show user prediction
             let userid = self.allLeaderl[indexPath.row]["id"] as! String
             getUserprediction(user: userid)
        // }
      }
        else if  tableView == roundtableview{
            leaderBtn.isHidden = false
            selectRound = self.allRounds[indexPath.item]
            roundBtnlbl.text = selectRound
            roundtableview.isHidden = true
            rankPlayerPoints.isHidden = false
            matchLeaderBtn.isHidden = false
            if leadertableview.isHidden == false{
                showLeaderBoard()
            }else{
                tblScore.isHidden = false
                getmatches()
            }
        }
        else{
            return
        }
    }
    @IBAction func back_action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    var count = 0
    @objc func textFieldLeftPredictionbegin(sender : UITextField)  {
        let indexPath = IndexPath(row:sender.tag, section: 0)
        let currentCellTxt = tblScore.cellForRow(at:indexPath )! as? ScoreTableCell
         currentCellTxt!.txtLeftScore.text = ""
        
    }
    @objc func textFieldRightPredictionbegin(sender : UITextField)  {
        let indexPath = IndexPath(row:sender.tag, section: 0)
              let currentCellTxt = tblScore.cellForRow(at:indexPath )! as? ScoreTableCell
               currentCellTxt!.txtRightScore.text = ""
           
       }
    @objc func headToHeadAction(sender: UIButton){
        self.positions = sender.tag
        print(sender.tag)
        headtoheads()
    }
    func headtoheads() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "HeadtoHeadViewController") as! HeadtoHeadViewController
        let away =  self.allpridict[positions]["away_team_id"] as! String
        let home = self.allpridict[positions]["home_team_id"] as! String
//        let  homeTeamId = home["team_id"]
//        let  AwayTeamId = away["team_id"]
        //   let win = allLastMan[position]["statistics"] as! [String:Any]
        
        viewController.awayId = (away as NSString).integerValue
        viewController.homeId = (home as NSString).integerValue

        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)

    }
    @objc func LeftCheckAction(sender : UIButton){
        if ( selectRound.lowercased().contains("final")) {
            self.positions = sender.tag
            let indexPath = IndexPath(row:sender.tag, section: 0)
            let currentCellTxt = tblScore.cellForRow(at:indexPath )! as? ScoreTableCell
            let leftlbl = ((currentCellTxt?.LeftCheckBtn)!)
            
            let indexPath1 = IndexPath(row:sender.tag, section: 0)
            let currentCellTxt1 = tblScore.cellForRow(at:indexPath1 ) as? ScoreTableCell
            let rightlbl = ((currentCellTxt1?.RightCheckBtn)!)
            
            if leftlbl.isSelected{
                sender.isSelected = false
//                rightlbl.isSelected = true
            }else{
                sender.isSelected = true
                rightlbl.isSelected = false
                  self.prictleft = "1"
                self.pridictrht = "0"
                postPrediction(status: "goal")
            }
        }
    }
    @objc func RightCheckAction(sender : UIButton){
          if ( selectRound.lowercased().contains("final")) { 
            self.positions = sender.tag
             let indexPath = IndexPath(row:sender.tag, section: 0)
             let currentCellTxt = tblScore.cellForRow(at:indexPath ) as? ScoreTableCell
             let rightlbl = ((currentCellTxt?.RightCheckBtn)!)
            
            let indexPath2 = IndexPath(row:sender.tag, section: 0)
            let currentCellTxt2 = tblScore.cellForRow(at:indexPath2 )! as? ScoreTableCell
            let leftlbl = ((currentCellTxt2?.LeftCheckBtn)!)
            
             if rightlbl.isSelected{
                    sender.isSelected = false
//                   leftlbl.isSelected = true
                }else{
                    sender.isSelected = true
                    leftlbl.isSelected = false
                self.prictleft = "0"
                self.pridictrht = "1"
                postPrediction(status: "goal")
               }
           }
       }
    
    @objc func textFieldLeftPredictionChanged(sender : UITextField)  {

        print(sender.tag)
        self.positions = sender.tag
        let indexPath = IndexPath(row:sender.tag, section: 0)
        let currentCellTxt = tblScore.cellForRow(at:indexPath )! as? ScoreTableCell
        var currentText : Int
        if currentCellTxt?.txtLeftScore?.text!.isEmpty == false{
            if currentCellTxt!.txtLeftScore.text == "-"  {
                self.prictleft = "0"
                currentCellTxt!.txtLeftScore.text = "0"
            }else{
            currentText = Int((currentCellTxt?.txtLeftScore?.text)!)!
            self.prictleft = currentText.string
            }
        }
        if currentCellTxt!.txtRightScore.text == "-"  {
            self.pridictrht = "0"
            currentCellTxt!.txtRightScore.text = "0"

        } else {
            let currentTextLft = Int((currentCellTxt?.txtRightScore?.text)!)
            self.pridictrht = "\(currentTextLft!.string)"
        }
        
        postPrediction(status: "goal")
    }
    @objc func textFieldRightPredictionChanged(sender : UITextField)  {
        self.positions = sender.tag
        let indexPath = IndexPath(row:sender.tag, section: 0)
        let currentCellTxt = tblScore.cellForRow(at:indexPath )! as? ScoreTableCell
        var currentText : Int
        if currentCellTxt?.txtRightScore?.text!.isEmpty == false{
            if currentCellTxt!.txtRightScore.text == "-"  {
            self.prictleft = "0"
            currentCellTxt!.txtRightScore.text = "0"
        }else{
            currentText = Int((currentCellTxt?.txtRightScore?.text)!)!
            self.pridictrht = currentText.string
                }
        }
        if currentCellTxt!.txtLeftScore.text == "-"  {
            self.prictleft = "0"
            currentCellTxt!.txtLeftScore.text = "0"

        } else {
            let currentTextLft = Int((currentCellTxt?.txtLeftScore?.text)!)
            self.prictleft = "\(currentTextLft!.string)"
        }
        postPrediction(status: "goal")
    }
    @objc func btnActionLeftUp(sender : UIButton) {
        print(sender.tag)
        self.positions = sender.tag
        let indexPath = IndexPath(row:sender.tag, section: 0)
        let currentCellTxt = tblScore.cellForRow(at:indexPath )! as? ScoreTableCell
        var currentText : Int
        if currentCellTxt?.txtLeftScore?.text == "-" ||  currentCellTxt?.txtLeftScore?.text == " "{
            currentText = 0
        }else{
            currentText = Int((currentCellTxt?.txtLeftScore?.text)!)!
            currentText = (currentText + 1)
        }
        currentCellTxt!.txtLeftScore.text = currentText.string
        self.prictleft = currentText.string
        if currentCellTxt!.txtRightScore.text == "-" || currentCellTxt!.txtRightScore.text == " " {
            self.pridictrht = "0"
            currentCellTxt!.txtRightScore.text = "0"
        } else {
            let currentTextLft = Int((currentCellTxt?.txtRightScore?.text)!)
            self.pridictrht = "\(currentTextLft!.string)"
        }
        postPrediction(status: "goal")
    }
    @objc func btnActionLeftDown(sender : UIButton) {
        print(sender.tag)
        self.positions = sender.tag
        let indexPath = IndexPath(row:sender.tag, section: 0)
        let currentCellTxt = tblScore.cellForRow(at:indexPath )! as? ScoreTableCell
        var currentText : Int
        if currentCellTxt?.txtLeftScore?.text == "-"{
            currentText = 0
        }else{
            currentText = Int((currentCellTxt?.txtLeftScore?.text)!)!
            if currentText ==  0 {
                currentCellTxt!.txtLeftScore.text = currentText.string
            }
            else{
                currentText = (currentText - 1)
                currentCellTxt!.txtLeftScore.text = currentText.string
            } }
        self.prictleft = currentText.string

        if currentCellTxt!.txtRightScore.text == "-"  {
            self.pridictrht = "0"
            currentCellTxt!.txtRightScore.text = "0"
        } else {
            let currentTextLft = Int((currentCellTxt?.txtRightScore?.text)!)
            self.pridictrht = "\(currentTextLft!.string)"
        }
        postPrediction(status: "goal")
    }
    @objc func btnActionRightUp(sender : UIButton) {
        
        print(sender.tag)
        self.positions = sender.tag
        let indexPath = IndexPath(row:sender.tag, section: 0)
        
        let currentCellTxt = tblScore.cellForRow(at:indexPath )! as? ScoreTableCell
        var currentText : Int
        if currentCellTxt!.txtRightScore.text == "-"  {
            currentText = 0
        } else {
            currentText = Int((currentCellTxt?.txtRightScore?.text)!)!
            currentText = (currentText + 1)
        }
        currentCellTxt!.txtRightScore.text = currentText.string
        
        self.pridictrht = currentText.string
        if currentCellTxt!.txtLeftScore.text == "-"  {
            self.prictleft = "0"
            currentCellTxt!.txtLeftScore.text = "0"

        } else {
            let currentTextLft = Int((currentCellTxt?.txtLeftScore?.text)!)
            self.prictleft = "\(currentTextLft!.string)"
        }

        postPrediction(status: "goal")
    }
    @objc func btnActionRightDown(sender : UIButton) {
        print (sender.tag)
        self.positions = sender.tag
        let indexPath = IndexPath(row:sender.tag, section: 0)
        let currentCellTxt = tblScore.cellForRow(at:indexPath )! as? ScoreTableCell
        var currentText : Int
        if currentCellTxt?.txtRightScore?.text == "-"
        {
            currentText = 0
        } else {
            currentText = Int((currentCellTxt?.txtRightScore?.text)!)!
            if currentText ==  0 {
                currentCellTxt!.txtRightScore?.text = currentText.string
            }
            else{
                currentText = (currentText - 1)
                currentCellTxt!.txtRightScore?.text = currentText.string
            }}
        self.pridictrht = currentText.string

        
        if currentCellTxt!.txtLeftScore.text == "-"  {
            self.prictleft = "0"
            currentCellTxt!.txtLeftScore.text = "0"

        } else {
            let currentTextLft = Int((currentCellTxt?.txtLeftScore?.text)!)
            self.prictleft = "\(currentTextLft!.string)"
        }
        postPrediction(status: "goal")
    }
    
       func getUserprediction(user: String){
            
            var dict = [String:String]()
            dict["league_id"] = LeagueDetail["league_id"] as? String
            dict["league_type"] =  LeagueDetail["league_type"] as? String
            dict["id"] =  LeagueDetail["id"] as? String
            dict["user_id"] = user
            dict["round"] = selectRound
        
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

            }
        }
   
}
class RoundTableViewCell: UITableViewCell {
    
    @IBOutlet weak var round1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()}
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)}
}
extension String {
    func convertStringToInt() -> Int {
        return Int(Double(self) ?? 0.0)
    }
}
extension Int
{
    var string:String {
        get {
            return String(self)
        }
    }}
