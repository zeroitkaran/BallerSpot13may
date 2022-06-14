//
//  LeaderTableViewCell.swift
//  BallerSpot
//
//  Created by Imac on 17/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class LeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var viewline: UIView!
    
    @IBOutlet weak var rankid: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var pname: UILabel!
    @IBOutlet weak var winner: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet var upDownImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
