//
//  HeadTableViewCell.swift
//  BallerSpot
//
//  Created by zeroit on 9/25/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class HeadTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var LftTeamName: UILabel!
    @IBOutlet weak var RgtTeamName: UILabel!
    @IBOutlet weak var lftimg: UIImageView!
    @IBOutlet weak var rgtimg: UIImageView!
    @IBOutlet weak var lftscore: UILabel!
    @IBOutlet weak var rgtscore: UILabel!
    @IBOutlet weak var LeaName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
