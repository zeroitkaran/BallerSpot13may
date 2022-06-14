//
//  SignUpVC.swift
//  Football_App
//
//  Created by Zero ITSolutions on 21/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var tcLabel: UILabel!
    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    @IBOutlet weak var privacyPolicyTxtView: UITextView!
    
    @IBOutlet weak var imgCheckBox: UIImageView!
    
    @IBOutlet weak var btnCheckBox: UIButton!
    var fromgetstarted = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
        self.txtFullName.delegate = self
        self.txtLastName.delegate = self
        self.txtEmailAddress.delegate = self
        self.txtPassword.delegate = self
        self.txtMobileNumber.delegate = self
        
//        txtFullName.addTarget(self, action: #selector(SignUpVC.textFieldDidChange(_:)), forControlEvents: UIControl.Event.EditingChanged)
    }
   
    func initialSetup(){
                
        txtFullName.attributedPlaceholder = NSAttributedString(string: "First Name",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
       txtLastName.attributedPlaceholder = NSAttributedString(string: "Last Name",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        UserName.attributedPlaceholder = NSAttributedString(string: "User Name",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtEmailAddress.attributedPlaceholder = NSAttributedString(string: "Email Address",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtMobileNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        
        let One = NSMutableAttributedString(string: "By Registering I agree to BallersPot " )
        
        One.setAttributes([NSAttributedString.Key.font : UIFont(name: "System Font Regular", size: CGFloat(15.0))!
            , NSAttributedString.Key.foregroundColor : UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)], range: NSRange(location:0,length:37)) // What ever range you want to give


        //        let andString = NSMutableAttributedString(string: " and ")
                
                let partOne = NSMutableAttributedString(string: " T&C.")
     //  partOne.setAttributes([NSAttributedString.Key.font : UIFont(name: "System Font Regular", size: CGFloat(15.0))!],
     //   range: NSRange(location:0,length:5)) // What ever range you want to give

        
        partOne.addAttribute(.link, value: "https://www.google.com", range: NSRange(location: 0, length: 5))

        let combination = NSMutableAttributedString()
        combination.append(One)
        combination.append(partOne)
        
        privacyPolicyTxtView.attributedText = combination
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtPassword{
            textField.isSecureTextEntry = true
        }
        if textField == txtLastName{
            textField.keyboardType = .default
        }
        if textField == txtMobileNumber{
            textField.keyboardType  = .numberPad
        }
        if textField == txtEmailAddress{
            textField.keyboardType  = .emailAddress
        }
        if textField == txtFullName{
            textField.keyboardType  = .default
        }
        if textField == UserName{
            textField.keyboardType  = .default
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength : Int!
        if textField == txtFullName{
            maxLength = 15
        } else if textField == txtLastName{
            maxLength = 15
        } else if textField == UserName{
            maxLength = 30
        } else if textField == txtEmailAddress{
            maxLength = 40
        } else if textField == txtMobileNumber{
            maxLength = 15
        } else if textField == txtPassword {
            maxLength = 16
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
//   func updateCharacterCount() {
//    let summaryCount = self.txtPassword.text?.characters.count
//
//    }
    
    @IBAction func back_action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func agreeTerms_action(_ sender: Any) {
        if self.imgCheckBox.image == UIImage.init(named: "uncheckbox")
        {
            imgCheckBox.image = UIImage(named:"checkbox")
        }
        else
        {
            imgCheckBox.image = UIImage(named:"uncheckbox")
        }
    }
    
    @IBAction func signUp_action(_ sender: Any) {
        self.view.endEditing(true)
        
        if (self.txtFullName.text!.count > 0 )
        {
//            if self.txtFullName.text!.rangeOfCharacter(from: .whitespacesAndNewlines) == nil
//          {
            if (self.txtLastName.text!.count > 0)
            {
//                  if self.txtLastName.text!.rangeOfCharacter(from: .whitespacesAndNewlines) == nil
//                   {
                if ((self.UserName.text!.count > 0) && (self.UserName.text!.rangeOfCharacter(from: .whitespacesAndNewlines) == nil))
                  {
                   if ((self.txtEmailAddress.text!.count > 0) && (self.txtEmailAddress.text!.rangeOfCharacter(from: .whitespacesAndNewlines) == nil))
                     {
                       if ((self.txtPassword.text!.count > 0) && (self.txtPassword.text!.rangeOfCharacter(from: .whitespacesAndNewlines) == nil))
                        {
//                          if ((self.txtMobileNumber.text!.count > 0) && (self.txtMobileNumber.text!.rangeOfCharacter(from: .whitespacesAndNewlines) == nil))
//                                      {
                                            if validateEmail(enteredEmail: txtEmailAddress.text!) == true
//                                          if self.imgCheckBox.image == UIImage.init(named: "checkbox")
                                            {
                                            if self.imgCheckBox.image == UIImage.init(named: "checkbox")
                                                {
                                                if (self.txtPassword.text?.count)!  >= 6
                                            {
//                                                if (self.txtMobileNumber.text?.count)!  >= 10
//                                        {
                                            var localTimeZoneIdentifier: String { return TimeZone.current.identifier }

                                            var timeZoneStr:String = "\(localTimeZoneIdentifier)"
                                            
                                            if localTimeZoneIdentifier.contains("") {
                                               
                                                let replaced = localTimeZoneIdentifier.replacingOccurrences(of: "Calcutta", with: "Kolkata")
                                                timeZoneStr = replaced
                                                //replacingCharacters(in: "Calcutta", with: "Kolkata)
                                            }
                                            let dict = ["first_name": self.txtFullName.text! ,
                                                        "last_name": self.txtLastName.text!,
                                                    "phone": self.txtMobileNumber.text!,
                                                    "email": self.txtEmailAddress.text! ,
                                                    "password": self.txtPassword.text!,
                                                    "username": self.UserName.text!,
                                                    "time_zone": timeZoneStr]
                                                    print(dict)
                                            let headers = [String:String]()
                                            APIManager.callApi.postApiRequest(controller: self, method: APIList.shared.signup,header: headers , parameters: dict) {(response, status, data) in
                                      print(response as Any)
                                                let home = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                                            self.navigationController?.pushViewController(home, animated: true);
                                      if status
                                      {
                                        if let _ = response?.value(forKey: "status") as? String
                                        {
                                            if "\(response?.value(forKey: "status")! ?? "")" == "Success"
                                            {
                                                self.clearTextFields()
                                                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
                                            }else{
                                                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
                                            }
                                        }
                                        else
                                        {
                                            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
                                        }
                                    }
                                  }
//                        }
//                                    else
//                                    {
//                                        BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter valid phone number", VC: self, cancel_action: false)
//                                    }
                       }
                               else
                               {
                                   BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Length of password should be in between 6 to 16 characters", VC: self, cancel_action: false)
                               }
                      }
                            else   {
                             BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please agree to terms and conditions!", VC: self, cancel_action: false)
                                               }
                                            }
                        else                       {

                        BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter valid email address", VC: self, cancel_action: false)
                       }
                    }
//                    else
//                    {
//                        BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Mobile Number", VC: self, cancel_action: false)
//                    }
//                }
                else
                {
                    BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Password", VC: self,  cancel_action: false)
                }
            }
              else
                {
                  BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Email Address", VC: self, cancel_action: false)
                }
             }
            else
            {
                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter User Name", VC: self, cancel_action: false)
            }
//        }
//             else{
//                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter valid Last Name", VC: self, cancel_action: false)
//                }
            }
            else{
                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Last Name", VC: self, cancel_action: false)
            }
//        }
//          else
//          {
//            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter valid First Name", VC: self, cancel_action: false)
//          }
        }
        else
        {
            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter First Name", VC: self, cancel_action: false)
        }
    }

    
    @IBAction func signIn_action(_ sender: Any) {
        if fromgetstarted{
            let vc = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            self.navigationController?.popViewController(animated: true)

        }
    }
    
    func clearTextFields()  {
        self.txtFullName.text = nil
        self.txtLastName.text = nil
        self.txtEmailAddress.text = nil
        self.txtPassword.text = nil
        self.txtMobileNumber.text = nil
        self.imgCheckBox.image = UIImage.init(named: "uncheckbox")
    }
}
