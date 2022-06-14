//
//  LiveNewsTableViewCell.swift
//  BallerSpot
//
//  Created by Zeroit on 11/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import SDWebImage

class LiveTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var mainimg: UIImageView!
    @IBOutlet weak var mainheading: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var downnotification: UILabel!
    @IBOutlet weak var more: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}



