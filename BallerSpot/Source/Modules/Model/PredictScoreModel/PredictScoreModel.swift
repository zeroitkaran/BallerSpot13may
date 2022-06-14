//
//  PredictScoreModel.swift
//  BallerSpot
//
//  Created by Zeroit on 03/03/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation

struct PredictScoreModel : Codable {
    var api : PredictScoreAPIModel?
}

struct PredictScoreAPIModel : Codable {
    var fixtures : [PredictScoreFixtureModel]?
    var results : Int?
}

struct PredictScoreFixtureModel : Codable {
    var awayTeam : PredictScoreTeamModel?
    var event_date : String?
    var event_timestamp : Int?
    var firstHalfStart  : String?
    var fixture_id : Int?
    var goalsAwayTeam  : String?
    var goalsHomeTeam  : String?
    var homeTeam : PredictScoreTeamModel?
    var league : PredictScoreLeagueModel
    var league_id : Int?
    var referee : String?
    var round : String?
    var score : PredictScoreScoreModel?
    var secondHalfStart  : String?
    var status : String?
    var statusShort : String?
    var venue : String?
    
    var leftTxtFieldValue : String?
    var rightTxtFieldValue : String?
    
}

struct PredictScoreTeamModel : Codable{
    var logo : String?
    var team_id : Int?
    var team_name : String?
}

struct PredictScoreLeagueModel : Codable{
    var country  : String?
    var flag  : String?
    var logo  : String?
    var name  : String?
}

struct PredictScoreScoreModel : Codable{
    var extratime  : String?
    var fulltime  : String?
    var halftime  : String?
    var penalty  : String?
}

