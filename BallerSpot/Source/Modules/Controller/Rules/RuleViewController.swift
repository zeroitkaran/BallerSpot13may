//
//  RuleViewController.swift
//  BallerSpot
//
//  Created by zeroit on 12/16/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class RuleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var rules: UITextView!
    @IBAction func sideBtn(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
             self.tabBarController?.tabBar.isHidden = true
    }
}
