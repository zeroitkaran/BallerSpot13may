//
//  DataModels.swift
//  BallerSpot
//
//  Created by Zero ITSolutions on 31/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation


//struct LeagueDataModel: Codable
//{
//    var data: [LeagueData]?
//}
//
//struct LeagueData: Codable{
//    
//    var country: String?
//    var country_code: String?
//    var coverage: [coverageModel]?
//    var flag: String?
//    var is_current: Int?
//    var league_id: Int?
//    var logo: String?
//    var name: String?
//    var season: Int?
//    var season_end: String?
//    var season_start: String?
//    var standings: String?
//    var type: String?
//}


struct coverageModel: Codable {
    var fixturesData : [fixtureModel]?
        var odds: Int?
        var players: Int?
        var predictions: Int?
        var standings: Int?
        var topScorers: Int?
}


struct fixtureModel: Codable {
    
        var events: Int?
        var lineups: Int?
        var players_statistics: Int?
        var statistics: Int?
    
}
