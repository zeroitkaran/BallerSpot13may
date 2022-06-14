//
//  guruSectionViewController.swift
//  BallerSpot
//
//  Created by zeroit on 10/21/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import WebKit

class guruSectionViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!
    var guru = [[String:AnyObject]]()
    var guruSection = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
                      let textSize = 500
                      let javascript = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(textSize)%'"
                     webView.evaluateJavaScript(javascript) { (response, error) in
                          print()
                      }
                }
          gurusection()
    }
         
    @IBAction func menuBtn(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true
    }
    
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
               let textSize = 500
               let javascript = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(textSize)%'"
              webView.evaluateJavaScript(javascript) { (response, error) in
                   print()
               }
         }
        func loadHTMLStringImage() {
                let htmlString = self.guruSection

            let html = """
              <html>
               <head>
              <meta name = "viewport" content="width=device-width, initial-scale=1">
              <style> body { font-size: 125%; color:#000000; } </style>
              </head>
              <body>
             \(htmlString)
              </body>
              </html>
    """
        webview.loadHTMLString(html, baseURL: nil)

     }

        func gurusection(){

                      let headers = [
                           "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
                           "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
                       ]

            APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.guruSection,header: headers, parameters: ["" : ""] ) {(response, status, data) in
                          // print(response as Any)
                           if status{
                               do{
                                let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: []) as! NSDictionary
                                    print("json data is--->",jsondata)

                                if let guruArray = jsondata["data"] as? [[String:Any]],
                                   let guru = guruArray.first {
                                    self.guruSection = guru["content"] as! String
                                }
                                
                                self.loadHTMLStringImage()

                               }catch{
                                   print(error.localizedDescription)
                               }
                           }
                       }
                   }
      }
