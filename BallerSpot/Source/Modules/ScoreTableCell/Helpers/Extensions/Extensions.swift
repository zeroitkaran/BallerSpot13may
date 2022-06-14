//
//  Extensions.swift
//  Football_App
//
//  Created by Zero ITSolutions on 22/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

extension UIView
{
    func addShadow()
    {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 6
    }
    
    
    func createGradientLayer(myColor1: UIColor, myColor2: UIColor) {
            
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.bounds
     
        gradientLayer.colors = [myColor1, myColor2]
     
        self.layer.addSublayer(gradientLayer)
    }
}

func setRootViewController(viewController: UIViewController) {
        let navController = UINavigationController(rootViewController: viewController)
        navController.isNavigationBarHidden = true
        if appDelegate.window == nil {
            //Create New Window here
            appDelegate.window = UIWindow.init(frame: UIScreen.main.bounds)
        }
    UIApplication.shared.windows.first?.rootViewController = navController
    UIApplication.shared.windows.first?.makeKeyAndVisible()
//        appDelegate.window?.rootViewController = navController
//        appDelegate.window?.makeKeyAndVisible()
    }

 func setTabBarController() {
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
    
//        let tabBar : TabBarController = UIStoryboard.init(storyboard: .main).controller()
        setRootViewController(viewController: vc)
    }
