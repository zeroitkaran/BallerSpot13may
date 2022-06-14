
import Foundation



import UIKit

class LiveScoreVC : UIViewController, UITabBarControllerDelegate {
    
    var scoreTableCell = LiveScoreTableViewCell()
    var arrLiveScores = [[String:Any]]()
    var arrTeam1 = [String:Any]()
    var arrTeam2 = [String:Any]()
    var allRounds = [String]()
    var allpridict = [[String:Any]]()
    @IBOutlet weak var tableViewLiveScore: UITableView!
    @IBOutlet weak var NoLiveScore: UILabel!
    
    //MARK:- datelabel outlet :-
    @IBOutlet weak var dateLabel: UILabel!
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
         let tabBarIndex = tabBarController.selectedIndex
        self.navigationController?.popToRootViewController(animated: true)
         if tabBarIndex == 0 {
             //do your stuff
         }
    }
    override func viewDidLoad() {
        self.tabBarController?.delegate = self
        super.viewDidLoad()
        getCurrentDateTime()
        tableViewLiveScore.delegate = self
        tableViewLiveScore.dataSource = self
        tableViewLiveScore.register(UINib(nibName: "LiveScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "LiveScoreTableViewCell")
        tableViewLiveScore.tableFooterView = UIView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getMyEntries()
    }
    @IBAction func menuButton(_ sender: Any) {
        Utilities.OpenMEnu(FromVC: self)
        self.tabBarController?.tabBar.isHidden = true
    }
    //MARK:- date Function
    func getCurrentDateTime(){
    let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM yyyy"
        let str = formatter.string(from: Date())
        dateLabel.text = "Today: " + str
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func getMyEntries() {
        var dict = [String:String]()
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        let headers = [
            
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "ea05e391d5mshf2bfad0feab7ea4p169507jsn4fd499c10306"
        ]
    APIManager.callApi.getApiRequest(controller: self, method: APIList.shared.livescore,header: headers, parameters: ["":""] ) {(response, status, data) in

        if status{
            do{
                let jsondata = try JSONSerialization.jsonObject(with: data as Data, options: [])as! NSDictionary
                self.NoLiveScore.isHidden = true
                print("json data is--->",jsondata)
                let myArr1 = jsondata["liveScore"] as! [String:Any]
                self.arrLiveScores = myArr1["result_data"] as! [[String:Any]]
            
                        self.tableViewLiveScore.reloadData()
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
                    else{
                     self.NoLiveScore.isHidden = false
//                BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(response?.value(forKey: "message")! ?? "")", VC: self, cancel_action: false)
                }
            }
        }
    }

extension LiveScoreVC : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrLiveScores.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        scoreTableCell = tableViewLiveScore.dequeueReusableCell(withIdentifier: "LiveScoreTableViewCell", for: indexPath) as! LiveScoreTableViewCell
        scoreTableCell.selectionStyle = .none
//        scoreTableCell.btnSave.isHidden = true
        
        let data = self.arrLiveScores[indexPath.row]
        let AwayTeam = self.arrLiveScores[indexPath.item]["awayTeam"] as![String:Any]
        let HomeTeam = self.arrLiveScores[indexPath.item]["homeTeam"] as![String:Any]
//        let data2 = self.arrTeam1[indexPath.item]
        
//        scoreTableCell.imgHomeTeam.sd_setImage(with: URL.init(string: data["home_team_logo"] as! String), completed: nil)
//        scoreTableCell.imgAwayTeam.sd_setImage(with: URL.init(string: data["away_team_logo"] as! String), completed: nil)
//        scoreTableCell.lblHomeTeamName.text = "\(data["home_team_name"] ?? "")"
//        scoreTableCell.lblAwayTeamName.text = "\(data["away_team_name"] ?? "")"
//        scoreTableCell.txtLeftScore.text = "\(data["final_home_score"] ?? "")"
//        scoreTableCell.txtRightScore.text = "\(data["final_away_score"] ?? "")"
         scoreTableCell.imgHomeTeam.sd_setImage(with: URL.init(string: HomeTeam["logo"] as! String), completed: nil)
         scoreTableCell.imgAwayTeam.sd_setImage(with: URL.init(string: AwayTeam["logo"] as! String), completed: nil)
         scoreTableCell.lblHomeTeamName.text = "\(HomeTeam["team_name"] ?? "")"
         scoreTableCell.lblAwayTeamName.text = "\(AwayTeam["team_name"] ?? "")"
         scoreTableCell.txtLeftScore.text = "\(data["goalsHomeTeam"] ?? "")"
         scoreTableCell.txtRightScore.text = "\(data["goalsAwayTeam"] ?? "")"
        scoreTableCell.txtLeftScore.isUserInteractionEnabled = false
        scoreTableCell.txtRightScore.isUserInteractionEnabled = false
        scoreTableCell.regularSeason.text = "\(data["round"] ?? "")"
        scoreTableCell.lblTime.text = "Live"
        scoreTableCell.lblTime.textColor = UIColor.red
        scoreTableCell.lblTime.font = .boldSystemFont(ofSize: 15)

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let datefomatterPrint = DateFormatter()
        datefomatterPrint.dateFormat = "E,dd MMM yyyy"
        let date: NSDate? = dateFormatterGet.date(from: "\(data["date"] ?? "")" ) as NSDate?
        scoreTableCell.lblDate.text = datefomatterPrint.string(from: date! as Date )
        scoreTableCell.lblDate.textColor = UIColor(red: 0/256, green: 84/256, blue: 43/256, alpha: 1.0)
        scoreTableCell.lblDate.font = .boldSystemFont(ofSize: 15)

        return scoreTableCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180//UITableView.automaticDimension
    }
}
// 57// print(response as Any)
//            if status{
//                if response != nil
//                {
//                    do{
//                        let decoder = JSONDecoder()
//                        let str = String(decoding: data, as: UTF8.self)
//                        let regex = str.replacingOccurrences(of: "(\\\"(.*?)\\\"|(\\w+))(\\s*:\\s*(\\\".*?\\\"|.))", with: "\"$2$3\"$4", options: .regularExpression)
//                        let mydata = try decoder.decode(LiveScore.self, from: regex.data(using: .utf8)!)
// 66//                        self.arrLiveScores = mydata.liveScore?.result_data ?? [ResultDatumLiveScore]()
