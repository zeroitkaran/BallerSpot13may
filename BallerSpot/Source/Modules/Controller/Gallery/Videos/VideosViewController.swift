//
//  VideosViewController.swift
//  BallerSpot
//
//  Created by Imac on 17/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideosViewController: UIViewController, AVPlayerViewControllerDelegate {
    var playerController = AVPlayerViewController()
    @IBOutlet weak var videoCollectionview: UICollectionView!
    var position = Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        videoCollectionview.delegate = self
        videoCollectionview.dataSource = self
        playvideo()
        
    }
    var allSmallvid = [[String:Any]]()
    var positioncount = Int()
    var largeimgs = String()
    var basicURL = "http://52.66.253.186/uploads/thumbnail/"
    var videoURL =  "http://52.66.253.186/uploads/video/"

    var allvideos = [[String:Any]]()
    @IBAction func menubar(_ sender: Any) {
        
        Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func playVideobutton(_ sender: UIButton) {
        self.position = sender.tag
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideosViewController") as! VideosViewController
        let videos = allvideos[position]["Video"] as! String
        // let combineURL = videoURL + videos
        //  vc.largeimgs = combineURL
        vc.positioncount = sender.tag
        vc.allSmallvid = self.allSmallvid

        guard let url = URL(string: "http://52.66.253.186/uploads/video/" + videos )else {return}
        let player = AVPlayer(url: url)
        var playerController = AVPlayerViewController()
        playerController.player = player
        playerController.allowsPictureInPicturePlayback = true
        playerController.player?.play()
        self.present(playerController, animated: true, completion: nil)
    }
    
        func playvideo(){
        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.videos,header: headers, parameters: ["" : ""] ) {(response, status, data) in
            // print(response as Any)
            if status{
                do{
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: []) as! [String : AnyObject]
                    print("json data is--->",jsondata)

                    let myArr1 = jsondata["data"] as! [String : AnyObject]
                    let urlPath = myArr1["url"] as! String
                    self.allvideos = myArr1["result_data"] as! [[String : AnyObject]]
                    self.videoCollectionview.reloadData()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension VideosViewController:UICollectionViewDataSource,UICollectionViewDelegate{
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allvideos.count
    }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as! VideosCollectionViewCell
        cell.button.tag = indexPath.row
        cell.video.layer.cornerRadius = 6

        let vidURL = self.allvideos[indexPath.item]["thumbnail"] as! String
        let combineURL = basicURL + vidURL

        //self.allSmallPic[indexPath.item]["images"]
        cell.video.sd_setImage(with: URL.init(string:  combineURL  ),completed: nil)
        cell.playbtn.image = UIImage(named: "playy")
        return cell
    }
}
