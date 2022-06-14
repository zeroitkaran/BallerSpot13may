//
//  GetStartedVC.swift
//  Football_App
//
//  Created by Zero ITSolutions on 21/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.

import UIKit
import AVFoundation
import AVKit
import Alamofire
import FirebaseCrashlytics

class GetStartedVC: UIViewController {
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var signlabel: UILabel!
    @IBOutlet weak var signin: UIButton!
    var videourl = [String:Any]()
    var videopath = String()
    var Player: AVPlayer!
    var allbanner = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoCheck()
        getBanner()
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func videoCheck() {
        if UserDefaults.standard.value(forKey: "filePresent") != nil{
            guard let videoName = UserDefaults.standard.value(forKey: "filePresent") else {
                return
            }
            let fm = FileManager.default
            let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let path = docsurl.appendingPathComponent("\(videoName)")
            self.videopath = "\(path)"
            print(self.videopath)
            self.playvideo()
        }
        else{
            getVideo()
        }
    }
    func playvideo()  {
        let videoURL = URL(string: videopath)
        Player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: Player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        Player.volume = 10
        Player?.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: Player?.currentItem)
        Player.play()
    }
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        self.Player.seek(to: CMTime.zero)
        self.Player.play()
    }
    func getVideo(){
        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]

        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.startvideo,header: headers, parameters: ["" : ""] ) {(response, status, data) in
            if status{
                do{
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: []) as! [String:AnyObject]
                    print("json data is--->",jsondata)
                    let myArr1 = jsondata["video"] as! [String:AnyObject]
                    self.videourl = myArr1["result_data"] as! [String : AnyObject]
                    // let url = "http://zeroitsolutions.com/football/uploads/video/"
                    let url = myArr1["url"] as! String
                    let path = self.videourl["video"] as! String
                    self.videopath = url + path
                    let videoURL = NSURL(string: self.videopath)
                    let urlData=NSData(contentsOf: videoURL! as URL)
                    self.playvideo()
                    if((urlData) != nil)
                    {
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

                        let fileName = path //.ΩstringByDeletingPathExtension
                        let filePath="\(documentsPath)/\(fileName)"
                        print(filePath)
                        let fileManager = FileManager.default
                        if fileManager.fileExists(atPath: filePath) {
                            print("FILE AVAILABLE")
                            if "\(UserDefaults.standard.value(forKey: "filePresent")!)" != fileName{
                                urlData?.write(toFile: filePath, atomically: true)
                                UserDefaults.standard.set(fileName, forKey: "filePresent")
                            }
                        } else {
                            print("FILE NOT AVAILABLE")
                            urlData?.write(toFile: filePath, atomically: true)
                            UserDefaults.standard.set(fileName, forKey: "filePresent")
                        }
                        self.videopath = filePath
                    }
                    self.playvideo()
                    print("json data is--->",self.videopath)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    func getBanner(){
        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.banners,header: headers, parameters: ["" : ""] ) {(response, status, data) in
            if status{
                do{
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: []) as! [String : AnyObject]

                    print("json data is--->",jsondata)
                    let myArr1 = jsondata["banners"] as! [String : AnyObject]
                    MyVariables.bannerData = myArr1["result_data"] as! [[String : AnyObject]]
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    @IBAction func getStarted_action(_ sender: Any) {
//        fatalError()
//        Crashlytics.sharedInstance().crash()
        let userid = UserDefaults.standard.string(forKey: "loginsessionid")

       if !UserDefaults.standard.bool(forKey: "didSee") {
                UserDefaults.standard.set(true, forKey: "didSee")
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: Player?.currentItem)
                      let vc = storyboard?.instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController
                      vc.fromgetstarted1 = true
                     self.navigationController?.pushViewController(vc, animated: true)
                     Player.pause()
        }

       else if userid == nil {
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: Player?.currentItem)
            let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
            vc.fromgetstarted = true
            self.navigationController?.pushViewController(vc, animated: true)
            Player.pause()
        }
        else{
        Player.pause()
            setTabBarController()
        }
    }
    @IBAction func SignIn_action(_ sender: Any) {
        self.Player.pause()
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        vc.fromgetstarted = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
