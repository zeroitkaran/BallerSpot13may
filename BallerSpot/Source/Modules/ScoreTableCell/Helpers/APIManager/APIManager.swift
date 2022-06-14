//
//  ApiModelClass.swift
//  BallerSpot
//
//  Created by Zero ITSolutions on 22/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SystemConfiguration

class AlertManager: NSObject {

    static  let callAlert = AlertManager()
    let baseURL = ""

    private override init() {
        super.init()
    }

    func show(controller:UIViewController,message:String) -> Void {

        let alertController = UIAlertController(title: "Alert", message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil))

        controller.present(alertController, animated: true, completion: nil)
    }

    func checkErrorCodes (controller:UIViewController,error:NSError) {

        // if (error ){
        //handle network error
        switch (error.code) {
        case NSURLErrorTimedOut:
            show(controller: controller, message: "Service time out")
            break;
        case NSURLErrorCannotConnectToHost:
            show(controller: controller, message: "Cannot connect to host")
            break;
        case NSURLErrorNetworkConnectionLost:
            show(controller: controller, message: "Network connection lost")
            break;
        case NSURLErrorNotConnectedToInternet:
            show(controller: controller, message: "Not connected to internet")
            break;
        case NSURLErrorBadURL:
            show(controller: controller, message: "Bad Url")
            break;

        case NSURLErrorCannotFindHost:
            show(controller: controller, message: "Cannot find host")
            break;
        case NSURLErrorBadServerResponse:
            show(controller: controller, message: "Bad server response")
            break;
        case NSURLErrorUnsupportedURL:
            show(controller: controller, message: "Unsupported URL")
            break;
        default:

            break;
        }
    }
}

class APIManager: NSObject {
    var window: UIWindow?
    static  let callApi = APIManager()
    var alamoFireManager : SessionManager? // this line
    private override init() {
        super.init()
    }
    func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        //let defaultRouteReachability = withUnsafePointer(to: &zeroAddress)
        //{
        //    SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        //}


        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {

            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {

                SCNetworkReachabilityCreateWithAddress(nil, $0)

            }

        }) else {

            return false
        }

        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags)
        {
            return false
        }

        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

    func getApiRequest (controller:UIViewController, method:String, header: HTTPHeaders? = nil, parameters:[String:Any], completionHandler: @escaping ((_ json: AnyObject?, _ success:Bool, _ data: Data) -> Void)) {
        if isConnectedToNetwork()  {


            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 60
            configuration.timeoutIntervalForResource = 60

            alamoFireManager = Alamofire.SessionManager(configuration: configuration) // not in this line

            //        SVProgressHUD.setBackgroundColor(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 0.2))
            //   a         SVProgressHUD.setForegroundColor(UIColor(red: 9/255.0, green: 168/255.0, blue: 170/255.0, alpha: 1))
            //a
            //  a          SVProgressHUD.setRingThickness(10)
            //  a          SVProgressHUD.setDefaultMaskType(.gradient)
            //  a          SVProgressHUD.setRingRadius(150)
            //   a         SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: 0))
            //

            //    SVProgressHUD.setBackgroundLayerColor(UIColor(red: 255, green: 0, blue: 0, alpha: 1))

            //a SVProgressHUD.show()
            //  UIApplication.shared.beginIgnoringInteractionEvents()
            let jsonData = try!  JSONSerialization.data(withJSONObject: parameters, options: [])

            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String

            print(jsonString)
            alamoFireManager?.request(method, method: .get, parameters: (parameters ), encoding:  URLEncoding.default, headers: header).responseJSON {(response:DataResponse<Any>) in
                //      let _ = self.alamoFireManager
                // a SVProgressHUD.dismiss()
                //     UIApplication.shared.endIgnoringInteractionEvents()
                print(response.result.value ?? "")
                print(response.data)
                if !response.result.isSuccess {

                    //   print(response.result.error ?? "")
                    AlertManager.callAlert.checkErrorCodes(controller: controller, error:(response.result.error)! as NSError )
                }

                if let json = response.result.value  {

                    print("JSON: \(json)")
                    completionHandler(json as AnyObject, true, response.data!)

                }
                else {

                    completionHandler(nil, false, response.data!)

                }


                }.session.finishTasksAndInvalidate()
        }
        else {

            AlertManager.callAlert.show(controller:controller , message: "Cannot connect to internet")
        }

    }
    func postApiRequest (controller:UIViewController, method:String, header: HTTPHeaders, parameters:[String:Any], completionHandler: @escaping ((_ json: AnyObject?, _ success:Bool, _ data: Data) -> Void)) {
        if isConnectedToNetwork()  {
//
//            SVProgressHUD.setDefaultMaskType(.custom)
//
//            SVProgressHUD.setBackgroundColor(UIColor.clear)
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 100
            configuration.timeoutIntervalForResource = 110

            alamoFireManager = Alamofire.SessionManager(configuration: configuration) // not in this line

            //        SVProgressHUD.setBackgroundColor(UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 0.2))
//            SVProgressHUD.setForegroundColor(UIColor(red: 9/255.0, green: 168/255.0, blue: 170/255.0, alpha: 1))
//
//            SVProgressHUD.setRingThickness(10)
//            SVProgressHUD.setDefaultMaskType(.gradient)
//            SVProgressHUD.setRingRadius(150)
//            SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: 0))


            //    SVProgressHUD.setBackgroundLayerColor(UIColor(red: 255, green: 0, blue: 0, alpha: 1))

            //SVProgressHUD.show()
            //  UIApplication.shared.beginIgnoringInteractionEvents()
            let jsonData = try!  JSONSerialization.data(withJSONObject: parameters, options: [])

            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String

            // print(jsonString)
            alamoFireManager?.request(method, method: .post, parameters: (parameters), encoding:  URLEncoding.default, headers: header).responseJSON {(response:DataResponse<Any>) in




                //                alamoFireManager?.request(method, method: .post , parameters: parameters as? Parameters, encoding: JSONEncoding.default).responseJSON { response in



                //      let _ = self.alamoFireManager
               // SVProgressHUD.dismiss()


                //     UIApplication.shared.endIgnoringInteractionEvents()
                //     print(response.result.value ?? "")
                if !response.result.isSuccess {

                    //   print(response.result.error ?? "")
                    AlertManager.callAlert.checkErrorCodes(controller: controller, error:(response.result.error)! as NSError )
                }

                if let json = response.result.value  {

                    //    print("JSON: \(json)")
                    completionHandler(json as AnyObject, true, response.data!)

                }
                else {

                    completionHandler(nil, false, response.data!)

                }


                }.session.finishTasksAndInvalidate()
        }
        else {

            AlertManager.callAlert.show(controller:controller , message: "Cannot connect to internet")
        }


    }



    func postRequestWithHeaders(method:String, parameters:NSDictionary, header: HTTPHeaders, completionHandler: @escaping ((_ json: AnyObject?, _ success:Bool) -> Void))
    {
        if isConnectedToNetwork()  {
            SVProgressHUD.setDefaultMaskType(.custom)

            SVProgressHUD.setBackgroundColor(UIColor.clear)

            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 200
            configuration.timeoutIntervalForResource = 200

            alamoFireManager = Alamofire.SessionManager(configuration: configuration) // not in this line
            SVProgressHUD.setForegroundColor(UIColor(red: 9/255.0, green: 168/255.0, blue: 170/255.0, alpha: 1))

            SVProgressHUD.setRingThickness(10)
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.setRingRadius(150)
            SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: 0))


            //    SVProgressHUD.setBackgroundLayerColor(UIColor(red: 255, green: 0, blue: 0, alpha: 1))

            SVProgressHUD.show()



            let jsonData = try!  JSONSerialization.data(withJSONObject: parameters, options: [])

            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String

            // print(jsonString)
            alamoFireManager?.request(method, method: .post, parameters: (parameters as! Parameters), encoding:  URLEncoding.default, headers: header).responseJSON {(response:DataResponse<Any>) in

                 SVProgressHUD.dismiss()
                if !response.result.isSuccess {

                    print(response.result.error ?? "")
                    //alertManager.callAlert.checkErrorCodes(controller: (self.window?.rootViewController)!, error:(response.result.error)! as NSError )
                }

                if let json = response.result.value  {

                    //    print("JSON: \(json)")
                    completionHandler(json as AnyObject, true)

                }
                else {

                    completionHandler(nil, false)

                }


                }.session.finishTasksAndInvalidate()
        }
        else {

            //alertManager.callAlert.show(controller: (window?.rootViewController)! , message: "Cannot connect to internet")
        }



    }

}

