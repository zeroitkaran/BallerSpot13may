//
//  WalletViewController.swift
//  BallerSpot
//
//  Created by zeroit on 10/15/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var walletpot: UILabel!
    @IBOutlet weak var NoWallet: UILabel!
    var walletData = [[String:Any]]()
    var pot = String()
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableview.delegate = self
        tableview.dataSource = self
        getWalletData()
  
  
    }
    
    @IBAction func menubar(_ sender: Any) {
        
         Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true
    }
    func getWalletData(){
            
                    var dict = [String:String]()
             dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
                    //        dict["pin"] = "1234"
                    
                   let headers = [
                        "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
                        "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
                    ]
                    
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.getUserWallet,header: headers, parameters: dict ) {(response, status, data) in
                       // print(response as Any)
                        if status{
                            do{
        //                        self.allLeagues = [response?.value(forKey: "api")] as! [NSString : Any]
                                let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary

                                                   print("json data is--->",jsondata)
                                
                                
                              //  let decoder = JSONDecoder()
                               //let myArr1 = jsondata["Leagues"]
                               
                                  let status = jsondata["status"] as! String
                                if status == "Success" {
                                    self.NoWallet.isHidden = true
                                    self.tableview.isHidden = false
                                    let myArr = jsondata["myhistory"] as! [String : Any]
                                    self.walletData = myArr["result_data"] as! [[String:Any]]
                                    self.pot = myArr["pot_amount"] as! String
                                    self.walletpot.text = myArr["pot_amount"] as! String
                                        self.tableview.reloadData()
                                }
                                else{
                                    self.NoWallet.isHidden = false
                                    self.tableview.isHidden = true
                                }
                                                                
                            }catch{
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
    

  

}

extension WalletViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walletData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTableViewCell") as! WalletTableViewCell
        cell.league.text = (walletData[indexPath.row]["league_name"] as! String)
        cell.season.text = (walletData[indexPath.row]["round"] as! String)
        cell.amount.text = (walletData[indexPath.row]["amount"] as! String)
        let status = walletData[indexPath.row]["status"] as! String
        if status == "minus"{
            cell.amount.textColor = UIColor.red
            cell.doller.textColor = UIColor.red
            cell.minus.textColor = UIColor.red
        }
        else{
            cell.amount.textColor = UIColor.green
            cell.doller.textColor = UIColor.green
            cell.minus.text = "+"
            cell.minus.textColor = UIColor.green
        }
               return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // return UITableView.automaticDimension/6
    return 80
        
    }
    
    
}
