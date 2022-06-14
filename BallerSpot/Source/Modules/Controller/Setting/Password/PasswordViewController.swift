//
//  PasswordViewController.swift
//  BallerSpot
//
//  Created by zeroit on 9/23/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var passwordTextField1: UITextField!
    @IBOutlet weak var passwordTextField2: UITextField!
    @IBOutlet weak var passwordTextField3: UITextField!
    let button = UIButton(type: .custom)
    var btnColor = UIButton(type: .custom)
    let button2 = UIButton(type: .custom)
    var btnColor2 = UIButton(type: .custom)
    let button3 = UIButton(type: .custom)
    var btnColor3 = UIButton(type: .custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
        passwordTextField1.rightViewMode = .unlessEditing
        button.setImage(UIImage(named: "closedEye.png"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: -10, bottom: 2, right: 15)
        button.frame = CGRect(x:CGFloat(passwordTextField1.frame.size.width - 25), y:CGFloat(5), width: CGFloat(30), height: CGFloat(50))
        button.addTarget(self, action: #selector(self.btnpasswordVisibilityClicked), for: .touchUpInside)
        passwordTextField1.rightView = button
        passwordTextField1.rightViewMode = .always
         button.isSelected = false
        
        passwordTextField2.rightViewMode = .unlessEditing
        button2.setImage(UIImage(named: "closedEye.png"), for: .normal)
        button2.imageEdgeInsets = UIEdgeInsets(top: 2, left: -10, bottom: 2, right: 15)
        button2.frame = CGRect(x:CGFloat(passwordTextField2.frame.size.width - 25), y:CGFloat(5), width: CGFloat(30), height: CGFloat(50))
        button2.addTarget(self, action: #selector(self.btnpasswordVisibilityClicked2), for: .touchUpInside)
        passwordTextField2.rightView = button2
        passwordTextField2.rightViewMode = .always
        
        passwordTextField3.rightViewMode = .unlessEditing
        button3.setImage(UIImage(named: "closedEye.png"), for: .normal)
        button3.imageEdgeInsets = UIEdgeInsets(top: 2, left: -10, bottom: 2, right: 15)
        button3.frame = CGRect(x:CGFloat(passwordTextField3.frame.size.width - 25), y:CGFloat(5), width: CGFloat(30), height: CGFloat(50))
        button3.addTarget(self, action: #selector(self.btnpasswordVisibilityClicked3), for: .touchUpInside)
        passwordTextField3.rightView = button3
        passwordTextField3.rightViewMode = .always
        
        passwordTextField1.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField1.frame.height))
        passwordTextField1.leftViewMode = .always
        passwordTextField2.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField1.frame.height))
        passwordTextField2.leftViewMode = .always
        passwordTextField3.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField1.frame.height))
        passwordTextField3.leftViewMode = .always
    }
    @IBAction func btnpasswordVisibilityClicked(_ sender: Any) {
        if button.isSelected {
            self.passwordTextField1.isSecureTextEntry = false
            button.setImage(UIImage(named: "openedEye.png"), for: .normal)
            button.isSelected = false
} else {
            self.passwordTextField1.isSecureTextEntry = true
            button.setImage(UIImage(named: "closedEye.png"), for: .normal)
            button.isSelected = true
}
    }
            @IBAction func btnpasswordVisibilityClicked2(_ sender: Any) {
            if button.isSelected {
            self.passwordTextField2.isSecureTextEntry = false
            button2.setImage(UIImage(named: "openedEye.png"), for: .normal)
            button.isSelected = false
} else {
            self.passwordTextField2.isSecureTextEntry = true
            button2.setImage(UIImage(named: "closedEye.png"), for: .normal)
            button.isSelected = true
}
    }
            @IBAction func btnpasswordVisibilityClicked3(_ sender: Any) {
            if button.isSelected {
            self.passwordTextField3.isSecureTextEntry = false
            button3.setImage(UIImage(named: "openedEye.png"), for: .normal)
            button.isSelected = false
} else {
            self.passwordTextField3.isSecureTextEntry = true
            button3.setImage(UIImage(named: "closedEye.png"), for: .normal)
            button.isSelected = true
}
    }
            @IBAction func menubtn(_ sender: Any) {
            Utilities.OpenMEnu(FromVC: self)
            self.tabBarController?.tabBar.isHidden = true
    }
    func initialSetup(){
        passwordTextField1.attributedPlaceholder = NSAttributedString(string: "Current Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField2.attributedPlaceholder = NSAttributedString(string: "New Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField3.attributedPlaceholder = NSAttributedString(string: "Confirm New Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }

    @IBAction func submit(_ sender: Any) {
        self.view.endEditing(true)

        if ((self.passwordTextField1.text != nil) && (self.passwordTextField1.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
        
            {
            if ((self.passwordTextField2.text != nil) && (self.passwordTextField2.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
            {
                if ((self.passwordTextField3.text != nil) && (self.passwordTextField3.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
                {
                    if ((self.passwordTextField2.text!.count) >= 6) && ((self.passwordTextField3.text!.count) >= 6)
                {
                    let dict = [ "oldpassword": self.passwordTextField1.text! ,
                                 "newpassword": self.passwordTextField2.text!,
                                 "confirmpassword": self.passwordTextField3.text!,
                                 "user_id" : "\(D_Get_LoginData?.data?.id ?? "")"
                    ]
                    print(dict)
                    let headers = [String:String]()
                    APIManager.callApi.postApiRequest(controller: self, method: APIList.shared.changeuserpassword ,header: headers , parameters: dict) {(response, status, data) in
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
                    BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Length of password should be in between 6 to 16 characters", VC: self, cancel_action: false)
                }
            }
            else{
                    BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please Re-enter New Password", VC: self, cancel_action: false)
                }
        }
            else
          {
              BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter New Password", VC: self, cancel_action: false)
          }
        }
        else
        {
            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please Enter Old Password ", VC: self, cancel_action: false)
        }
    }

            func clearTextFields()  {

                self.passwordTextField1.text = nil
                self.passwordTextField2.text = nil
                self.passwordTextField3.text = nil
            }

}
