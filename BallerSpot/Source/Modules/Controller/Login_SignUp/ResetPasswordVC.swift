//
//  ResetPasswordVC.swift
//  Football_App
//
//  Created by Zero ITSolutions on 21/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import MBProgressHUD
class ResetPasswordVC: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    func initialSetup()
    {
        
        txtEmail.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
       
       
    }

    @IBAction func resetPassword_action(_ sender: Any) {
        self.view.endEditing(true)
        
        if ((self.txtEmail.text != nil) && (self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
        {
            let dict = ["email": self.txtEmail.text! ]
            print(dict)
                  
            let headers = [String:String]()
            MBProgressHUD.showAdded(to: self.view, animated: true)
            APIManager.callApi.postApiRequest(controller: self, method: APIList.shared.forgetpassword,header: headers , parameters: dict) {(response, status,data) in
                      print(response as Any)
                MBProgressHUD.hide(for: self.view, animated: true)
                      if status
                      {
                        if let _ = response?.value(forKey: "status") as? String
                        {
                            if "\(response?.value(forKey: "status")! ?? "")" == "Success"
                            {
                                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
                                self.txtEmail.text = nil
                            }else{
                                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter valid login credentials", VC: self, cancel_action: false)
                            }
                        }
                        else
                        {
                            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
                        }
                    }
                  }
        }
        else
        {
            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Email Address", VC: self, cancel_action: false)
        }
    }
    

    @IBAction func BtnActionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
