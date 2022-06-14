//
//  MoreViewController.swift
//  BallerSpot
//
//  Created by zeroit on 9/21/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import WebKit

class MoreViewController: UIViewController {
      var allmoreNews = [[String:Any]]()
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var webview: WKWebView!
    var imgs = String()
    var content = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
                 let textSize = 500
                 let javascript = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(textSize)%'"
                webView.evaluateJavaScript(javascript) { (response, error) in
                     print()
                 }
           }
  
        self.img.sd_setImage(with: URL(string: imgs ), completed: nil)
        loadHTMLStringImage()
        

    }
    
    @IBAction func cancelbtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
    func loadHTMLStringImage() {
          
          //let htmlString =  "\(self.allPrivacy["content"] ?? "")"
        let htmlString = self.content as! String
        
        let html = """
                      <html>
                       <head>
                      <meta name = "viewport" content="width=device-width, initial-scale=1">
                      <style> body { font-size: 100%; color:#000000; } </style>
                      </head>
                      <body>
                     \(htmlString)
                      </body>
                      </html>
        """
          
        webview.loadHTMLString(html, baseURL: nil)
          
       }
    

}
