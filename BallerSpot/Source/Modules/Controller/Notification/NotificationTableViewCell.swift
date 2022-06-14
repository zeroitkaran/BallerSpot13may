//
//  NotificationTableViewCell.swift
//  BallerSpot
//
//  Created by zeroit on 9/18/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var DeleteBtn: UIButton!
    
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func del(_ sender: Any) {
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
