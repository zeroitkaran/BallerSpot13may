//
//  rankTableViewCell.swift
//  BallerSpot
//
//  Created by Imac on 07/05/21.
//  Copyright © 2021 Zero ITSolutions. All rights reserved.
//

import UIKit

class rankTableViewCell: UITableViewCell {

    @IBOutlet var upDown: UIImageView!
    @IBOutlet var rankId: UILabel!
    @IBOutlet var userImg: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var fullName: UILabel!
    @IBOutlet var winnerImg: UIImageView!
    @IBOutlet var points: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
