//
//  premierLeague.swift
//  BallerSpot
//
//  Created by zeroit on 10/27/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import SDWebImage

class premierLeaguecell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var rgtcheck: UIButton!
    @IBOutlet weak var lftcheck: UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var txtLeftScore: UITextField!
    @IBOutlet weak var txtRightScore: UITextField!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var mypick: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var imgHomeTeam: UIImageView!
    @IBOutlet weak var imgAwayTeam: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblHomeTeamName: UILabel!
    @IBOutlet weak var lblAwayTeamName: UILabel!
    @IBOutlet weak var btnLeftUp: UIButton!
    @IBOutlet weak var btnLeftDown: UIButton!
    @IBOutlet weak var btnRightUp: UIButton!
    @IBOutlet weak var btnRightDown: UIButton!
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
        self.txtLeftScore.layer.cornerRadius = 2
        self.txtLeftScore.layer.borderWidth = 1.7
        self.btnLeftUp.layer.borderColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 1.0).cgColor
        self.txtLeftScore.layer.borderColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 1.0).cgColor
        self.txtLeftScore.clipsToBounds = true
        self.txtLeftScore.textColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 1.0)
        self.txtRightScore.layer.cornerRadius = 2
        self.txtRightScore.layer.borderWidth = 1.7
        self.txtRightScore.layer.borderColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 1.0).cgColor
        self.txtRightScore.clipsToBounds = true
        self.txtRightScore.textColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 1.0)
        self.txtLeftScore.delegate = self
        self.txtRightScore.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 2
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func configure(with data : PredictScoreFixtureModel)  {
        self.imgHomeTeam.sd_setImage(with: URL(string: data.homeTeam?.logo ?? ""), completed: nil)
        self.imgAwayTeam.sd_setImage(with: URL(string: data.awayTeam?.logo ?? ""), completed: nil)

        self.lblHomeTeamName.text = data.homeTeam?.team_name ?? ""
        self.lblAwayTeamName.text = data.awayTeam?.team_name ?? ""
        
        let date = Date(timeIntervalSince1970: TimeInterval(data.event_timestamp!))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
        self.lblDate.text = dateFormatter.string(from: date)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.locale = NSLocale.current
        dateFormatter2.dateFormat = "hh:mm a" //Specify your format that you want
        self.lblTime.text = dateFormatter2.string(from: date)
        
    }
    
}
