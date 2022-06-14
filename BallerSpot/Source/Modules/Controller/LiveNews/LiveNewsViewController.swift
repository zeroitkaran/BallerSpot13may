//
//  LiveNewsViewController.swift
//  BallerSpot
//
//  Created by Zeroit on 11/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class LiveNewsViewController: UIViewController, UISearchBarDelegate {
    var allNews = [[String:Any]]()
    var position = Int()
    var searching = false
    var searchedCountry = [String]()
    var name: [Int] = []
    var filtered = [[String:Any]]()
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var LiveNewsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        LiveNewsTableView.dataSource = self
        LiveNewsTableView.delegate = self
        self.LiveNewsTableView.reloadData()
        getLiveNews()
        
       // self.hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            filtered = self.allNews.filter {
                ($0["tit"] as! String).lowercased().contains(searchText.lowercased())
            }
            print(filtered)
            searching = !filtered.isEmpty
            searching = true
        }
        else{
            searching = false
        }
        self.LiveNewsTableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    @IBAction func menubar(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true
    }
    func getLiveNews(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
        APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.livenews,header: headers, parameters: ["" : ""] ) {(response, status, data) in
            if status{
                do{
                    let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: []) as! [String : AnyObject]
                    print("json data is--->",jsondata)
                    let myArr1 = jsondata["data"] as! [String : AnyObject]
                    self.allNews = myArr1["result_data"] as! [[String : AnyObject]]
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.LiveNewsTableView.reloadData()
                } catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension LiveNewsViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filtered.count
        }
        return allNews.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveTableViewCell") as! LiveTableViewCell
        if searching {
            cell.mainheading.text = "\(self.filtered[indexPath.item]["tit"] ?? "")"
            cell.content.text = "\(self.filtered[indexPath.item]["des"] ?? "")"
            cell.downnotification.text = "\(self.filtered[indexPath.item]["aut"] ?? "")"
            cell.mainimg.sd_setImage(with: URL.init(string: self.filtered[indexPath.item]["img"] as! String),completed: nil)
            self.hideKeyboardWhenTappedAround()
            cell.more.tag = indexPath.row
            cell.more.isUserInteractionEnabled = true
            cell.more.titleLabel?.isUserInteractionEnabled = true
            cell.more.addTarget(self, action: #selector(self.moreNews), for: .touchUpInside)
        } else {
            cell.mainheading.text = "\(self.allNews[indexPath.item]["tit"] ?? "")"
            cell.content.text = "\(self.allNews[indexPath.item]["des"] ?? "")"
            cell.downnotification.text = "\(self.allNews[indexPath.item]["aut"] ?? "")"
            cell.mainimg.sd_setImage(with: URL.init(string: self.allNews[indexPath.item]["img"] as! String),completed: nil)
            cell.more.tag = indexPath.row
            cell.more.isUserInteractionEnabled = true
            cell.more.titleLabel?.isUserInteractionEnabled = true
            cell.more.addTarget(self, action: #selector(self.moreNews(sender:)), for: .touchUpInside)

        }
        tableView.keyboardDismissMode = .onDrag
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.position = ().tag
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        let moreimg = allNews[indexPath.row]["img"] as! String
        let morecontent = allNews[indexPath.row]["con"] as! String
        viewController.content = morecontent
        viewController.imgs = moreimg
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func moreNews(sender: UIButton)
    {
        self.position = (sender).tag
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        let moreimg = allNews[position]["img"] as! String
        let morecontent = allNews[position]["con"] as! String
        viewController.content = morecontent
        viewController.imgs = moreimg
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}








