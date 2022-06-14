//
//  SettingViewController.swift
//  BallerSpot
//
//  Created by Imac on 17/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }


    
    @IBAction func menubar(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true


    }
//    @IBAction func notibtn(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    @IBAction func btnpass(_ sender: Any) {
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
        self.navigationController?.pushViewController(vc1, animated: true)
    }
    @IBAction func btncontact(_ sender: Any) {
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
              self.navigationController?.pushViewController(vc1, animated: true)
    }
    
    @IBAction func btnprivacy(_ sender: Any) {
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
              self.navigationController?.pushViewController(vc1, animated: true)
    }
    
     @IBAction func btnrules(_ sender: Any) {
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "RulesViewController") as! RulesViewController
              self.navigationController?.pushViewController(vc1, animated: true)
     }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
