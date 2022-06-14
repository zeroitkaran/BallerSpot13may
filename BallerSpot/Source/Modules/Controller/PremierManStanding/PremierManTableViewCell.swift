//
//  PremierManTableViewCell.swift
//  BallerSpot
//
//  Created by zeroit on 9/18/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class PremierManTableViewCell: UITableViewCell {

    @IBOutlet weak var headtohead: UIButton!
    @IBOutlet weak var lftimg: UIImageView!
    @IBOutlet weak var rgtimg: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var lftname: UILabel!
    @IBOutlet weak var rgtname: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var midheading: UILabel!
    @IBOutlet weak var leftCheck: UIButton!
    @IBOutlet weak var rightCheck: UIButton!
    @IBOutlet weak var CellBackgroundView: UIView!

    @IBAction func button(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headtohead.layer.borderWidth = 1
        headtohead.layer.cornerRadius = 5
//        headtohead.layer.borderColor = 
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

