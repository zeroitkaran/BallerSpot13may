//
//  CharityTableViewCell.swift
//  BallerSpot
//
//  Created by Imac on 16/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class CharityTableViewCell: UITableViewCell, UITextFieldDelegate{
    @IBOutlet weak var fullname: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
  
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var message: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.fullname.delegate = self
        self.email.delegate = self
        self.phone.delegate = self
        self.address.delegate = self
        self.message.delegate = self
        

    }
    
//    @IBAction func submitbtn(_ sender: Any) {
//
//        if ((self.fullname.text != nil) && (self.fullname.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
//        {
//            if ((self.email.text != nil) && (self.email.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
//            {
//                if ((self.phone.text != nil) && (self.phone.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
//                    {
//                        if ((self.address.text != nil) && (self.address.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
//                            {
//                                if ((self.message.text != nil) && (self.message.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
//                                    {
//                                    let dict = ["name": self.fullname.text! ,
//                                                "email": self.email.text!,
//                                            "phone_no": self.phone.text!,
//                                            "address": self.address.text! ,
//                                            "message": self.message.text!]
//                                            print(dict)
//                                    let headers = [String:String]()
//                                    APIManager.callApi.postApiRequest(controller: self, method: APIList.shared.charity,header: headers , parameters: dict) {(response, status, data) in
//                              print(response as Any)
////                                        let home = self.storyboard?.instantiateViewController(withIdentifier: "CharityViewController") as! CharityViewController
////                                    self.navigationController?.pushViewController(home, animated: true);
//                              if status
//                              {
//                                if let _ = response?.value(forKey: "status") as? String
//                                {
//                                    if "\(response?.value(forKey: "status")! ?? "")" == "Success"
//                                    {
//                                        self.clearTextFields()
//                                        BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
//                                    }else{
//                                        BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
//                                    }
//                                }
//                                else
//                                {
//                                    BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
//                                }
//                            }
//                          }
//                }
//                                else
//                                {
//                                    BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Mobile Number", VC: self, cancel_action: false)
//                                }
//                            }
//                            else
//                            {
//                                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Password", VC: self,  cancel_action: false)
//                            }
//                        }
//                        else
//                        {
//                            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Email Address", VC: self, cancel_action: false)
//                        }
//                    }
//                        else{
//                            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Last Name", VC: self, cancel_action: false)
//                        }
//                    }
//                    else
//                    {
//                        BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Full Name", VC: self, cancel_action: false)
//                    }
//
//                }

    func clearTextFields()  {
        self.fullname.text = nil
        self.email.text = nil
        self.phone.text = nil
        self.address.text = nil
        self.message.text = nil
    }
        
        
        
        
        
        
        
        
    }
                  





            


        
//        override func setSelected(_ selected: Bool, animated: Bool) {
//            super.setSelected(selected, animated: animated)
//
//
//        }
            // Configure the view for the selected state
        

//        var dict = [String:String]()
//
//        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
//        dict["name"] = self.fullname.text
//        dict["email"] = self.email.text
//        dict["phone_no"] = self.phone.text
//        dict["message"] = self.message.text
//       // self.view.endEditing(true)
//
//        if ((self.fullname.text != nil) && (self.fullname.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
//                   {
//                    if ((self.email.text != nil) && (self.email.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
//                       {
//                        if ((self.phone.text != nil) && (self.phone.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
//                          {
//                            if ((self.address.text != nil) && (self.address.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
//                            {
//                                if ((self.message.text != nil) && (self.message.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""))
//                                {
//                        //        {"user_id",
//                        //        "name",
//                        //        "email",
//                        //        "address",
//                        //        "phone_no",
//                        //        "message"}
//
//                                 print(dict)
//
//                           let headers = [String:String]()
//                                    APIManager.callApi.postApiRequest(controller: self , method: APIList.shared.login,header: headers , parameters: dict) {(response, status,data) in
//                                     print(response as Any)
//                                   do{
//                                       let decoder = JSONDecoder()
//                                       let mydata = try decoder.decode(LoginDataDict.self, from: data)
//
//                                       print("-------->>> \(mydata)")
//
//                                      D_Save_LoginData = mydata
//
//                                       print( "\(D_Get_LoginData?.data?.id ?? "")")
//
//                                   } catch {
//                                       print(error.localizedDescription)
//                                   }
//                                 }
//                       }
//                        else
//                        {
//                        BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Your message", VC: self, cancel_action: false)
//                                }
//                            }
//                        else
//                        {
//                            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Address", VC: self, cancel_action: false)
//                                    }
//                            }
//                        else
//                        {
//                            BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter Phone Number", VC: self, cancel_action: false)
//                                }
//                            }
//                       else
//                       {
//                           BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please enter valid email", VC: self, cancel_action: false)
//                       }
//                   }
//                   else
//                   {
//                       BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "Please Enter Your Full Name", VC: self, cancel_action: false)
    
    
