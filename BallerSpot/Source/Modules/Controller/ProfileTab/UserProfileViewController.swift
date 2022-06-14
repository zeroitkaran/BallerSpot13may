//
//  UserProfileViewController.swift
//  BallerSpot
//
//  Created by Zeroit on 12/03/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import SDWebImage




class UserProfileViewController: UIViewController, UITabBarControllerDelegate {

   
    @IBOutlet weak var imgPoints: UIImageView!
    @IBOutlet weak var imgRanking: UIImageView!
    @IBOutlet weak var imgYears: UIImageView!
    
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var useremail: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var year: UILabel!
    
    var event_timestamp : Int?
    var allProfileData = [String:Any]()
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
         let tabBarIndex = tabBarController.selectedIndex
        self.navigationController?.popToRootViewController(animated: true)
         if tabBarIndex == 0 {
             //do your stuff
         }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self

        let years = Calendar.current.component(.year, from: Date())
            userimg.layer.borderWidth = 2
            userimg.layer.borderColor = UIColor.white.cgColor
            userimg.clipsToBounds = true
            self.year.text = String(years)
        userDetails()
        
    }

    override func viewWillAppear(_ animated: Bool) {
         userDetails()
         self.userimg.sd_setImage(with: URL(string: D_Get_LoginData?.data?.image ?? ""), completed: nil)
         self.rank.text = D_Get_LoginData?.data?.ranking
        self.userId.text = D_Get_LoginData?.data?.username
         self.useremail.text = D_Get_LoginData?.data?.email
         let name = D_Get_LoginData?.data?.first_name as! String
         let last = D_Get_LoginData?.data?.last_name as! String
         self.username.text = name + " " + last
         self.point.text = D_Get_LoginData?.data?.pool_amount
     }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func userDetails()
    {

    var dict = [String:String]()
    dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"

                  let headers = [
                       "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
                       "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
                   ]

        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.profiledetails,header: headers, parameters: dict ) {(response, status, data) in
                       if status{
                           do{
                               let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: []) as! NSDictionary

                                                  print("json data is--->",jsondata)



                            self.allProfileData = jsondata["data"] as! [String : Any]
                            if ("ranking" != "0") {
                                self.rank.text = self.allProfileData["ranking"] as? String
                            } else {
                                self.rank.text = "0"  }
                            if ("pot_amount" != nil){
                                self.point.text = self.allProfileData["pot_amount"] as? String
                            }
                            let date = (self.allProfileData["created_at"] as! String).split(separator: " ")
                            let year = String(date[0]).split(separator: "-")
//                            self.userId.text = self.allProfileData["username"] as? String
                            self.year.text = String(year[0])

                          //  self.rank.text = "\(jsondata["pot_amount"] as! [String])"
                           }catch{
                               print(error.localizedDescription)
                           }
                       }
                   }
               }
    
    @IBAction func BtnActionEditProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditUserProfileViewController") as! EditUserProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func BtnActionOpenSideMenu(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true
    }
}
