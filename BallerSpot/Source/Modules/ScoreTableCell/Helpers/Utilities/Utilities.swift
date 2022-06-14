//
//  Utilities.swift
//  BallerSpot
//
//  Created by Zeroit on 27/02/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class Utilities {
    
    //MARK: Menu Bar
    class func OpenMEnu(FromVC: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sidemenu = storyboard.instantiateViewController(withIdentifier: "SideNavigationViewController") as! SideNavigationViewController
        let appdeligate = AppDelegate()
        appdeligate.window?.addSubview(sidemenu.view)
        FromVC.addChild(sidemenu)
        let transition = CATransition()
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        FromVC.view.layer.add(transition, forKey: nil)
        FromVC.view.addSubview(sidemenu.view)
        sidemenu.didMove(toParent: FromVC)
        sidemenu.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    class func setShadow(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 2.5
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowOpacity = 0.3
    }
    
}
