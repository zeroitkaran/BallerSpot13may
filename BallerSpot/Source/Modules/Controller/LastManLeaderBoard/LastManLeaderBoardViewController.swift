//
//  LastManLeaderBoardViewController.swift
//  BallerSpot
//
//  Created by zeroit on 9/18/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import MBProgressHUD

class LastManLeaderBoardViewController:UIViewController{
    var allLastMan = [[String:Any]]()
    var LeagueDetails = [String:Any]()
    var pool_amount = String()
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var potamt: UILabel!
    var allbanner = [[String: Any]]()
    var win = [[String:String]]()

    @IBOutlet weak var bannerCollection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var allbanners = [[String:Any]]()
    var bannerArray = [String]()
    var timer = Timer()
    var counter = 0
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkbanners()
        
        tableview.delegate = self
        tableview.dataSource = self
        bannerCollection.delegate = self
        bannerCollection.dataSource = self
        getLastMan()
        pageControl.numberOfPages = bannerArray.count
        pageControl.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
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
            if name["title"] as! String == "standings_leaderboard" {
                bannerArray.append(MyVariables.imageUrl + (name["image"] as! String))
            }
            print(bannerArray)//0, 1, 2, 3 ...
        }
        pageControl.numberOfPages = bannerArray.count
        pageControl.currentPage = 0
        DispatchQueue.main.async {
        }
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

    



    func getLastMan(){
        MBProgressHUD.showAdded(to: self.view, animated: true)

        var dict = [String:String]()
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        dict["league_id"] = LeagueDetails["league_id"] as? String
        dict["league_type"] = LeagueDetails["league_type"] as? String
        dict["id"] = LeagueDetails["id"] as? String
        print(dict)

        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]

        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.get_standingsLeaderboard,header: headers, parameters: dict) {(response, status, data) in
            // print(response as Any)
            if status{
                do{
                    //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary

                    print("json data is--->",jsondata)






                    guard let pool_amount = jsondata["pot_amount"] else {
                        return
                    }
                    MBProgressHUD.hide(for: self.view, animated: true)

                    self.pool_amount = "\(pool_amount)"
                    self.potamt.text = self.pool_amount
                    let msg = jsondata["message"] as! String

                    //  let decoder = JSONDecoder()
                    //let myArr1 = jsondata["Leagues"]
                    if msg != "No Data Found."{


                        let responsedata = jsondata["data"] as! [[String : Any]]
                        for Index  in responsedata.indices {
                            let winstatus = responsedata[Index]["win_status"] as! String
                            print(winstatus)
                            let wins = String(winstatus).split(separator: ",")
                                    
//                            var dict = [String:String]()
//                            dict["team_flag"] =  flagarr[Index]
//                            dict["winstatus"] = winStatusarr[Index]
                           // self.win.append(dict)

                        }
                        self.allLastMan = jsondata["data"] as! [[String : Any]]


                        self.tableview.reloadData()


                    }


                }catch{
                    MBProgressHUD.hide(for: self.view, animated: true)

                    print(error.localizedDescription)
                }
            }
        }
    }
    

    
    
    

    @IBAction func bckbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    



}

extension LastManLeaderBoardViewController:UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return allLastMan.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LastManLeaderTableViewCell",for: indexPath) as! LastManLeaderTableViewCell
        cell.counting.text = "\(indexPath.row + 1)"
        cell.name.text = (self.allLastMan[indexPath.row]["username"] as! String)
        let name1 = (self.allLastMan[indexPath.row]["first_name"] as! String)
        let last1 = (self.allLastMan[indexPath.row]["last_name"] as! String)
        cell.lastname.text = "\(name1)"+" \(last1)"
        

        if (self.allLastMan[indexPath.item]["id"] as! String ==  (D_Get_LoginData?.data?.id ?? "")) {
            cell.backgroundColor = UIColor.lightGray
        }
        else {
            cell.backgroundColor = UIColor.clear
        }
        
        let winString = self.allLastMan[indexPath.row]["predict_flag"] as! String
        let flagarr = winString.split(separator: ",").map(String.init)
        let winStatus = self.allLastMan[indexPath.row]["win_status"] as! String
        let winStatusarr = winStatus.split(separator: ",").map(String.init)
        //        var newarr = [[String:String]]()
        self.win.removeAll()
        for Index  in flagarr.indices {
            var dict = [String:String]()
            dict["team_flag"] =  flagarr[Index]
            dict["winstatus"] = winStatusarr[Index]
            self.win.append(dict)

        }
        print(self.win)
        
        if isNsnullOrNil(object: self.allLastMan[indexPath.item]["image"] as AnyObject)
        {
            cell.img.sd_setImage(with: URL.init(string:" " ),placeholderImage:UIImage(named:"dummy.png"))

        }
        else{
            cell.img.sd_setImage(with:URL.init(string: self.allLastMan[indexPath.item]["image"] as! String),completed:nil)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let tableViewCell = cell as? LastManLeaderTableViewCell else { return }

        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self , forRow:indexPath.row)
        
        
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard cell is LastManLeaderTableViewCell else {
            return }
        

        //allLastMan[indexPath.row] = tableViewCell.collectionViewOffset
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


extension LastManLeaderBoardViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollection {
            let cell = bannerCollection.dequeueReusableCell(withReuseIdentifier: "lastManLeaderBoardCollectionViewCell", for: indexPath) as! lastManLeaderBoardCollectionViewCell


            cell.bannerImage.sd_setImage(with: URL.init(string: bannerArray[indexPath.row]), completed: nil)
            return cell

        }
        else   {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMSLBCollectionViewCell", for: indexPath) as! LMSLBCollectionViewCell
            cell.img.sd_setImage(with: URL(string:  win[indexPath.row]["team_flag"]! ), completed: nil)
            if win[indexPath.row]["winstatus"] == "0" {
                cell.topimg.image = UIImage(named: "wait")

            }
            else if win[indexPath.row]["winstatus"] == "1"{
                cell.topimg.image = UIImage(named: "win")

            }
            else{
                cell.topimg.image = UIImage(named: "loose")

            }
            return cell
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == bannerCollection{
            return 1
        }
        else{
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == bannerCollection{
            return bannerArray.count
        }
        else{
            return win.count
        }

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }

}


class lastManLeaderBoardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImage: UIImageView!

}


