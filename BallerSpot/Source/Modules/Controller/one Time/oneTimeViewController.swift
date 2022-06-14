//
//  oneTimeViewController.swift
//  BallerSpot
//
//  Created by Imac on 03/05/21.
//  Copyright © 2021 Zero ITSolutions. All rights reserved.
//

import UIKit

class oneTimeViewController: UIViewController {

    @IBOutlet weak var menuBarView: MenuTabsView!
    @IBOutlet var matchesBtn: UIButton!
    @IBOutlet var leaderboardBtn: UIButton!
    @IBOutlet var rankView: UIView!
    @IBOutlet var showHeight: NSLayoutConstraint!
    @IBOutlet var hideHeight: NSLayoutConstraint!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var rankShow: NSLayoutConstraint!
    @IBOutlet var rankHide: NSLayoutConstraint!
    var arrLiveScores = NSMutableArray.init()
    var arrData1 = NSMutableArray.init()
        
    var currentIndex: Int = 0
    var MenuTAB1 = ["Menu TAB 1","Menu TAB 2","Menu TAB 3","Menu TAB 4","Menu TAB 5","Menu TAB 6"]
    var MenuTAB2 = ["Menu TAB 1","Menu TAB 2","Menu TAB 3","Menu TAB 4","Menu TAB 5","Menu TAB 6"]
    var MenuTAB3 = ["Menu TAB 1","Menu TAB 2","Menu TAB 3","Menu TAB 4","Menu TAB 5","Menu TAB 6"]
    var MenuTAB4 = ["Menu TAB 1","Menu TAB 2","Menu TAB 3","Menu TAB 4","Menu TAB 5","Menu TAB 6"]
    var MenuTAB5 = ["Menu TAB 1","Menu TAB 2","Menu TAB 3","Menu TAB 4","Menu TAB 5","Menu TAB 6"]
 //   var tabs = [arrLiveScores]
  
    var pageController: UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        getEuroRounds()
        menuBarView.isSizeToFitCellsNeeded = true
       // menuBarView.collView.backgroundColor = UIColor.init(white: 0.97, alpha: 0.97)
        
        presentPageVCOnView()
        
        menuBarView.menuDelegate = self
        pageController.delegate = self
        pageController.dataSource = self
        
        //For Intial Display
        menuBarView.collView.selectItem(at: IndexPath.init(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
        matchesBtn.borderColor = .white
        matchesBtn.borderWidth = 1
        matchesBtn.layer.cornerRadius = 14
        rankView.isHidden = true
        matchesBtn.isSelected = true
        showHeight.isActive = false
        hideHeight.isActive = true
        rankShow.isActive = false
        rankHide.isActive = true
    }
    
    @IBAction func matchesBtnAction(_ sender: Any) {
        matchesBtn.isSelected = true
        leaderboardBtn.isSelected = false
        rankView.isHidden = true
        showHeight.isActive = false
        hideHeight.isActive = true
        rankShow.isActive = false
        rankHide.isActive = true
        matchesBtn.borderColor = .white
        matchesBtn.borderWidth = 1
        matchesBtn.layer.cornerRadius = 14
        leaderboardBtn.borderColor = .clear
       
    }
    @IBAction func leaderboardBtnAction(_ sender: Any) {
        matchesBtn.isSelected = false
        leaderboardBtn.isSelected = true
        rankView.isHidden = false
        showHeight.isActive = true
        hideHeight.isActive = false
        rankShow.isActive = true
        rankHide.isActive = false
        leaderboardBtn.borderColor = .white
        leaderboardBtn.borderWidth = 1
        leaderboardBtn.layer.cornerRadius = 14
        matchesBtn.borderColor = .clear

    }
    @IBAction func backBtnAction(_ sender: Any) {
        
    }
    
    func getEuroRounds() {
        var dict = [String:String]()
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        let headers = [
            
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
    APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.get_euro_rounds,header: headers, parameters: ["":""] ) {(response, status, data) in

        if status{
            do{
                let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary
              //  self.NoLiveScore.isHidden = true
                print("json data is--->",jsondata)
                let myArr1 = (jsondata["data"] as! NSArray)
                self.arrLiveScores = [NSMutableArray.init()]
                self.arrLiveScores = myArr1.mutableCopy() as! NSMutableArray
                self.menuBarView.dataArray = self.arrLiveScores as! [String]
                print(self.menuBarView.dataArray)
                self.pageController.setViewControllers([self.viewController(At: 0)!], direction: .forward, animated: true, completion: nil)
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
                    else{
                   //  self.NoLiveScore.isHidden = false
//                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
                }
            }
        }
    /*
     // Call back function
    func myLocalFunc(_ collectionView: UICollectionView, _ indexPath: IndexPath) {
        
        
        if indexPath.item != currentIndex {
            
            if indexPath.item > currentIndex {
                self.pageController.setViewControllers([viewController(At: indexPath.item)!], direction: .forward, animated: true, completion: nil)
            }else {
                self.pageController.setViewControllers([viewController(At: indexPath.item)!], direction: .reverse, animated: true, completion: nil)
            }
            
            menuBarView.collView.scrollToItem(at: IndexPath.init(item: indexPath.item, section: 0), at: .centeredHorizontally, animated: true)
            
        }
        
    }
     */
 
    func presentPageVCOnView() {
        
        self.pageController = storyboard?.instantiateViewController(withIdentifier: "PageControllerVC") as! PageControllerVC
//        if leaderboardBtn.isSelected == true{
            self.pageController.view.frame = CGRect.init(x: 0, y: mainView.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - mainView.frame.maxY)
//        }else leaderboardBtn.isSelected == true{
//        self.pageController.view.frame = CGRect.init(x: 0, y: menuBarView.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - menuBarView.frame.maxY)
//        }
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)
        self.pageController.didMove(toParent: self)
    }
    
    //Present ViewController At The Given Index
    func viewController(At index: Int) -> UIViewController? {
        
        if((self.menuBarView.dataArray.count == 0) || (index >= self.menuBarView.dataArray.count)) {
            return nil
        }
        
        let contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
        contentVC.strTitle = arrLiveScores[index] as? String
        contentVC.pageIndex = index
        currentIndex = index
        return contentVC
    }
}

extension oneTimeViewController: MenuBarDelegate {

    func menuBarDidSelectItemAt(menu: MenuTabsView, index: Int) {

        // If selected Index is other than Selected one, by comparing with current index, page controller goes either forward or backward.
        
        if index != currentIndex {

            if index > currentIndex {
                self.pageController.setViewControllers([viewController(At: index)!], direction: .forward, animated: true, completion: nil)
            }else {
                self.pageController.setViewControllers([viewController(At: index)!], direction: .reverse, animated: true, completion: nil)
            }

            menuBarView.collView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)

        }

    }

}


extension oneTimeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ContentVC).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewController(At: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ContentVC).pageIndex
        
        if (index == arrLiveScores.count) || (index == NSNotFound) {
            return nil
        }
        
        index += 1
        return self.viewController(At: index)
        
    }
   
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished {
            if completed {
                let cvc = pageViewController.viewControllers!.first as! ContentVC
                let newIndex = cvc.pageIndex
                menuBarView.collView.selectItem(at: IndexPath.init(item: newIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
                menuBarView.collView.scrollToItem(at: IndexPath.init(item: newIndex, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
}

