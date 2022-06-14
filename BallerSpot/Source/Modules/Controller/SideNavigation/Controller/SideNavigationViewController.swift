//
//  SideNavigationViewController.swift
//  BallerSpot
//
//  Created by Zeroit on 26/02/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.


import UIKit


class SideNavigationViewController :UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var viewBGSideMenu: UIView!
    @IBOutlet weak var lname: UILabel!
    @IBOutlet weak var viewForLogout: UIView!
    @IBOutlet weak var viewForPrivateandlogout: UIView!
    @IBOutlet weak var viewForPrivateLeagues: UIView!
    @IBOutlet weak var submitbuttonOut: UIButton!
    @IBOutlet weak var cancelButtonOut: UIButton!
    
    @IBOutlet weak var pinText: UITextField!
    var pin = String()
//    var Logout = logout()
    
    
    @IBOutlet weak var tableViewMenu: UITableView!{
        didSet{
            tableViewMenu.delegate = self
            tableViewMenu.dataSource = self
        }
    }
    
    //self.useremail.text = D_Get_LoginData?.data?.email
    
    var selectedMenuItemIndex = 0
 
    var arrMenuImages = [#imageLiteral(resourceName: "white_home_3x") , #imageLiteral(resourceName: "white_leaderboard_3x"),#imageLiteral(resourceName: "MyHistorywhite"),#imageLiteral(resourceName: "output-onlinepngtools-1"),#imageLiteral(resourceName: "liveNews"),  #imageLiteral(resourceName: "white_photo_3x"),  #imageLiteral(resourceName: "videos"), #imageLiteral(resourceName: "guruSection"),#imageLiteral(resourceName: "league_tab"),#imageLiteral(resourceName: "charity--1---2-.png"),#imageLiteral(resourceName: "white_rules_3x"),#imageLiteral(resourceName: "white_settings_3x"),#imageLiteral(resourceName: "white_logout_3x")]
//    var arrMenuItemNames = ["Home", "Leader Board","My History","Wallet History", "Live News", "Photo Gallery", "Videos", "Guru Section","Private Leagues","Charity","How To Play","Settings","Logout"]
//    var viewController = ["LeaguesTabVC","LeaderBoardViewController","MyHistoryViewController","WalletViewController","LiveNewsViewController","PictureViewController","VideosViewController","guruSectionViewController","PrivateLeagueViewController","CharityViewController","RuleViewController","SettingViewController","LogoutViewController"]
    var arrMenuItemNames = ["Home", "Leader Board","My History", "Live News", "Photo Gallery", "Videos", "Guru Section","Private Leagues","Charity","How To Play","Settings","Logout"]
    var viewController = ["LeaguesTabVC","LeaderBoardViewController","MyHistoryViewController","LiveNewsViewController","PictureViewController","VideosViewController","guruSectionViewController","PrivateLeagueViewController","CharityViewController","RuleViewController","SettingViewController","LogoutViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.submitbuttonOut.layer.cornerRadius = 8
        self.cancelButtonOut.layer.cornerRadius = 8
        imgUser.layer.borderWidth = 2
        imgUser.layer.borderColor = UIColor.white.cgColor
        imgUser.clipsToBounds = true
        tableViewMenu.delegate = self
        tableViewMenu.dataSource = self
        self.lblUserEmail.text = D_Get_LoginData?.data?.email
        self.lblUserEmail.adjustsFontSizeToFitWidth = true
        self.lblUserEmail.minimumScaleFactor = 0.7
        self.viewForPrivateLeagues.layer.borderWidth = 2
        self.viewForPrivateLeagues.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        self.viewForLogout.layer.borderWidth = 2
        self.viewForLogout.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor

        self.lblUserName.text = D_Get_LoginData?.data?.username
        print(D_Get_LoginData?.data?.username)
//        self.lname.text = D_Get_LoginData?.data?.last_name
        print("\(D_Get_LoginData?.data?.image ?? "abc")")
        self.imgUser.sd_setImage(with: URL(string: D_Get_LoginData?.data?.image ?? ""), completed: nil)
//        self.perform(#selector(changeImageColorToYellow), with: nil, afterDelay: 2.5)
    }
    
    
    @IBAction func BtnActionCloseSideNavigation(_ sender: UIButton) {
        self.viewBGSideMenu.alpha = 1.0
        self.closeMenuBAr_Action()
    }
    
    func closeMenuBAr_Action(){
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    
    @IBAction func logoutBtnClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "loginsessionid")
//        let vc = storyboard?.instantiateViewController(withIdentifier: "startVC")
//
//        navigationController?.popToViewController(vc, animated: true)
//        let GetStartedVC = self.storyboard?.instantiateViewController(withIdentifier: "startVC")
//
//            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//
//            appDel.window?.rootViewController = GetStartedVC
        resetRoot()
    }
    func resetRoot() {
        let childNavigation = (self.storyboard?.instantiateViewController(withIdentifier: "startVC"))! as UIViewController

      //  let childNavigation = UINavigationController(rootViewController: viewController)
        childNavigation.willMove(toParent: self)
        addChild(childNavigation)
        childNavigation.view.frame = view.frame
        view.addSubview(childNavigation.view)
        childNavigation.didMove(toParent: self)
         }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.viewForPrivateandlogout.isHidden = true
        self.viewForLogout.isHidden = true
        self.viewForPrivateLeagues.isHidden = true

    }
    @IBAction func submitbtn(_ sender: Any) {
        self.pin = pinText.text!
        print(self.pin)
        postPin()

    }
    func postPin() {
        var dict = [String:String]()
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        dict["pinvalue"] = self.pin



                            print(dict)

                      let headers = [String:String]()
        APIManager.callApi.postApiRequest(controller: self, method: APIList.shared.pinvalue,header: headers , parameters: dict) {(response, status,data) in
                                print(response as Any)
                              do{
                                  let decoder = JSONDecoder()
                                  let mydata = try decoder.decode(LoginDataDict.self, from: data)

                                  print("-------->>> \(mydata)")

                              //   D_Save_LoginData = mydata
                                self.getLeague()

                                //self.navigationController?.popViewController(animated: true)




                              } catch {
                                  print(error.localizedDescription)
                              }
    }

    }

    func getLeague() {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "LeaguesTabVC") as! LeaguesTabVC
//                     self.navigationController?.pushViewController(vc, animated: true)
        NotificationCenter.default.post(name: Notification.Name("private"), object: nil)


        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
}


extension SideNavigationViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMenuItemNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as? SideMenuTableViewCell else { return UITableViewCell() }
        if self.selectedMenuItemIndex == indexPath.row{
                   cell.viewSelected.isHidden = false
               }else{
                   cell.viewSelected.isHidden = true
               }
        
        cell.imgView.image = self.arrMenuImages[indexPath.row]
        cell.lblName.text = self.arrMenuItemNames[indexPath.row]
        cell.lblName.isUserInteractionEnabled = true
        cell.imgView.isUserInteractionEnabled = true
        cell.selectionStyle = .none
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMenuItemIndex = indexPath.row
        print(indexPath.row)
        if arrMenuItemNames[indexPath.row] == "Logout"{

            self.viewForPrivateandlogout.isHidden = false
            self.viewForLogout.isHidden = false
        }
        else if arrMenuItemNames[indexPath.row] == "Private Leagues" {
            self.viewForPrivateandlogout.isHidden = false
            self.viewForPrivateLeagues.isHidden = false
        }
        else if arrMenuItemNames[indexPath.row] == "Home" {
            let selectVC = viewController[indexPath.row]
           let VC = storyboard?.instantiateViewController(withIdentifier: selectVC)
            self.viewBGSideMenu.alpha = 1.0
            self.closeMenuBAr_Action()
            if let viewControllers = self.navigationController?.viewControllers
            {
                if viewControllers.contains(where: {
                    return $0 is LeaguesTabVC
                })
                {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                else{
                    self.navigationController?.pushViewController(VC!, animated: true)
                }
            }
             
//            self.navigationController?.popToRootViewController(animated: true)
//            self.navigationController?.pushViewController(VC!, animated: true)
        }
        else{
        let selectVC = viewController[indexPath.row]
        let VC = storyboard?.instantiateViewController(withIdentifier: selectVC)
        self.navigationController?.pushViewController(VC!, animated: true)
        self.closeMenuBAr_Action()

       // self.tableViewMenu.reloadData()
        }
      
    }
    
    // mark:- color change
    
    @objc func changeImageColorToYellow (){
          let templateImage = imgUser.image?.withRenderingMode(.alwaysTemplate)
          imgUser.image = templateImage
          imgUser.tintColor = UIColor.red
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
  
}
//if let viewController = storyboard?.instantiateViewController(identifier: "TrailViewController") as? TrailViewController {
//      viewController.trail = selectedTrail
//      navigationController?.pushViewController(viewController, animated: true)
  //}
