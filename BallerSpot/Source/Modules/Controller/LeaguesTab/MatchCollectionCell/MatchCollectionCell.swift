//
//  MatchCollectionCell.swift
//  BallerSpot
//
//  Created by Zero ITSolutions on 22/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit

class MatchCollectionCell: UICollectionViewCell {

    @IBOutlet weak var privatelbl: UILabel!
    @IBOutlet weak var userentry: UILabel!
    
    @IBOutlet weak var privateheight: NSLayoutConstraint!
    
    @IBOutlet weak var userlogo: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var lblMatchName: UILabel!
    
    @IBOutlet weak var viewRightLine: UIView!
    
    @IBOutlet weak var viewLowerLeft: UIView!
    
    @IBOutlet weak var viewLowerRight: UIView!
    
    @IBOutlet weak var lblLeagueName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
