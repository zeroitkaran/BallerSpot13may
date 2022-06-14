//
//  MatchDetailVC.swift
//  BallerSpot
//
//  Created by Zero ITSolutions on 24/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import MBProgressHUD

class MatchDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var img = [ #imageLiteral(resourceName: "all_rounds"),#imageLiteral(resourceName: "semifinal"),#imageLiteral(resourceName: "quater"),#imageLiteral(resourceName: "final"),#imageLiteral(resourceName: "epl1"),#imageLiteral(resourceName: "first-round")]
    var allRounds = [String]()
    var completedRounds = [String]()
    var currentRounds = [String]()
    var upcomingRounds = [String]()
    var banner = [[String:Any]]()
    var bannerArray = [String]()
    var allbanners = [[String: Any]]()
    var LeagueDetails = [String:Any]()
    var timer = Timer()
    @IBOutlet weak var collectionMatchCategories: UICollectionView!
    @IBOutlet weak var bannerCollection: UICollectionView!
    @IBOutlet weak var titlename: UILabel!

    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewForRounds: UIView!
    @IBOutlet weak var viewForCurrentMatch: UIView!
    @IBOutlet weak var viewForUpcomingMatch: UIView!
    @IBOutlet weak var viewForCompleteMatch: UIView!
    @IBOutlet weak var currentBtn: UIButton!
    @IBOutlet weak var upcomingBtn: UIButton!
    @IBOutlet weak var completeBtn: UIButton!
    
    var selectedLeagueId = ""
    var selectedName = ""
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        checkbanners()
        titlename.text = LeagueDetails["name"] as? String
        
        collectionMatchCategories.register(UINib(nibName: "MatchCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MatchCollectionCellReuse")
        //        bannerCollection.register(UINib(nibName: "bannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "bannerCollectionViewCell")
        pageControl.numberOfPages = bannerArray.count
        pageControl.currentPage = 0
        DispatchQueue.main.async {
         self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        bannerCollection.delegate = self
        bannerCollection.dataSource = self
        collectionMatchCategories.delegate = self
        collectionMatchCategories.dataSource = self
        if "\(LeagueDetails["round_status"] ?? "")" == "1"{
            self.getroundsdetails()

            checkbanners()
        }
        else{
            getRounds()

            checkbanners()
        }
        self.initialSetup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func checkbanners(){
        print(MyVariables.bannerData[0])
        for (index, name) in MyVariables.bannerData.enumerated()
        {
            //YOUR LOGIC....
            print(name)
            
            if name["title"] as! String == "rounds" {
                bannerArray.append(MyVariables.imageUrl + (name["image"] as! String))
            }
            print(bannerArray)//0, 1, 2, 3 ...
        }
        pageControl.numberOfPages == bannerArray.count
        pageControl.currentPage = 0

    }

    @objc func changeImage() {

        if counter < bannerArray.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter += 1
        }
        else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = counter
            counter = 1
        }
    }
    
    
    func initialSetup() {
        if "\(LeagueDetails["round_status"] ?? "")" == "1"{
            viewForRounds.isHidden = false
            collectionViewTopConstraint.constant = 50
        }
        else{
            viewForRounds.isHidden = true
            collectionViewTopConstraint.constant = 0
        }
    }
    func getRounds(){

        var dict = [String:String]()
        //     var lid =  LeagueDetail["league_id"]
        dict["league_id"] = LeagueDetails["league_id"] as? String


        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.getrounds,header: headers, parameters: dict ) {(response, status, data) in
            // print(response as Any)
            MBProgressHUD.hide(for: self.view, animated: true)
            if status{
                do{

                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary

                    print("json data is--->",jsondata)



                    let myArr1 = jsondata["rounds"] as! [String:Any]


                    self.allRounds = myArr1["result_data"] as! [String]
                    self.collectionMatchCategories.reloadData()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getroundsdetails(){

        var dict = [String:String]()
        dict["league_id"] = LeagueDetails["league_id"] as? String


        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        MBProgressHUD.showAdded(to: self.view, animated: true)
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.getroundsdetails,header: headers, parameters: dict ) {(response, status, data) in
            // print(response as Any)
            MBProgressHUD.hide(for: self.view, animated: true)
            if status{
                do{

                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary

                    print("json data is--->",jsondata)

                    let myArr1 = jsondata["rounds"] as! [String:Any]

                    self.allRounds = myArr1["current"] as! [String]
                    self.completedRounds = myArr1["completed"] as! [String]
                    self.currentRounds = myArr1["current"] as! [String]
                    self.upcomingRounds = myArr1["upcoming"] as! [String]
                    self.collectionMatchCategories.reloadData()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    func getLeagueDetails()
    {
        let dict = [String:String]()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let headers = ["X-RapidAPI-Key":"ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"]
        APIManager.callApi.getApiRequest(controller: self, method: "\(APIList.shared.getLeagues)\(selectedLeagueId)",header: headers , parameters: dict) {(response, status, data) in
            print(response as Any)
            MBProgressHUD.hide(for: self.view, animated: true)
            if status
            {
                if response != nil
                {
                    if let myArr = ((response as AnyObject).value(forKey: "api") as AnyObject).value(forKey: "leagues") as? NSArray
                    {
                        BallerSpotSingleton.sharedInstance.LeagueDetailArray = myArr.mutableCopy() as! NSMutableArray

                        DispatchQueue.main.async {
                            self.collectionMatchCategories.reloadData()
                        }
                    }
                }

                else
                {
                    BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
                }
            }
        }
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == collectionMatchCategories{
            return 1
        }
        else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionMatchCategories{
            return allRounds.count
        }
        else{
            return bannerArray.count
        }


    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionMatchCategories{
            let cell = collectionMatchCategories.dequeueReusableCell(withReuseIdentifier: "MatchCollectionCellReuse", for: indexPath) as! MatchCollectionCell
            cell.privatelbl.isHidden = true

            cell.userentry.isHidden = true
            cell.userlogo.isHidden = true
            // let imageLogo = "\((BallerSpotSingleton.sharedInstance.LeagueDetailArray[indexPath.row] as AnyObject).value(forKey: "logo")!)"
            cell.lblLeagueName.text = self.allRounds[indexPath.row]

            if allRounds[indexPath.row].lowercased().contains("quarter-finals"){
                cell.imgLogo.image = self.img[1]
            }
            else if allRounds[indexPath.row].lowercased().contains("semi-finals"){
                cell.imgLogo.image = self.img[2]
            }
            else if allRounds[indexPath.row].lowercased().contains("final"){
                cell.imgLogo.image = self.img[3]
            }
            else if allRounds[indexPath.row].lowercased().contains("first"){
                cell.imgLogo.image = self.img[4]
            }
            else{
                cell.imgLogo.image = self.img[0]
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
            if collectionMatchCategories.numberOfItems(inSection: 0) % 2 == 0
            {
                if indexPath.row == collectionMatchCategories.numberOfItems(inSection: 0) - 1 || indexPath.row == collectionMatchCategories.numberOfItems(inSection: 0) - 2
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
                if indexPath.row == collectionMatchCategories.numberOfItems(inSection: 0) - 1
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
        else {
            let cell = bannerCollection.dequeueReusableCell(withReuseIdentifier: "matchDetailsBannerCollectionViewCell", for: indexPath) as! matchDetailsBannerCollectionViewCell

            cell.bannerImage.sd_setImage(with: URL.init(string: bannerArray[indexPath.row]), completed: nil)
            // cell.bannerImage.contentMode = UIView.ContentMode.scaleAspectFill
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectVC = allRounds[indexPath.row]
        let aString = selectVC
        //      let newString = aString.replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
        let VC = storyboard?.instantiateViewController(withIdentifier: "PredictScoreVC") as! PredictScoreVC
        //  VC.rounds = self.allRounds
        VC.roundstatus = true
        VC.selectRound = self.allRounds[indexPath.row]
        VC.LeagueDetail = self.LeagueDetails
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionMatchCategories {
            return CGSize.init(width: collectionMatchCategories.bounds.width/2, height: collectionMatchCategories.bounds.width/2)
        }
        else
        //    if collectionView == bannerCollection
        {
            return CGSize(width: self.bannerCollection.bounds.width, height: self.bannerCollection.bounds.height)
        }
        //  else{
        //    return CGSize(width: 0, height: 0)
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
    
    @IBAction func back_btn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
        
    @IBAction func currentBtnClickd(_ sender: Any) {
        self.allRounds = currentRounds
        self.collectionMatchCategories.reloadData()
        viewForCurrentMatch.layer.backgroundColor = UIColor.red.cgColor
        viewForUpcomingMatch.layer.backgroundColor = UIColor.white.cgColor
        viewForCompleteMatch.layer.backgroundColor = UIColor.white.cgColor
        currentBtn.setTitleColor(.white, for: .normal)
        upcomingBtn.setTitleColor(.black, for: .normal)
        completeBtn.setTitleColor(.black, for: .normal)
        
    }
    
    @IBAction func upcomingBtnClicked(_ sender: Any) {
        self.allRounds = upcomingRounds
        self.collectionMatchCategories.reloadData()
        viewForCurrentMatch.layer.backgroundColor = UIColor.white.cgColor
        viewForUpcomingMatch.layer.backgroundColor = UIColor.red.cgColor
        viewForCompleteMatch.layer.backgroundColor = UIColor.white.cgColor
        currentBtn.setTitleColor(.black, for: .normal)
        upcomingBtn.setTitleColor(.white, for: .normal)
        completeBtn.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func completeBtnClicked(_ sender: Any) {
        self.allRounds = completedRounds
        self.collectionMatchCategories.reloadData()
        viewForCurrentMatch.layer.backgroundColor = UIColor.white.cgColor
        viewForUpcomingMatch.layer.backgroundColor = UIColor.white.cgColor
        viewForCompleteMatch.layer.backgroundColor = UIColor.red.cgColor
        currentBtn.setTitleColor(.black, for: .normal)
        upcomingBtn.setTitleColor(.black, for: .normal)
        completeBtn.setTitleColor(.white, for: .normal)
    }
}


class matchDetailsBannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    
}



