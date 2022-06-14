//
//  NotificationViewController.swift
//  BallerSpot
//
//  Created by zeroit on 9/18/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class NotificationViewController: ViewController {
        var allNotifi = [[String:Any]]()
        var DeleteNotifi = [[String:Any]]()
    var notific = [[String: Any]]()
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var NoNotification: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        getNotification()
    }
    
    @IBAction func menubar(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
               self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func getNotification(){
                   
                   var dict = [String:String]()
             //   dict["user_id"] = "20"
                  dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
                   //        dict["pin"] = "1234"
                   
                  let headers = [
                       "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
                       "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
                   ]
                   
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.get_notifications ,header: headers, parameters: dict) {(response, status, data) in
                      // print(response as Any)
                       if status{
                           do{
       //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                               let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: []) as! NSDictionary
                               self.NoNotification.isHidden = true
                                                  print("json data is--->",jsondata)
                            let aa = jsondata["message"] as! String
//                            self.notific = jsondata["notifications"] as [[]]
                            print(aa)
                            if aa != "No Data Found."{
                          
                            print(jsondata.count)
                           
//                            guard let response = self.items["result"] as? [[String: AnyObject]] else {
//                                 return
//                            }
//                            self.resultList = response
                            self.allNotifi = jsondata["notifications"]  as! [[String  : Any]]
                                self.allNotifi.reverse()
                                self.tableview.reloadData()

                            
                            }else{
                                self.NoNotification.isHidden = false
                                self.allNotifi.removeAll()
                                self.tableview.reloadData()

                            }

                           }catch{
                               print(error.localizedDescription)
                        }
                       }else{
                           self.NoNotification.isHidden = true
                       }
                   }
              }
    }
extension NotificationViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNotifi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
         //    bell.point.text = "\(self.allLeader[indexPath.item]["pool_amount"] ?? "")"
        cell.title.text = "\(self.allNotifi[indexPath.item]["title"] ?? "")"
        cell.msg.text = "\(self.allNotifi[indexPath.item]["description"] ?? "")"
    
        let dateFormatterGet = DateFormatter()
       //   "updated_at" = "2020-09-07 12:04:42";
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let datefomatterPrint = DateFormatter()
        datefomatterPrint.dateFormat = "EEEE,dd MMM yyyy"
        let date: NSDate? = dateFormatterGet.date(from: self.allNotifi[indexPath.item]["updated_at"] as! String ) as NSDate?
        cell.date.text = datefomatterPrint.string(from: date! as Date )
        cell.DeleteBtn.addTarget( self, action:#selector(self.DeleteAction(sender:)), for: .touchUpInside)
        cell.DeleteBtn.tag = indexPath.row

        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
        allNotifi.remove(at: indexPath.row)
            tableView.reloadData()
        //self.tableView.del(at: [indexPath], with: .automatic)
      }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
     @objc func DeleteAction(sender : UIButton){
         
        let abc = allNotifi[sender.tag]["id"] as! String
        var dict = [String:String]()
               dict["id"] = abc
                    let headers = [
                                    "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
                                    "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
                                  ]
             APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.delete_notification ,header: headers, parameters: dict) {(response, status, data) in
                 if status{
                                    do{
                //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                                        let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: []) as! NSDictionary
                                        print("json data is--->",jsondata)
//                                        let aa = jsondata["message"] as! String
                                        let bb = jsondata["status"] as! String
                                        if bb == "Success"{
                                            self.getNotification()
//                                                print(jsondata.count)
//
//                                                self.DeleteNotifi = jsondata["message"]  as! [[String  : Any]]
//                                                self.tableview.reloadData()
                                        }
                    }catch{
                           print(error.localizedDescription)
                    }
                }
            }
    }
}
