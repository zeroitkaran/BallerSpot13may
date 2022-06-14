//
//  groupMatchesTableViewCell.swift
//  BallerSpot
//
//  Created by Imac on 05/05/21.
//  Copyright © 2021 Zero ITSolutions. All rights reserved.
//

import UIKit

class groupMatchesTableViewCell: UITableViewCell {

    @IBOutlet var firstView: UIView!
    @IBOutlet var View1: UIView!
    @IBOutlet var View2: UIView!
    @IBOutlet var greenView: UIView!
    @IBOutlet var euroName: UILabel!
    @IBOutlet var groupName: UILabel!
    @IBOutlet var tittle1: UILabel!
    @IBOutlet var team1Date: UILabel!
    @IBOutlet var team1Time: UILabel!
    @IBOutlet var team1HomeImg: UIImageView!
    @IBOutlet var team1HomeName: UILabel!
    @IBOutlet var team1awayImg: UIImageView!
    @IBOutlet var team1AwayName: UILabel!
    
    @IBOutlet var tittle2: UILabel!
    @IBOutlet var team2Date: UILabel!
    @IBOutlet var team2Time: UILabel!
    @IBOutlet var team2HomeImg: UIImageView!
    @IBOutlet var team2HomeName: UILabel!
    @IBOutlet var team2AwayImg: UIImageView!
    @IBOutlet var team2AwayName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.firstView.addShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
