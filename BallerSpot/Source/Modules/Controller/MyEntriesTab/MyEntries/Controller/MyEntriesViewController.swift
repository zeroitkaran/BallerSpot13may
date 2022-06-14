//
//  MyEntriesViewController.swift
//  BallerSpot
//
//  Created by Zeroit on 04/03/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.

import UIKit
import MBProgressHUD

class MyEntriesViewController : UIViewController, UITabBarControllerDelegate {

    @IBOutlet weak var noEntriesLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var tableViewEntries: UITableView!
    @IBOutlet weak var potamount: UILabel!
    @IBOutlet weak var label: UIView!
    
    var leftInset: CGFloat = 7.0
    
    var arrMyEntries = [ResultDatum]()
    var arrMyEntriesPrivate = [PrivateDatum]()

    var scoreTableCell = ScoreTableCell()

    var bottonSelected = true
    var sectionTypeData = [(key: String, value: [ResultDatum])]()
    var sectionTypeData1 = [(key: String, value: [PrivateDatum])]()
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
         let tabBarIndex = tabBarController.selectedIndex
        self.navigationController?.popToRootViewController(animated: true)
         if tabBarIndex == 0 {
             //do your stuff
         }
    }
    override func viewDidLoad() {
        self.tabBarController?.delegate = self
        super.viewDidLoad()
        tableViewEntries.delegate = self
        tableViewEntries.dataSource = self
        tableViewEntries.register(UINib(nibName: "ScoreTableCell", bundle: nil), forCellReuseIdentifier: "ScoreTableCellReuse")
        tableViewEntries.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getMyEntries()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    @IBAction func menuBtn(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true
    }
   
    func getMyEntries(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        var dict = [String:String]()
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        
        //        dict["pin"] = "1234"

        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        print(dict)
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.myentries,header: headers, parameters: dict ) {(response, status, data) in
            // print(response as Any)
            if status{
                if response != nil
                {
                    do {
                        print(response)
                        self.noEntriesLabel.isHidden = true
                        let decoder = JSONDecoder()
                        let mydata = try decoder.decode(MyEntries.self, from: data)
                        self.arrMyEntries = mydata.myEnteries?.result_data ?? [ResultDatum]()
                        self.arrMyEntriesPrivate = mydata.myEnteries?.private_data ?? [PrivateDatum]()
                        self.potamount.text = mydata.myEnteries?.pool_amount
                        MBProgressHUD.hide(for: self.view, animated: true)
//                        self.tableViewEntries.reloadData()
                        self.sectionTypeModelFunc()
                        self.PrivateSectionTypeModelFunc()
                    }
                    catch{
                        print(error.localizedDescription)
                    }

                }else{
                    self.noEntriesLabel.isHidden = false
                    BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
                }
            }
        }
    }
    
    func sectionTypeModelFunc(){
            
            sectionTypeData.removeAll()
            for item in self.arrMyEntries{
                
    //            let dict = ["away_team_logo": item.away_team_logo!,
    //                        "away_team_name":item.away_team_name!,
    //                        "away_team_score":item.away_team_score!,
    //                        "created_at":item.created_at!,
    ////                        "date":item.date!,
    //                        "event_date":item.event_date!,
    //                        if item.final_away_score! == false {
    //                            "0":item.final_away_score!,
    //                        } else {
    //                            "final_away_score":item.final_away_score!,
    //                        },
    //                        "final_away_score":item.final_away_score!,
    //                        "final_home_score":item.final_home_score!,
    ////                        "fixture_id":item.fixture_id!,
    //                        "home_team_logo":item.home_team_logo!,
    //                        "home_team_name":item.home_team_name!,
    //
    ////                        "home_team_score":item.home_team_score!]
    ////                        "id":item.id!]
    ////                        "league_id":item.league_id!]
    //                        "league_name":item.league_name!,
    ////                        "league_type":item.league_type!
    //                        "pot_amount":item.pot_amount!,
    //                        "round":item.round!,
    //                        "status":item.status!,
    //                        "statusShort":item.statusShort!,
    ////                        "league_name":item.league_name!,
    ////                        "updated_at":item.league_type!
    //            ]



                
                if sectionTypeData.count == 0{
                    sectionTypeData.append((key: "\(String(describing: item.league_name!))" , value: [item]))
                }else{
                    let checkExisting = sectionTypeData.filter({$0.key == "\(String(describing: item.league_name!))"})
                    if checkExisting.count != 0{
                        let index = sectionTypeData.firstIndex(where: {$0.key == "\(String(describing: item.league_name!))"})
                        sectionTypeData[index!].value.append(item)
                    }else{
                        sectionTypeData.append((key: "\(String(describing: item.league_name!))" , value: [item]))
                    }
                }
            }
            
            
    //        self.tableViewEntries.delegate = self
    //        self.tableViewEntries.dataSource = self
            self.tableViewEntries.reloadData()
            print(sectionTypeData)
        }
     func PrivateSectionTypeModelFunc(){
                
                sectionTypeData1.removeAll()
                for item in self.arrMyEntriesPrivate{

    //                let dict = ["away_team_logo": item.away_team_logo!,
    //                            "away_team_name":item.away_team_name!,
    //                            "away_team_score":item.away_team_score!,
    //                            "created_at":item.created_at!,
    //    //                        "date":item.date!,
    //                            "event_date":item.event_date!,
    //                            "final_away_score":item.final_away_score!,
    //                            "final_home_score":item.final_home_score!,
    //    //                        "fixture_id":item.fixture_id!,
    //                            "home_team_logo":item.home_team_logo!,
    //                            "home_team_name":item.home_team_name!,
    //
    //    //                        "home_team_score":item.home_team_score!]
    //    //                        "id":item.id!]
    //    //                        "league_id":item.league_id!]
    //                            "league_name":item.league_name!,
    //    //                        "league_type":item.league_type!
    //                            "pot_amount":item.pot_amount!,
    //                            "round":item.round!,
    //                            "status":item.status!,
    //                            "statusShort":item.statusShort!,
    //    //                        "league_name":item.league_name!,
    //    //                        "updated_at":item.league_type!
    //                ]



                    
                    if sectionTypeData1.count == 0{
                        sectionTypeData1.append((key: "\(String(describing: item.le_name!))" , value: [item]))
                    }else{
                        let checkExisting = sectionTypeData1.filter({$0.key == "\(String(describing: item.le_name!))"})
                        if checkExisting.count != 0{
                            let index = sectionTypeData1.firstIndex(where: {$0.key == "\(String(describing: item.le_name!))"})
                            sectionTypeData1[index!].value.append(item)
                        }else{
                            sectionTypeData1.append((key: "\(String(describing: item.le_name!))" , value: [item]))
                        }
                    }
                }
                
                
    //            self.tableViewEntries.delegate = self
    //            self.tableViewEntries.dataSource = self
                self.tableViewEntries.reloadData()
                print(sectionTypeData)
                
            }
    @IBAction func publicBtn(_ sender: UIButton) {
        if button1.isSelected {
            button1.backgroundColor = UIColor.systemPink
            button1.setTitleColor(UIColor.white, for: .normal)
        }
        else{

            button1.backgroundColor = UIColor.systemPink
            button1.setTitleColor(UIColor.white, for: .normal)
            button2.backgroundColor = UIColor.gray

        }
        if sectionTypeData.count > 0 {
                   self.noEntriesLabel.isHidden = true
               } else {
                   self.noEntriesLabel.isHidden = false
               }
        bottonSelected = true
        self.tableViewEntries.reloadData()
    }
    
    @IBAction func privateBtn(_ sender: UIButton) {
        if button2.isSelected {
            button2.backgroundColor = UIColor.systemPink
            button2.setTitleColor(UIColor.white, for: .normal)
            button1.backgroundColor = UIColor.red
        }
        else {

            button2.backgroundColor = UIColor.systemPink
            button2.setTitleColor(UIColor.white, for: .normal)
            button1.backgroundColor = UIColor.gray

        }
        if sectionTypeData1.count > 0 {
            self.noEntriesLabel.isHidden = true
        } else {
            self.noEntriesLabel.isHidden = false
        }
        bottonSelected = false

        self.tableViewEntries.reloadData()

    }
}

extension MyEntriesViewController : UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if bottonSelected == true {
//            return self.arrMyEntries.count
//        }
//        else {
//            return self.arrMyEntriesPrivate.count
//
//        }
//    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if bottonSelected == true {
            return sectionTypeData.count
        }
        else {
            return sectionTypeData1.count

        }
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          if bottonSelected == true {
                    return sectionTypeData[section].value.count
                }
                else {
                    return sectionTypeData1[section].value.count

                }
            }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        scoreTableCell = tableView.dequeueReusableCell(withIdentifier: "ScoreTableCellReuse", for: indexPath) as! ScoreTableCell
        scoreTableCell.selectionStyle = .none
        // scoreTableCell.btnSave.isHidden = true
        scoreTableCell.hideView.isHidden = true
       if bottonSelected == true {
            let data = self.arrMyEntries[indexPath.row]
            let dataItem = sectionTypeData[indexPath.section]

            scoreTableCell.imgHomeTeam.sd_setImage(with: URL(string: (dataItem.value[indexPath.row].home_team_logo)!), completed: nil)
            scoreTableCell.imgAwayTeam.sd_setImage(with: URL(string: (dataItem.value[indexPath.row].away_team_logo)!), completed: nil)
            scoreTableCell.lblHomeTeamName.text = dataItem.value[indexPath.row].home_team_name
            scoreTableCell.lblAwayTeamName.text = dataItem.value[indexPath.row].away_team_name
            scoreTableCell.txtLeftScore.text = dataItem.value[indexPath.row].home_team_score
            scoreTableCell.txtRightScore.text = dataItem.value[indexPath.row].away_team_score
            scoreTableCell.txtLeftScore.isUserInteractionEnabled = false
            scoreTableCell.txtRightScore.isUserInteractionEnabled = false
            scoreTableCell.regularSeason.text = dataItem.value[indexPath.row].round
            scoreTableCell.pts.text = (dataItem.value[indexPath.row].pot_amount)! + " Pts"

            let DateandTime = (dataItem.value[indexPath.row].event_date)!.split(separator: "T")

//            let newString = String(DateandTime[1]).replacingOccurrences(of: "-", with: "+", options: .literal, range: nil)
//            let Time = newString.split(separator: "+")
        let Time = String(DateandTime[1]).split(separator: "+")
        let time2 = String(Time[0]).split(separator: ":")
                scoreTableCell.lblTime.text = String(time2[0] + ":" + time2[1])

            scoreTableCell.lblDate.text = String(DateandTime[0])

//            scoreTableCell.lblTime.text = String(Time[0])
            scoreTableCell.matchFinished.isHidden = true
            scoreTableCell.btnLeftUp.isHidden = true
            scoreTableCell.btnLeftDown.isHidden = true
            scoreTableCell.btnRightUp.isHidden = true
            scoreTableCell.btnRightDown.isHidden = true
            //                           let dateFormatterGet = DateFormatter()
            //                          //   "updated_at" = "2020-09-07 12:04:42";
            //                           dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            //                           let datefomatterPrint = DateFormatter()
            //                           datefomatterPrint.dateFormat = "E,dd MMM yyyy"
            //                        let date: NSDate? = dateFormatterGet.date(from: data.created_at! ) as NSDate?
            //                           scoreTableCell.lblDate.text = datefomatterPrint.string(from: date! as Date )
            if ( (dataItem.value[indexPath.row].round)!.lowercased().contains("final")) {
                scoreTableCell.txtLeftScore.isHidden = true
                scoreTableCell.txtRightScore.isHidden = true
                scoreTableCell.LeftCheckBtn.isHidden = false
                scoreTableCell.RightCheckBtn.isHidden = false
                    if (dataItem.value[indexPath.row].home_team_score ?? "") is NSNull {
                        scoreTableCell.LeftCheckBtn.isSelected = false
                    }
                    else{
                        let homeTeamScore:String = "\(dataItem.value[indexPath.row].home_team_score ?? "")"
                     if homeTeamScore == "1"{
                         scoreTableCell.LeftCheckBtn.isSelected = true
                     }
                     else{
                         scoreTableCell.LeftCheckBtn.isSelected = false
                     }
                    }
                    if (dataItem.value[indexPath.row].away_team_score ?? "") is NSNull {
                        scoreTableCell.RightCheckBtn.isSelected = false
                    }
                    else{
                        let awayTeamScore:String = "\(dataItem.value[indexPath.row].away_team_score ?? "")"
                     if awayTeamScore == "1"{
                            scoreTableCell.RightCheckBtn.isSelected = true
                         }
                     else{
                         scoreTableCell.RightCheckBtn.isSelected = false
                     }
                    }
            }else{
                scoreTableCell.txtLeftScore.isHidden = false
                scoreTableCell.txtRightScore.isHidden = false
                scoreTableCell.LeftCheckBtn.isHidden = true
                scoreTableCell.RightCheckBtn.isHidden = true
            }

            if (dataItem.value[indexPath.row].statusShort) == "FT"{
                scoreTableCell.startingsoon.text = (dataItem.value[indexPath.row].final_home_score)! + " - " + (dataItem.value[indexPath.row].final_away_score)!
                scoreTableCell.lblTime.text = "Finished"
                scoreTableCell.lblTime.textColor = UIColor.red
                // time == Finished status Red color
                // status == final score
            }else if (dataItem.value[indexPath.row].statusShort) == "FH" || (dataItem.value[indexPath.row].statusShort) == "SH" || (dataItem.value[indexPath.row].statusShort) == "HT"{
                scoreTableCell.lblTime.text = "Live"
                scoreTableCell.lblTime.textColor = UIColor.red
                scoreTableCell.startingsoon.text = (dataItem.value[indexPath.row].final_home_score)! + " - " + (dataItem.value[indexPath.row].final_away_score)!
                // Live on time label red color
                // status == Score
                // time == live
            }
            //            else if data.final_away_score != nil || data.final_home_score! != nil{
            //                scoreTableCell.startingsoon.text = (data.final_home_score ?? "") + " - " + (data.final_away_score ?? "")
            //               // No time koi jarurat nai hai
            //                // status == score
            //            }
            else if (dataItem.value[indexPath.row].statusShort) == "NS" || (dataItem.value[indexPath.row].statusShort) == "TBD"{
                let DateandTime = (dataItem.value[indexPath.row].event_date)!.split(separator: "T")
                let Time = String(DateandTime[1]).split(separator: "+")
                let time2 = String(Time[0]).split(separator: ":")
                scoreTableCell.lblTime.text = String(time2[0] + ":" + time2[1])
//                scoreTableCell.lblTime.text = String(Time[0])
                scoreTableCell.startingsoon.text = "Starting Soon"
                // time == time
                // status == starting soon
            }
            else{
                let DateandTime = (dataItem.value[indexPath.row].event_date)!.split(separator: "T")
                let Time = String(DateandTime[1]).split(separator: "+")
                let time2 = String(Time[0]).split(separator: ":")
                scoreTableCell.lblTime.text = String(time2[0] + ":" + time2[1])
                scoreTableCell.lblTime.text = String(Time[0])
                scoreTableCell.lblTime.textColor = UIColor.gray
                scoreTableCell.startingsoon.text = data.status ?? ""
                //show status  grey color
                // set time grey color
            }
        
        }
        else {
//            let data = self.arrMyEntriesPrivate[indexPath.row]
            let dataItem1 = sectionTypeData1[indexPath.section]

            scoreTableCell.imgHomeTeam.sd_setImage(with: URL(string: (dataItem1.value[indexPath.row].home_team_logo)!), completed: nil)
            scoreTableCell.imgAwayTeam.sd_setImage(with: URL(string: (dataItem1.value[indexPath.row].away_team_logo)!), completed: nil)
            scoreTableCell.lblHomeTeamName.text = dataItem1.value[indexPath.row].home_team_name
            scoreTableCell.lblAwayTeamName.text = dataItem1.value[indexPath.row].away_team_name
            scoreTableCell.txtLeftScore.text = dataItem1.value[indexPath.row].home_team_score
            scoreTableCell.txtRightScore.text = dataItem1.value[indexPath.row].away_team_score
            scoreTableCell.txtLeftScore.isUserInteractionEnabled = false
            scoreTableCell.txtRightScore.isUserInteractionEnabled = false

            scoreTableCell.regularSeason.text = dataItem1.value[indexPath.row].round
            scoreTableCell.pts.text = (dataItem1.value[indexPath.row].pot_amount)! + " Pts"

            let DateandTime = (dataItem1.value[indexPath.row].event_date)!.split(separator: "T")
            let Time = String(DateandTime[1]).split(separator: "+")
            let time2 = String(Time[0]).split(separator: ":")
           scoreTableCell.lblTime.text = String(time2[0] + ":" + time2[1])

            scoreTableCell.lblDate.text = String(DateandTime[0])

//            scoreTableCell.lblTime.text = String(Time[0])
            scoreTableCell.matchFinished.isHidden = true

            scoreTableCell.btnLeftUp.isHidden = true
            scoreTableCell.btnLeftDown.isHidden = true
            scoreTableCell.btnRightUp.isHidden = true
            scoreTableCell.btnRightDown.isHidden = true
            
            if (dataItem1.value[indexPath.row].statusShort) == "FT"{
                scoreTableCell.startingsoon.text = (dataItem1.value[indexPath.row].final_home_score)! + " - " + (dataItem1.value[indexPath.row].final_away_score)!
                scoreTableCell.lblTime.text = "Finished"
                scoreTableCell.lblTime.textColor = UIColor.red
                // time == Finished status Red color
                // status == final score
            }else if (dataItem1.value[indexPath.row].statusShort) == "FH" || (dataItem1.value[indexPath.row].statusShort) == "SH" || (dataItem1.value[indexPath.row].statusShort) == "HT"{
                scoreTableCell.lblTime.text = "Live"
                scoreTableCell.lblTime.textColor = UIColor.red
                scoreTableCell.startingsoon.text = (dataItem1.value[indexPath.row].final_home_score)! + " - " + (dataItem1.value[indexPath.row].final_away_score)!
                // Live on time label red color
                // status == Score
                // time == live
            }
            //            else if data.final_away_score != nil || data.final_home_score! != nil{
            //                scoreTableCell.startingsoon.text = (data.final_home_score ?? "") + " - " + (data.final_away_score ?? "")
            //               // No time koi jarurat nai hai
            //                // status == score
            //            }
            else if (dataItem1.value[indexPath.row].statusShort) == "NS" || (dataItem1.value[indexPath.row].statusShort) == "TBD"{
                let DateandTime = (dataItem1.value[indexPath.row].event_date)!.split(separator: "T")
                let Time = String(DateandTime[1]).split(separator: "+")
                let time2 = String(Time[0]).split(separator: ":")
                scoreTableCell.lblTime.text = String(time2[0] + ":" + time2[1])
//                scoreTableCell.lblTime.text = String(Time[0])
                scoreTableCell.startingsoon.text = "Starting Soon"
                // time == time
                // status == starting soon
            }
            else{
                let DateandTime = (dataItem1.value[indexPath.row].event_date)!.split(separator: "T")
                let Time = String(DateandTime[1]).split(separator: "+")
                let time2 = String(Time[0]).split(separator: ":")
                scoreTableCell.lblTime.text = String(time2[0] + ":" + time2[1])
//                scoreTableCell.lblTime.text = String(Time[0])
                scoreTableCell.lblTime.textColor = UIColor.gray
                scoreTableCell.startingsoon.text = dataItem1.value[indexPath.row].status ?? ""
                //show status  grey color
                // set time grey color
            }
             if ( (dataItem1.value[indexPath.row].round)!.lowercased().contains("final")) {
                        scoreTableCell.txtLeftScore.isHidden = true
                        scoreTableCell.txtRightScore.isHidden = true
                        scoreTableCell.LeftCheckBtn.isHidden = false
                        scoreTableCell.RightCheckBtn.isHidden = false
                            if (dataItem1.value[indexPath.row].home_team_score ?? "") is NSNull {
                                scoreTableCell.LeftCheckBtn.isSelected = false
                            }
                            else{
                                let homeTeamScore:String = "\(dataItem1.value[indexPath.row].home_team_score ?? "")"
                             if homeTeamScore == "1"{
                                 scoreTableCell.LeftCheckBtn.isSelected = true
                             }
                             else{
                                 scoreTableCell.LeftCheckBtn.isSelected = false
                             }
                            }
                            if (dataItem1.value[indexPath.row].away_team_score ?? "") is NSNull {
                                scoreTableCell.RightCheckBtn.isSelected = false
                            }
                            else{
                                let awayTeamScore:String = "\(dataItem1.value[indexPath.row].away_team_score ?? "")"
                             if awayTeamScore == "1"{
                                    scoreTableCell.RightCheckBtn.isSelected = true
                                 }
                             else{
                                 scoreTableCell.RightCheckBtn.isSelected = false
                             }
                            }
                    }else{
                        scoreTableCell.txtLeftScore.isHidden = false
                        scoreTableCell.txtRightScore.isHidden = false
                        scoreTableCell.LeftCheckBtn.isHidden = true
                        scoreTableCell.RightCheckBtn.isHidden = true
                    }
        }
        //
        return scoreTableCell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
               let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 35))
                headerView.backgroundColor = UIColor(red: 0/256, green: 84/256, blue: 43/256, alpha: 1.0)

        if bottonSelected == true {
               let label = UILabel()
               label.frame = CGRect.init(x: 16, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
               label.text = ((sectionTypeData[section]).key)
               label.textColor = UIColor.white // my custom colour
               label.backgroundColor = UIColor(red: 0/256, green: 84/256, blue: 43/256, alpha: 1.0)
               headerView.addSubview(label)
  
            }
           else{
            
            let label = UILabel()
               label.frame = CGRect.init(x: 16, y: 5, width: headerView.frame.width-0, height: headerView.frame.height-0)
               label.text = ((sectionTypeData1[section]).key)
               label.textColor = UIColor.white // my custom colour
               label.backgroundColor = UIColor(red: 0/256, green: 84/256, blue: 43/256, alpha: 1.0)
               headerView.addSubview(label)
           }
               return headerView
    }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 35
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200//UITableView.automaticDimension
    }
    
}
