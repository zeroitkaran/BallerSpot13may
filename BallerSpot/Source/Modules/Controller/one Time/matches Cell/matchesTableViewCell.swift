//
//  matchesTableViewCell.swift
//  BallerSpot
//
//  Created by Imac on 05/05/21.
//  Copyright © 2021 Zero ITSolutions. All rights reserved.
//

import UIKit

class matchesTableViewCell: UITableViewCell {

    @IBOutlet weak var matchTittle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var matchName1: UILabel!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var matchName2: UILabel!
    @IBOutlet var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backView.addShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//        contentView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
//    }
}
