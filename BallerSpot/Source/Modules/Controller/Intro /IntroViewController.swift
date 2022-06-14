//
//  IntroViewController.swift
//  BallerSpot
//
//  Created by Zeroit on 14/01/21.
//  Copyright © 2021 Zero ITSolutions. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var introCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var fromgetstarted1 = false
    var counter = 0
    
    var currentImage = 0
    let introTittle = [("Enter League you wish to play"),("Enter League you wish to play"),("Play current or upcoming match weeks"),("Predict scores of games by hitting arrows. Get them correct and gain points to win")]
    let introImages = [UIImage(named: "intro1"), UIImage(named: "intro2"), UIImage(named: "intro3"), UIImage(named: "intro4")]
    override func viewDidLoad() {
        super.viewDidLoad()

        
        introCollectionView.delegate = self
        introCollectionView.dataSource = self
        
        self.pageView.numberOfPages = introImages.count
        self.pageView.currentPage = 0
        
        changedPageNumber()
        // Do any additional setup after loading the view.
    }
    func changedPageNumber(){
           let pageNumber = introImages
        pageView.currentPage = pageNumber.count
           print(pageNumber)
         if counter == 4{
              btnNext.setTitle("START", for: .normal)
              btnSkip.isHidden = true
           }
           else{
               btnNext.setTitle("NEXT", for: .normal)
            let index = IndexPath.init(item: counter, section: 0)
            self.introCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
             if counter == 4{
                         btnNext.setTitle("START", for: .normal)
                         btnSkip.isHidden = true
                      }
           }
       }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        @IBAction func btnSkipTapped(_ sender: Any) {
//         NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: Player?.currentItem)
         let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
         vc.fromgetstarted = true
         self.navigationController?.pushViewController(vc, animated: true)

        }
         @IBAction func btNextTapped(_ sender: Any) {
           if btnNext.titleLabel?.text == "START"{
               btnSkip.isHidden = true
               let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
               vc.fromgetstarted = true
               self.navigationController?.pushViewController(vc, animated: true)
           }else{
                  self.pageView.numberOfPages = introImages.count
                  changedPageNumber()
            }
        }
    }

extension IntroViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroCollectionViewCell", for: indexPath ) as! IntroCollectionViewCell
//        cell.imgbtn.tag = indexPath.row
        
        let introTitle1 = introTittle[indexPath .row]

        let Images = introImages[indexPath .row]

        cell.IntroLbl.text = introTitle1
        cell.introImage.image = Images
        cell.introImage.layer.cornerRadius = 25
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureRight(sender:)))
               swipeRight.direction = UISwipeGestureRecognizer.Direction.right
               cell.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureRight(sender:)))
               swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
               cell.addGestureRecognizer(swipeLeft)
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
      //  cell.introImage.image = gesture.view as! UIImageView
        return cell
    }
     @objc func respondToSwipeGestureRight(sender: UISwipeGestureRecognizer){
        print(counter)
        if sender.direction == .left {
            
            let index = IndexPath.init(item: counter, section: 0)
            self.introCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            if counter == 3{
                         btnNext.setTitle("START", for: .normal)
                         btnSkip.isHidden = true
                              }
            if counter<3{
                counter += 1
               btnNext.setTitle("NEXT", for: .normal)
               btnSkip.isHidden = false
            }
          
           print("left swipe made")
        }
        if sender.direction == .right {
            counter -= 1
            let index = IndexPath.init(item: self.counter, section: 0)
            self.introCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            if counter == 3{
                          btnNext.setTitle("START", for: .normal)
                          btnSkip.isHidden = true
                                 }
            if counter<3{
               btnNext.setTitle("NEXT", for: .normal)
               btnSkip.isHidden = false
            }
            if counter == 0{
                counter += 1
            }
           
           print("right swipe made")
        }
    }
}
