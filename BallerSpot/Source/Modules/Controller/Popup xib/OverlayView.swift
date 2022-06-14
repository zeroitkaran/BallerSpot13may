//
//  OverlayView.swift
//  BallerSpot
//
//  Created by zeroit on 11/23/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import MBProgressHUD

class OverlayView: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    @IBOutlet weak var PopUPTableView: UITableView!
    
    var scoreTableCell = ScoreTableCell()
    
    var AllPicks = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        PopUPTableView.delegate = self
        PopUPTableView.dataSource = self
        PopUPTableView.register(UINib(nibName: "ScoreTableCell", bundle: nil), forCellReuseIdentifier: "ScoreTableCellReuse")
        PopUPTableView.tableFooterView = UIView()
    }
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        guard translation.y >= 0 else { return }
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
extension OverlayView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllPicks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        scoreTableCell = tableView.dequeueReusableCell(withIdentifier: "ScoreTableCellReuse", for: indexPath) as! ScoreTableCell
        scoreTableCell.selectionStyle = .none
        
        //let data = self.AllPicks[indexPath.row]
        
        scoreTableCell.imgHomeTeam.sd_setImage(with: URL(string: self.AllPicks[indexPath.row]["home_team_logo"] as! String), completed: nil)
        scoreTableCell.imgAwayTeam.sd_setImage(with: URL(string: self.AllPicks[indexPath.row]["away_team_logo"] as! String), completed: nil)
        scoreTableCell.lblHomeTeamName.text = (self.AllPicks[indexPath.row]["home_team_name"] as! String)
        scoreTableCell.lblAwayTeamName.text = (self.AllPicks[indexPath.row]["away_team_name"] as! String)
//        if ("final_home_score" != nil && "final_away_score" != nil){
        scoreTableCell.startingsoon.text = "\(self.AllPicks[indexPath.row]["final_home_score"]!)" + " - " + "\(self.AllPicks[indexPath.row]["final_away_score"]!)"
//        }else{
//            scoreTableCell.startingsoon.text = "- -"
//        }
        scoreTableCell.txtLeftScore.text = "\(self.AllPicks[indexPath.row]["home_team_score"] as! String)"
        scoreTableCell.txtRightScore.text = "\(self.AllPicks[indexPath.row]["away_team_score"] as! String)"
        scoreTableCell.txtLeftScore.layer.borderColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 0.0).cgColor
        scoreTableCell.txtRightScore.layer.borderColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 0.0).cgColor

        scoreTableCell.txtLeftScore.isUserInteractionEnabled = false
        scoreTableCell.txtRightScore.isUserInteractionEnabled = false
        
        scoreTableCell.regularSeason.text = (self.AllPicks[indexPath.row]["round"] as! String)
        scoreTableCell.pts.text =  "\(self.AllPicks[indexPath.row]["pot_amount"] as! String + " Pts" )"

        let DateandTime = (self.AllPicks[indexPath.row]["event_date"] as! String).split(separator: "T")
        let Time = String(DateandTime[1]).split(separator: "+")
        scoreTableCell.lblDate.text = String(DateandTime[0])
        scoreTableCell.lblTime.textColor = UIColor.systemPink
        scoreTableCell.lblTime.font = UIFont.boldSystemFont(ofSize: 15)
        scoreTableCell.lblTime.text = "\(self.AllPicks[indexPath.row]["status"] as! String)"
        scoreTableCell.mypick.isHidden = true
        scoreTableCell.btnLeftUp.isHidden = true
        scoreTableCell.btnLeftDown.isHidden = true
        scoreTableCell.btnRightUp.isHidden = true
        scoreTableCell.btnRightDown.isHidden = true
        scoreTableCell.matchFinished.isHidden = true
        return scoreTableCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    
}
