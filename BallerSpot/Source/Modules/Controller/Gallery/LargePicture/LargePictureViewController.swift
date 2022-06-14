//
//  LargePictureViewController.swift
//  BallerSpot
//
//  Created by Imac on 17/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class LargePictureViewController: UIViewController {

    @IBOutlet weak var rgtbtn: UIButton!
    @IBOutlet weak var leftbtn: UIButton!
    @IBOutlet weak var largeimg: UIImageView!
    var positioncount = Int()
   var largeimgs = String()
     var allSmallPic = [[String:Any]]()
     let basicURL = "http://52.66.253.186/uploads/user/"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.largeimg.sd_setImage(with: URL(string: largeimgs), completed: nil)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)

            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)

  
    }

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                let totalcount = allSmallPic.count
                if positioncount == totalcount {
                                  positioncount = totalcount - 1
                       }
                       else{
                                  positioncount = positioncount + 1
                              }
                print(positioncount)
                if positioncount  < totalcount{
                      let imagess = allSmallPic[positioncount]["images"] as! String
                        let combineURL = basicURL + imagess
                       self.largeimg.sd_setImage(with: URL(string: combineURL ), completed: nil)
                }
                print("Swiped right")
            case .left:
                let totalcount = allSmallPic.count
                print(positioncount)
                if positioncount == 0 {
                                  positioncount = 0
                       }
                else{
                    positioncount = positioncount - 1
                }
                       if positioncount  < totalcount{
                             let imagess = allSmallPic[positioncount]["images"] as! String
                               let combineURL = basicURL + imagess
                              self.largeimg.sd_setImage(with: URL(string: combineURL ), completed: nil)
                }
                print("Swiped left")
            default:
                break
            }
        }
    }
    
    @IBAction func rgtbtn(_ sender: UISwipeGestureRecognizer) {
        let totalcount = allSmallPic.count
        if positioncount == totalcount {
                          positioncount = totalcount - 1
               }
               else{
                          positioncount = positioncount + 1
                      }
        print(positioncount)
        if positioncount  < totalcount{
              let imagess = allSmallPic[positioncount]["images"] as! String
                let combineURL = basicURL + imagess
               self.largeimg.sd_setImage(with: URL(string: combineURL ), completed: nil)
        }
       
        }
    
    @IBAction func lftbtn(_ sender: Any) {
        let totalcount = allSmallPic.count
        print(positioncount)
        if positioncount == 0 {
                          positioncount = 0
               }
        else{
            positioncount = positioncount - 1
        }
               if positioncount  < totalcount{
                     let imagess = allSmallPic[positioncount]["images"] as! String
                       let combineURL = basicURL + imagess
                      self.largeimg.sd_setImage(with: URL(string: combineURL ), completed: nil)
        }
        
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
