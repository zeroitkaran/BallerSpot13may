//
//  HeadtoHeadViewController.swift
//  BallerSpot
//
//  Created by zeroit on 9/25/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class HeadtoHeadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var allHead = [[String:Any]]()
    var fixdata = [[String:Any]]()
    var homeId = Int()
    var awayId = Int()
    
    @IBOutlet weak var lftimageup: UIImageView!
    @IBOutlet weak var rgtimageup: UIImageView!
    @IBOutlet weak var ltfnameup: UILabel!
    @IBOutlet weak var rgtnameup: UILabel!
    @IBOutlet weak var lftscoreup: UILabel!
    @IBOutlet weak var lftwins: UILabel!
    @IBOutlet weak var drawscoreup: UILabel!
    @IBOutlet weak var drawwins: UILabel!
    @IBOutlet weak var rgtscoreup: UILabel!
    @IBOutlet weak var rgtwins: UILabel!
    
    @IBOutlet weak var PopUPTableView: UITableView!
    @IBOutlet weak var H2H: UILabel!
    @IBOutlet weak var previousMatches: UIView!
   
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
//        self.PopUPTableView.delegate = self
//        self.PopUPTableView.dataSource = self
//        self.PopUPTableView.register(UINib(nibName: "HeadTableViewCell", bundle: nil), forCellReuseIdentifier: "HeadTableViewCellReuse")
//        self.PopUPTableView.tableFooterView = UIView()
        self.lftscoreup.layer.cornerRadius = 10
                self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: 200)
        getLeaderBoard()
        lftscoreup.layer.masksToBounds = true
        lftscoreup.layer.cornerRadius = 7
        drawscoreup.layer.masksToBounds = true
        drawscoreup.layer.cornerRadius = 7
        rgtscoreup.layer.masksToBounds = true
        rgtscoreup.layer.cornerRadius = 7
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getLeaderBoard()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    @IBAction func cancel(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func getLeaderBoard(){
        
        var dict = [String:Int]()
        
        
        dict["team_one"]  = homeId
        dict["team_two"] = awayId
        
        print(dict)
        
        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.get_headtohead,header: headers, parameters: dict ) {(response, status, data) in
            if status{
                do{
                    //                      #   self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary
                    
                    print("json data is--->",jsondata)
                    if (jsondata["status"] as? String) == "Success" {
                        self.allHead = jsondata["teams data"] as! [[String : Any]]
                        self.fixdata = jsondata["fixtures data"] as! [[String:Any]]
                        self.ltfnameup.text = self.allHead[0]["team_name"]  as? String
                        self.rgtnameup.text = self.allHead[1]["team_name"]  as? String
                        let lftscore = ((self.allHead[0]["statistics"] as! [String:Any])["wins"] as! [String:Any])["total"]  as! Int
                        let drawscore = ((self.allHead[0]["statistics"] as! [String:Any])["draws"] as! [String:Any])["total"]  as! Int
                        let rgtscore = ((self.allHead[1]["statistics"] as! [String:Any])["wins"] as! [String:Any])["total"]  as! Int
                        let totalplayed = ((self.allHead[1]["statistics"] as! [String:Any])["played"] as! [String:Any])["total"]  as! Int
                        let lftwinper = self.calculatePercentage(value: Double(totalplayed),percentageVal: Double(lftscore))
                        let drawper = self.calculatePercentage(value: Double(totalplayed),percentageVal: Double(drawscore))
                        let rgtwinper = self.calculatePercentage(value: Double(totalplayed),percentageVal: Double(rgtscore))
                        self.lftscoreup.text = "\(lftscore)"
                        self.drawscoreup.text = "\(drawscore)"
                        self.rgtscoreup.text = "\(rgtscore)"
                        self.lftwins.text = "\(lftwinper)%"
                        self.drawwins.text = "\(drawper)%"
                        self.rgtwins.text = "\(rgtwinper)%"
                        
                        if self.allHead[0]["team_logo"] is NSNull || self.allHead[1]["team_logo"] is NSNull{
                            // do something with null JSON value here
                        }else{
                            self.lftimageup.sd_setImage(with: URL(string: self.allHead[0]["team_logo"] as! String), completed: nil)
                            self.rgtimageup.sd_setImage(with: URL(string: self.allHead[1]["team_logo"] as! String), completed: nil)
                        }
                        
                      
                        
                        self.PopUPTableView.reloadData()
                        
                    }
                    else{
                    // show alert
                    }
                   
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func calculatePercentage(value:Double,percentageVal:Double)->Double{
        let val =  percentageVal / value
        //   #     return val * 100.0
        return  Double(round(100*val * 100.0)/100)
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixdata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadTableViewCellReuse", for: indexPath) as! HeadTableViewCell
        let AwayTeam = self.fixdata[indexPath.item]["awayTeam"] as![String:Any]
        let HomeTeam = self.fixdata[indexPath.item]["homeTeam"] as![String:Any]
        
        cell.LftTeamName.text = HomeTeam["team_name"] as! String
        cell.RgtTeamName.text = AwayTeam["team_name"] as! String
        cell.lftimg.sd_setImage(with: URL(string: HomeTeam["logo"] as! String), completed: nil)
        cell.rgtimg.sd_setImage(with: URL(string: AwayTeam["logo"] as! String), completed: nil)
        cell.lftscore.text = "\(self.fixdata[indexPath.item]["goalsHomeTeam"] ?? "")"
        cell.rgtscore.text = "\(self.fixdata[indexPath.item]["goalsAwayTeam"] ?? "")"
        
        let timestamp =  "\(self.fixdata[indexPath.item]["event_timestamp"] ?? "")"
        
        let epocTime = TimeInterval(timestamp)
        
        let myDate = NSDate(timeIntervalSince1970: epocTime!)
        
        let dateFormatterGet = DateFormatter()
        // #  "updated_at" = "2020-09-07 12:04:42";
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let datefomatterPrint = DateFormatter()
        datefomatterPrint.dateFormat = "EEEE,dd MMM yyyy"
        // # let date: NSDate? = dateFormatterGet.date(from: myDate as! String ) as NSDate?
        cell.date.text = datefomatterPrint.string(from: myDate as Date )
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
}

// 99  #
//    #      let AwayTeam = self.allLastMan[indexPath.item]["awayTeam"] as![String:Any]
//               let HomeTeam = self.allLastM
// 102 #  an[indexPath.item]["homeTeam"] as![String:Any]


// 123    # #    if (fixtureDataList.size() > 4) {
//        for (int i = 0; i < fixtureDataList.size(); i++) {
//        if (headtoheadlist.size() != 5) {
//        if (fixtureDataList.get(i).statusShort.equalsIgnoreCase(FT))
//        headtoheadlist.add(fixtureDataList.get(i));
//        } else
//        break;
//
//
//        }
//        } else {
//        for (int i = 0; i < fixtureDataList.size(); i++)
//        if (fixtureDataList.get(i).statusShort.equalsIgnoreCase(FT))
//        headtoheadlist.addAll(fixtureDataList);
// 137  ##     }


// 171 ##  if (fixtureDataList.size() > 4) {
//    for (int i = 0; i < fixtureDataList.size(); i++) {
//    if (headtoheadlist.size() != 5) {
//    if (fixtureDataList.get(i).statusShort.equalsIgnoreCase(FT))
//    headtoheadlist.add(fixtureDataList.get(i));
//    } else
//    break;
//
//
//    }
//    } else {
//    for (int i = 0; i < fixtureDataList.size(); i++)
//    if (fixtureDataList.get(i).statusShort.equalsIgnoreCase(FT))
//    headtoheadlist.addAll(fixtureDataList);
//   ## }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "HeadTableViewCell", for: indexPath) as! HeadTableViewCell
//       let AwayTeam = self.fixdata[indexPath.item]["awayTeam"] as![String:Any]
//        let HomeTeam = self.fixdata[indexPath.item]["homeTeam"] as![String:Any]
////  ##      if(fixdata.count>4){
////            for _ in 0...fixdata.count {
////                if (fixdata.count != 5){
////
////
////
////
////                }
////
////
////
////
////
////            }
////  ##      }
//        cell.LftTeamName.text = HomeTeam["team_name"] as! String
//        cell.RgtTeamName.text = AwayTeam["team_name"] as! String
//        cell.lftimg.sd_setImage(with: URL(string: HomeTeam["logo"] as! String), completed: nil)
//        cell.rgtimg.sd_setImage(with: URL(string: AwayTeam["logo"] as! String), completed: nil)
//
//
//        cell.lftscore.text = "\(self.fixdata[indexPath.item]["goalsHomeTeam"] ?? "")"
//        cell.rgtscore.text = "\(self.fixdata[indexPath.item]["goalsAwayTeam"] ?? "")"
//
//        var timestamp =  "\(self.fixdata[indexPath.item]["event_timestamp"] ?? "")"
//
//        var epocTime = TimeInterval(timestamp)
//
//        let myDate = NSDate(timeIntervalSince1970: epocTime!)
//
//         let dateFormatterGet = DateFormatter()
//        // #  "updated_at" = "2020-09-07 12:04:42";
//         dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
//         let datefomatterPrint = DateFormatter()
//         datefomatterPrint.dateFormat = "EEEE,dd MMM yyyy"
//       // # let date: NSDate? = dateFormatterGet.date(from: myDate as! String ) as NSDate?
//        cell.date.text = datefomatterPrint.string(from: myDate as Date )
//
//
//
//
//
//
//
//        return cell
// 237   }

