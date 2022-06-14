//
//  ScoreTableCell.swift
//  Football_App
//
//  Created by Zero ITSolutions on 22/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import UIKit
import SDWebImage

class ScoreTableCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var rgtcheck: UIButton!
    @IBOutlet weak var lftcheck: UIButton!
    @IBOutlet weak var startingsoon: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftsideView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var rightsideView: UIView!

    
    @IBOutlet weak var startingsoonheight: NSLayoutConstraint!
    @IBOutlet weak var txtLeftScore: UITextField!
    @IBOutlet weak var txtRightScore: UITextField!
    
    @IBOutlet weak var mypick: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var imgHomeTeam: UIImageView!
    @IBOutlet weak var imgAwayTeam: UIImageView!
    
    @IBOutlet weak var mypickheight: NSLayoutConstraint!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblHomeTeamName: UILabel!
    @IBOutlet weak var lblAwayTeamName: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnLeftUp: UIButton!
    @IBOutlet weak var btnLeftDown: UIButton!
    @IBOutlet weak var btnRightUp: UIButton!
    @IBOutlet weak var btnRightDown: UIButton!
    
    
    @IBOutlet weak var regularSeason: UILabel!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var matchFinished: UILabel!
    @IBOutlet weak var LeftCheckBtn: UIButton!
    @IBOutlet weak var RightCheckBtn: UIButton!
    
    @IBOutlet weak var Startingheight: NSLayoutConstraint!
    
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var date2: UILabel!
    @IBOutlet weak var headToheadBtn: UIButton!
    //MARK:- add space in multiple cell :-
    
    
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
        self.btnLeftUp.layer.borderColor = UIColor.init(red: 237/255, green: 26/255, blue: 56/255, alpha: 1.0).cgColor
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
        self.headToheadBtn.layer.borderWidth = 1
        self.headToheadBtn.layer.cornerRadius = 5
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
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = NSLocale.current
        dateFormatter.dateFormat = "hh" //Specify your format that you want
        self.lblTime.text = dateFormatter1.string(from: date)
        
    }
    
}
