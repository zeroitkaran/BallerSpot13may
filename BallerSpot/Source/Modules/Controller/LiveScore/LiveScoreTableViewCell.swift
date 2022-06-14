//
//  LiveScoreTableViewCell.swift
//  BallerSpot
//
//  Created by Zeroit on 04/01/21.
//  Copyright © 2021 Zero ITSolutions. All rights reserved.
//

import UIKit

class LiveScoreTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var imgHomeTeam: UIImageView!
    @IBOutlet weak var imgAwayTeam: UIImageView!
    @IBOutlet weak var lblHomeTeamName: UILabel!
    @IBOutlet weak var lblAwayTeamName: UILabel!
    @IBOutlet weak var txtLeftScore: UITextField!
    @IBOutlet weak var txtRightScore: UITextField!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var regularSeason: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    override func layoutSubviews()
       {
           super.layoutSubviews()
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets (top: -5, left: 0, bottom: -5, right: 0))
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shadowView.layer.cornerRadius = 20
               self.mainView.layer.cornerRadius = 20
               self.mainView.clipsToBounds = true
               self.txtLeftScore.layer.cornerRadius = 25
               self.txtRightScore.layer.cornerRadius = 25
               self.txtRightScore.clipsToBounds = true
               self.txtLeftScore.clipsToBounds = true
               self.shadowView.addShadow()
               self.txtLeftScore.layer.cornerRadius = 8
               self.txtLeftScore.layer.borderWidth = 1.7
//               self.btnLeftUp.layer.borderColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 1.0).cgColor
               self.txtLeftScore.layer.borderColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 1.0).cgColor
               self.txtLeftScore.clipsToBounds = true
               self.txtLeftScore.textColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 1.0)
               
               self.txtRightScore.layer.cornerRadius = 8
               self.txtRightScore.layer.borderWidth = 1.7
               self.txtRightScore.layer.borderColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 1.0).cgColor
               self.txtRightScore.clipsToBounds = true
               self.txtRightScore.textColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 1.0)
               self.txtLeftScore.delegate = self
               self.txtRightScore.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 2
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
