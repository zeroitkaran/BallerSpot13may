//
//  SignInVC.swift
//  Football_App
//
//  Created by Zero ITSolutions on 21/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import MBProgressHUD
import Firebase

class SignInVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var ConstrainsTopFgtPwd: NSLayoutConstraint!
    @IBOutlet weak var viewPinNumber: UIView!
    
      @IBOutlet weak var imgCheckBox: UIImageView!
      @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPinNumber: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    var fcmtoken = String()
    var fromgetstarted = false
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPinNumber.isHidden = true
        ConstrainsTopFgtPwd.constant = 0
        
        txtUsername.text = ""
        txtPassword.text = ""
      //  txtUsername.text = "karanmehra.zeroit@gmail.com"
       // txtPassword.text = "123456"

        initialSetup()
        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
                Messaging.messaging().token { token, error in
                  if let error = error {
                    print("Error fetching FCM registration token: \(error)")
                  } else if let token = token {
                    print("FCM registration token: \(token)")
//                    self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
                    print(token)
                    self.fcmtoken = token
                  }
                }
    }
    @IBAction func BtnPin_action(_ sender: Any) {
         if self.imgCheckBox.image == UIImage.init(named: "uncheckbox")
         {
             imgCheckBox.image = UIImage(named:"checkbox")
            
            viewPinNumber.isHidden = false
                  ConstrainsTopFgtPwd.constant = 60
         }
         else
         {
            viewPinNumber.isHidden = true
                  ConstrainsTopFgtPwd.constant = 0
             imgCheckBox.image = UIImage(named:"uncheckbox")
         }
         
     }
    
    func initialSetup()
    {
        txtUsername.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        txtPinNumber.attributedPlaceholder = NSAttributedString(string: "Pin",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtPassword{
            textField.isSecureTextEntry = true
        }
        if textField == txtUsername{
            textField.keyboardType  = .emailAddress
        }
    }

    @IBAction func back_action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func forgotPwd_action(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                     self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signIn_action(_ sender: Any) {
        self.view.endEditing(true)
        
        if ((self.txtUsername.text != nil) && (self.txtUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
        {
            if (self.txtPassword.text?.count)!  >= 6
        {
            if ((self.txtPassword.text != nil) && (self.txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
            {
                    var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
                    print(localTimeZoneIdentifier)
                let dict = ["email": self.txtUsername.text! ,
                            "password": self.txtPassword.text! ,
                            "pin": "",
                            "auth_token":self.fcmtoken,
                            "time_zone": localTimeZoneIdentifier]
               
                      print(dict)
                MBProgressHUD.showAdded(to: self.view, animated: true)
                let headers = [String:String]()
                APIManager.callApi.postApiRequest(controller: self, method: APIList.shared.login,header: headers , parameters: dict) {(response, status,data) in
                          print(response as Any)
                        do{
                            let decoder = JSONDecoder()
                            let mydata = try decoder.decode(LoginDataDict.self, from: data)
                            
                            print("-------->>> \(mydata)")
                            MBProgressHUD.hide(for: self.view, animated: true)
                            D_Save_LoginData = mydata
                            
                            print( "\(D_Get_LoginData?.data?.id ?? "")")
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                          if status
                          {
                            if let _ = response?.value(forKey: "status") as? String
                            {
                                if "\(response?.value(forKey: "status")! ?? "")" == "Success"
                                {
                                    UserDefaults.standard.set("\(D_Get_LoginData?.data?.id ?? "")", forKey: "loginsessionid")
                                    setTabBarController()
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
                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Password", VC: self, cancel_action: false)
            }
        }
            else
            {
                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Length of password should be in between 6 to 16 characters", VC: self, cancel_action: false)
            }
            
        }
        else
        {
            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Email Address", VC: self, cancel_action: false)
        }
    }
    
    @IBAction func signUp_action(_ sender: Any) {
        if fromgetstarted{
            let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            self.navigationController?.popViewController(animated: true)

        }
    }
    
}



 
