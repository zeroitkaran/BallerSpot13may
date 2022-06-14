//
//  MatchTypeVC.swift
//  BallerSpot
//
//  Created by Rahul Raman  Sharma on 05/08/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//f

import UIKit

class MatchTypeVC: UIViewController  {
    
    @IBOutlet weak var collectionMatchesType: UICollectionView!
    @IBOutlet weak var viewNAvigation: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageView: UIPageControl!
    var allbanners = [[String:Any]]()
    var bannerArray = [String]()
    var timer = Timer()
    var counter = 0
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    var TitleArray = ["Prediction", "Last Man Standing","Leader Board","Last Man Standing Leader Board"]
    var LeagueDetail = [String:Any]()
 //   var selectRound = String()
    //var allLeagues = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        checkbanners()
        print(LeagueDetail)
        collectionMatchesType.delegate = self
        collectionMatchesType.dataSource = self
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        collectionMatchesType.register(UINib(nibName: "MatchCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MatchCollectionCellReuse")
        //BannerCollectionViewCellIdentifier
        
//        bannerCollectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCellIdentifier")
        titleLabel.text = LeagueDetail["name"] as? String
        let cut_threat_status = LeagueDetail["cut_threat_status"] as! String
        if cut_threat_status == "0"{
            TitleArray = ["Prediction","Leader Board"]
        }else{
            TitleArray = ["Prediction", "Last Man Standing","Leader Board","Last Man Standing Leader Board"]
        }

        pageView.numberOfPages = bannerArray.count
        pageView.currentPage = 0
        DispatchQueue.main.async {

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkbanners(){
        print(MyVariables.bannerData[0])
        for (index, name) in MyVariables.bannerData.enumerated()
        {
            //YOUR LOGIC....
            print(name)
            if name["title"] as! String == "leagues" {
                bannerArray.append(MyVariables.imageUrl + (name["image"] as! String))
            }
            print(bannerArray)//0, 1, 2, 3 ...
        }
        pageView.numberOfPages = bannerArray.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }

    @objc func changeImage() {

        if counter < bannerArray.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        }
        else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }
//    func getBannerArray() {
//        for item in self.allbanners{
//            let aa = item["title"] as! String
//            if aa == "leagues" {
//                let image = item["image"] as! String
//                let url = "http://zeroitsolutions.com/football/uploads/banners/"
//                let combineurl = url + image
//                bannerArray.append(combineurl)
//            }
//        }
//        
//        
//        print(bannerArray)
//        self.bannerCollectionView.reloadData()
//    }
    //    public func numberOfItems(in pagerView: FSPagerView) -> Int {
    //        return 3
    //    }
    //
    //    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
    //        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
    //        cell.imageView?.backgroundColor = UIColor.green
    //
    //        return cell
    //    }
    
    // MARK: - Collection View Delegates and Data
    
    @IBAction func back_action(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

}


extension MatchTypeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == collectionMatchesType{
            return 1
        }
        else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionMatchesType{
            return TitleArray.count
        }
        else{
            return bannerArray.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionMatchesType {
            let cell = collectionMatchesType.dequeueReusableCell(withReuseIdentifier: "MatchCollectionCellReuse", for: indexPath) as! MatchCollectionCell
            cell.userentry.isHidden = true
            cell.userlogo.isHidden = true
            cell.privatelbl.isHidden = true


           if indexPath.item == 0{
                cell.imgLogo.sd_setImage(with: URL.init(string: LeagueDetail["logo"] as! String), completed: nil)
                cell.lblLeagueName.text = "\(LeagueDetail["name"] ?? "") "+"\(self.TitleArray[indexPath.item] )"
            }
            else if indexPath.item == 1{
            if TitleArray.count == 2{
                cell.imgLogo.sd_setImage(with: URL.init(string: LeagueDetail["logo"] as! String), completed: nil)
                cell.lblLeagueName.text = "\(LeagueDetail["name"] ?? "") "+"\(self.TitleArray[indexPath.item] )"
            }else{
//                cell.imgLogo.sd_setImage(with: URL.init(string: LeagueDetail["logo"] as! String), completed: nil)
                cell.lblLeagueName.text = "\(LeagueDetail["name"] ?? "") "+"\(self.TitleArray[indexPath.item] )"
            }
           }
            else if indexPath.item == 2{
                cell.imgLogo.sd_setImage(with: URL.init(string: LeagueDetail["logo"] as! String), completed: nil)
                cell.lblLeagueName.text =  "\(LeagueDetail["name"] ?? "") "+"\(self.TitleArray[indexPath.item] )"
            }
            else if indexPath.item == 3{
//                cell.imgLogo.sd_setImage(with: URL.init(string: LeagueDetail["logo"] as! String), completed: nil)
                cell.lblLeagueName.text = "\(LeagueDetail["name"] ?? "") "+"\(self.TitleArray[indexPath.item] )"
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
            if collectionMatchesType.numberOfItems(inSection: 0) % 2 == 0
            {
                if indexPath.row == collectionMatchesType.numberOfItems(inSection: 0) - 1 || indexPath.row == collectionMatchesType.numberOfItems(inSection: 0) - 2
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
                if indexPath.row == collectionMatchesType.numberOfItems(inSection: 0) - 1
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
            let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "matchTypeBannerCollectionViewCell", for: indexPath) as! matchTypeBannerCollectionViewCell

            
            cell.self.bannerImg.sd_setImage(with: URL.init(string: bannerArray[indexPath.row]), completed: nil)
            //  cell.bannerImg.contentMode = .scaleAspectFit
            //        else {
            //            let cell = collectionBanner.dequeueReusableCell(withReuseIdentifier: "BannerMtypeCollectionViewCell", for: indexPath) as! BannerMtypeCollectionViewCell
            //
            //                  for item in self.allbanners{
            //                            let aa = item["title"] as! String
            //                            if aa == "rounds"{
            //                                let image = item["image"] as! String
            //                                let url = "http://zeroitsolutions.com/football/uploads/banners/"
            //                                let combineurl = url + image
            //                                print(combineurl)
            //                                cell.img.sd_setImage(with: URL.init(string: combineurl), completed: nil)
            //
            //
            //                                                     }
            //
            //                                                 }
            //
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = [String:String]()
        if collectionView == collectionMatchesType{
           let round_status = LeagueDetail["round_status"] as! String
            let cut_threat_status = LeagueDetail["cut_threat_status"] as! String
            if cut_threat_status == "0"{
                if round_status == "1"{
                    let arr = ["MatchDetailVC","LeaderBoardViewController"]
                    let selectVC = arr[indexPath.row]
                    if selectVC == "MatchDetailVC"{
                        let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! MatchDetailVC
                        VC.LeagueDetails = self.LeagueDetail
                        VC.banner = self.allbanners
                        self.navigationController?.pushViewController(VC, animated: true)
                    }
                    else if selectVC == "LeaderBoardViewController"{
                                       let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! LeaderBoardViewController
                                       VC.LeagueDetails = self.LeagueDetail
                                       print(LeagueDetail)
                                       self.navigationController?.pushViewController(VC, animated: true)
                                       
                                   }
                }else{
                let arr = ["PredictScoreVC","LeaderBoardViewController"]
                let selectVC = arr[indexPath.row]
                if selectVC == "PredictScoreVC"{
                    let VC = storyboard?.instantiateViewController(withIdentifier: "PredictScoreVC") as! PredictScoreVC
                    VC.LeagueDetail = self.LeagueDetail
                    self.navigationController?.pushViewController(VC, animated: true)
                
//                else if selectVC == "PremierManViewController" {
//                    let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! PremierManViewController
//                    VC.LeagueDetails = self.LeagueDetail
//                    self.navigationController?.pushViewController(VC, animated: true)
                }
                else if selectVC == "LeaderBoardViewController"{
                    let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! LeaderBoardViewController
                    VC.LeagueDetails = self.LeagueDetail
                    print(LeagueDetail)
                    self.navigationController?.pushViewController(VC, animated: true)
                    
                }
//                else{
//                    let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! LastManLeaderBoardViewController
//                    VC.LeagueDetails = self.LeagueDetail
//                    self.navigationController?.pushViewController(VC, animated: true)
//                }
                }
              
            }else{
            if round_status == "1"{
                let arr =  ["MatchDetailVC","PremierManViewController","LeaderBoardViewController","LastManLeaderBoardViewController"]
                let selectVC = arr[indexPath.row]

                if selectVC == "MatchDetailVC"{
                    let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! MatchDetailVC
                    VC.LeagueDetails = self.LeagueDetail
                    VC.banner = self.allbanners
                    self.navigationController?.pushViewController(VC, animated: true)
                }
                else
                if selectVC == "PremierManViewController" {
                    let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! PremierManViewController
                    VC.LeagueDetails = self.LeagueDetail
                    self.navigationController?.pushViewController(VC, animated: true)
                }
                else if selectVC == "LeaderBoardViewController"{
                    let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! LeaderBoardViewController
                    VC.LeagueDetails = self.LeagueDetail
                    print(LeagueDetail)
                    VC.titleStr = "Premier League best Leader Board"
                    self.navigationController?.pushViewController(VC, animated: true)
                }
                else {
                    let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! LastManLeaderBoardViewController
                    VC.LeagueDetails = self.LeagueDetail
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            }else{
                let arr =  ["PredictScoreVC","PremierManViewController","LeaderBoardViewController","LastManLeaderBoardViewController"]
                let selectVC = arr[indexPath.row]

                if selectVC == "PredictScoreVC"{
                    let VC = storyboard?.instantiateViewController(withIdentifier: "PredictScoreVC") as! PredictScoreVC
                   // VC.selectRound = "current"
                    VC.roundstatus = false
                    VC.LeagueDetail = self.LeagueDetail
                    self.navigationController?.pushViewController(VC, animated: true)
                }
                else
                if selectVC == "PremierManViewController" {
                    let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! PremierManViewController
                    VC.LeagueDetails = self.LeagueDetail
                    self.navigationController?.pushViewController(VC, animated: true)
                }
                else if selectVC == "LeaderBoardViewController"{
                    let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! LeaderBoardViewController
                    VC.LeagueDetails = self.LeagueDetail
                    print(LeagueDetail)
                    VC.titleStr = "Premier League best Leader Board"
                    self.navigationController?.pushViewController(VC, animated: true)
                }
                else {
                    let VC = storyboard?.instantiateViewController(withIdentifier: selectVC) as! LastManLeaderBoardViewController
                    VC.LeagueDetails = self.LeagueDetail
                    self.navigationController?.pushViewController(VC, animated: true)
                 }
                }
              }
            }
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionMatchesType{
            return CGSize.init(width: self.view.bounds.width / 2, height: self.collectionMatchesType.bounds.height / 1.5 - 40)
        }
        else if collectionView == bannerCollectionView{
            return CGSize(width: self.bannerCollectionView.bounds.width, height: self.bannerCollectionView.bounds.height)
        }
        else{
            return CGSize(width: 0, height: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
     
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //
    //        return UIEdgeInsets.init(top: 0.1, left: 0.0, bottom: 0.1, right: 0.0)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        if collectionView == collectionMatchesType{
    //                   return CGSize.init(width: self.view.bounds.width/2, height: self.view.bounds.width/2 - 30)
    //
    //        }
    //        else{
    //            return CGSize.init(width: self.view.bounds.width, height: self.view.bounds.width)
    //        }
    //
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return .zero
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return .zero
    //    }
    //

    
    
}

extension UIImage{

    func resizeImageWith(newSize: CGSize) -> UIImage {

        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height

        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth, height: collectionWidth/2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class matchTypeBannerCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var bannerImg: UIImageView!
}
