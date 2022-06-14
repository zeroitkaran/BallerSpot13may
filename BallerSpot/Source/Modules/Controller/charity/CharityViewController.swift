//
//  CharityViewController.swift
//  BallerSpot
//
//  Created by Zeroit on 11/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.

import UIKit

class CharityViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var message: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
           self.initialSetup()
           self.fullname.delegate = self
           self.email.delegate = self
           self.phone.delegate = self
           self.address.delegate = self
           self.message.delegate = self
    }
    
    
    @IBAction func menubar(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength : Int!
        if textField == fullname{
            maxLength = 15
        } else if textField == address{
            maxLength = 60
        } else if textField == email{
            maxLength = 40
        } else if textField == phone{
            maxLength = 15
        } else if textField == message {
            maxLength = 120
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
    func initialSetup(){
        fullname.attributedPlaceholder = NSAttributedString(string: "Full Name",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        address.attributedPlaceholder = NSAttributedString(string: "Address",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        email.attributedPlaceholder = NSAttributedString(string: "Email Address",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        message.attributedPlaceholder = NSAttributedString(string: "Type your Mesage here",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        phone.attributedPlaceholder = NSAttributedString(string: "Phone Number",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    @IBAction func submitbtn(_ sender: Any) {
        
        
        
        if ((self.fullname.text != nil) && (self.fullname.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
        {
            if ((self.email.text != nil) && (self.email.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
            {
                if ((self.phone.text != nil) && (self.phone.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
                {
                    if ((self.address.text != nil) && (self.address.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
                    {
                        if ((self.message.text != nil) && (self.message.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
                        {
                            if self.validateEmail(enteredEmail: email.text!) == true
                            {
                                if (self.phone.text?.count)!  >= 10
                        {
                            let dict = ["user_id" : "\(D_Get_LoginData?.data?.id ?? "")",
                                        "name": self.fullname.text! ,
                                        "email": self.email.text!,
                                        "phone_no": self.phone.text!,
                                        "address": self.address.text! ,
                                        "message": self.message.text!]
                            print(dict)

                            let headers = [String:String]()
                            APIManager.callApi.postApiRequest(controller: self, method: APIList.shared.charity,header: headers , parameters: dict) {(response, status, data) in
                                print(response as Any)
                                //                                        let home = self.storyboard?.instantiateViewController(withIdentifier: "CharityViewController") as! CharityViewController
                                //                                    self.navigationController?.pushViewController(home, animated: true);
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
                        }
                                
                        }
                             else {
                                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter valid email adreess", VC: self, cancel_action: false)
                               }
                        }
                        else
                        {
                            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Message", VC: self, cancel_action: false)                        }
                    }                    else
                    {
                        BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Address", VC: self,  cancel_action: false)}
                }
                else{
                    BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Mobile Number", VC: self, cancel_action: false)
                }
            }
            else{
                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Email Address", VC: self, cancel_action: false)
            }
        }
        else
        {
            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Full Name", VC: self, cancel_action: false)
        }
        
        
        
    }
    
    func clearTextFields()  {
        self.fullname.text = nil
        self.email.text = nil
        self.phone.text = nil
        self.address.text = nil
        self.message.text = nil
    }
    
}




// 26 //    func PostCharity() {
//
////        {"user_id",
////        "name",
////        "email",
////        "address",
////        "phone_no",
////        "message"}
//         var dict = [String:String]()
//         dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
//           dict["first_name"] = self.firstname.text
//          dict["last_name"] = self.lastname.text
//         dict["mobile"] = self.mobilenumber.text
//         dict["image"] = D_Get_LoginData?.data?.image
//
//
//                             print(dict)
//
//                       let headers = [String:String]()
//        APIManager.callApi.postApiRequest(controller: self, method: APIList.shared.charity,header: headers , parameters: dict) {(response, status,data) in
//                                 print(response as Any)
//                               do{
//                                   let decoder = JSONDecoder()
//                                   let mydata = try decoder.decode(LoginDataDict.self, from: data)
//
//                                   print("-------->>> \(mydata)")
//
//                                  D_Save_LoginData = mydata
//
//                                 self.navigationController?.popViewController(animated: true)
//
//
//
//
//                               } catch {
//                                   print(error.localizedDescription)
//                               }
//     }
//
// 67    }


