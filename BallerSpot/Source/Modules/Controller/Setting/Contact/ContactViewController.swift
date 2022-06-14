//
//  ContactViewController.swift
//  BallerSpot
//
//  Created by zeroit on 9/23/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var message: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmailAddress.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txtEmailAddress.frame.height))
        txtEmailAddress.leftViewMode = .always
        txtMobileNumber.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txtMobileNumber.frame.height))
        txtMobileNumber.leftViewMode = .always
        message.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: message.frame.height))
        message.leftViewMode = .always
    }
    func validateEmail(enteredEmail:String) -> Bool {
           let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
           return emailPredicate.evaluate(with: enteredEmail)
       }
    @IBAction func signUp_action(_ sender: Any) {
        self.view.endEditing(true)

        if ((self.txtEmailAddress.text != nil) && (self.txtEmailAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
        {
            if validateEmail(enteredEmail: txtEmailAddress.text!) == true
        {
            if ((self.txtMobileNumber.text != nil) && (self.txtMobileNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
            {
                if (self.txtMobileNumber.text?.count)!  >= 10
                {
                if ((self.message.text != nil) && (self.message.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
                {
                    let dict = [ "email": self.txtEmailAddress.text! ,
                                 "phone": self.txtMobileNumber.text!,
                                 "message": self.message.text!
                              ]
                    print(dict)
                    let headers = [String:String]()
                    APIManager.callApi.postApiRequest(controller: self, method: "http://52.66.253.186/index.php/app_contactus" ,header: headers , parameters: dict) {(response, status, data) in
                        print(response as Any)
                        if status
                        {
                            if let _ = response?.value(forKey: "status") as? String
                            {
                                if "\(response?.value(forKey: "status")! ?? "")" == "Success"
                                {
                                    self.clearTextFields()
                                    BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message" )! ?? "")", VC: self, cancel_action: false)
                                }else{
                                    BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
                                }
                            }
                        }
                    }
                }
                else
                {
                    BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Message", VC: self, cancel_action: false)
                }
            }
            else
                  {
                      BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter valid phone number", VC: self, cancel_action: false)
                  }
            }
            else{
                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Mobile Number", VC: self, cancel_action: false)
            }
        }
          else {
              BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter valid email adreess", VC: self, cancel_action: false)
             }
        }
        else
        {
            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Email Address", VC: self, cancel_action: false)
        }
        
    }
@IBAction func menubtn(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true
    }
    func clearTextFields()  {

        self.txtEmailAddress.text = nil
        self.txtMobileNumber.text = nil
        self.message.text = nil
    }
}


