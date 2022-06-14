//
//  MyEntriesModel.swift
//  BallerSpot
//
//  Created by Zeroit on 05/03/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation

struct MyEntriesModel : Codable {
    var result_code : String?
    var result_data : [MyEntriesDataModel]?
    
    
}

struct MyEntriesDataModel : Codable {
    var date : String?
    var match_id : Int?
    var team1 :MyEntriesTeamModel?
    var team1_score : String?
    var team2 : MyEntriesTeamModel?
    var team2_score : String?
    var time : String?
}

struct MyEntriesTeamModel :Codable {
    var id : Int?
    var logo  : String?
    var teamName  : String?
}



