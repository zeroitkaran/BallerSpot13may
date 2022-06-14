//
//  WalletTableViewCell.swift
//  BallerSpot
//
//  Created by zeroit on 10/15/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class WalletTableViewCell: UITableViewCell {
    @IBOutlet weak var league: UILabel!
    @IBOutlet weak var minus: UILabel!
    @IBOutlet weak var doller: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var season: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
