//
//  ContentVC.swift
//  BallerSpot
//
//  Created by Imac on 05/05/21.
//  Copyright © 2021 Zero ITSolutions. All rights reserved.
//

import UIKit

class ContentVC: UIViewController {

//    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var matchesTableView: UITableView!
    
    var pageIndex: Int = 0
    var strTitle: String!
    var abc = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        matchesTableView = strTitle
        matchesTableView.delegate = self
        matchesTableView.dataSource = self
        matchesTableView.register(UINib(nibName: "matchesTableViewCell", bundle: nil), forCellReuseIdentifier: "matchesTableViewCell")
        matchesTableView.register(UINib(nibName: "groupMatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "groupMatchesTableViewCell")
        matchesTableView.register(UINib(nibName: "rankTableViewCell", bundle: nil), forCellReuseIdentifier: "rankTableViewCell")
        matchesTableView.reloadData()
    }
 }

extension ContentVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = matchesTableView.dequeueReusableCell(withIdentifier: "matchesTableViewCell", for: indexPath) as! matchesTableViewCell
//        cell.date.text = "SAT 12 Jun"
//        cell.time.text = "00:30"
//        cell.matchTittle.text = "Olimpico in Rome"
//        cell.matchName1.text = "Turkey"
//        cell.matchName2.text = "US"
//        cell.backView.layer.cornerRadius = 14
//        return cell
        
        let cell2 = matchesTableView.dequeueReusableCell(withIdentifier: "groupMatchesTableViewCell", for: indexPath) as! groupMatchesTableViewCell
        cell2.firstView.layer.cornerRadius = 16
        cell2.View1.layer.cornerRadius = 16
        cell2.View2.layer.cornerRadius = 16
        cell2.greenView.layer.cornerRadius = 6
        cell2.View1.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cell2.View2.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cell2.greenView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return cell2
        
//        let cell3 = matchesTableView.dequeueReusableCell(withIdentifier: "rankTableViewCell", for: indexPath) as! rankTableViewCell
//        return cell3

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // return 150
        return 340
       // return 60
    }
}
