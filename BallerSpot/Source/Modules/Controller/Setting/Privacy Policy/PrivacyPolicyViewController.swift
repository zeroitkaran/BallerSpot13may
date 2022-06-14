//
//  PrivacyPolicyViewController.swift
//  BallerSpot
//
//  Created by Zeroit on 11/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController ,WKNavigationDelegate{
    
    @IBOutlet weak var webview: WKWebView!
    
    var allPrivacy = [String:Any]()
override func viewDidLoad() {
        super.viewDidLoad()
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           let textSize = 500
           let javascript = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(textSize)%'"
          webView.evaluateJavaScript(javascript) { (response, error) in
               print()
           }
     }
        
         getPrivacy()

}

    @IBAction func menubtn(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        let textSize = 500
//
//        let javascript = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(textSize)%'"
//        webView.evaluateJavaScript(javascript) { (response, error) in
//            print()
//        }
//    }
      
        func loadHTMLStringImage() {
        
        //let htmlString =  "\(self.allPrivacy["content"] ?? "")"
        let htmlString = self.allPrivacy["policy"] as! String
            
            let html = """
              <html>
               <head>
              <meta name = "viewport" content="width=device-width, initial-scale=1">
              <style> body { font-size: 125%; color:#fff; } </style>
              </head>
              <body>
             \(htmlString)
              </body>
              </html>
"""
        
        webview.loadHTMLString(html, baseURL: nil)
        
     }
    

    
        func getPrivacy(){
                       
                      // var dict = [String:String]()
               //        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
                       //        dict["pin"] = "1234"
                       
                      let headers = [
                           "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
                           "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
                       ]
                       
            APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.privacypolicy,header: headers, parameters: ["" : ""] ) {(response, status, data) in
                          // print(response as Any)
                           if status{
                               do{
           //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                                   let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: []) as! NSDictionary

                                                      print("json data is--->",jsondata)
                                   
                                   
                                
                            //   let myArr1 = jsondata["data"] as! [String : AnyObject]
                                self.allPrivacy = jsondata["data"] as! [String : Any]
                                //  self.tableview.reloadData()
                                self.loadHTMLStringImage()

                               }catch{
                                   print(error.localizedDescription)
                               }
                           }
                       }
                   }
    }







