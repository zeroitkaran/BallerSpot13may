//
//  BallerSpotSingleton.swift
//  BallerSpot
//
//  Created by Zero ITSolutions on 24/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation
import UIKit

class BallerSpotSingleton : NSObject{
    
    static let sharedInstance = BallerSpotSingleton()
    let appName = "BallersPot"
    
    //League
    var numberOfTeams = 0
    var LeaguesArr1 = [LeaguesDataModel]()
    var LeaguesArr = NSMutableArray()
    var LeagueDetailArray = NSMutableArray()
    var LeagueImagesArray = NSMutableArray()
    
    func showAlert(title: String, msg: String, VC: UIViewController, cancel_action: Bool)
    {
        let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        let OK_action = UIAlertAction.init(title: "OK", style: .default)
        alert.addAction(OK_action)
        if cancel_action
        {
        let Cancel_action = UIAlertAction.init(title: "Cancel", style: .default)
        alert.addAction(Cancel_action)
        }
        VC.present(alert, animated: true, completion: nil)
    }
    
    
}
