//
//  LeaguesModel.swift
//  BallerSpot
//
//  Created by Zeroit on 02/03/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation

struct LeaguesModel : Codable {
    var result_code : String?
    var Leagues:League?
    var result_data : [LeaguesDataModel]?
    var url  : String?
    var user_data : LeaguesUserDataModel?
}

struct LeaguesDataModel : Codable {
    var category : String?
    var id  : String?
    var logo : String?
    var pinvalue  : String?
}

struct LeaguesUserDataModel : Codable {
    var email : String?
    var id : String?
    var image : String?
    var name : String?
    var password  : String?
    var phone : String?
    var pinvalue  : String?
    var pool_amount : String?
    var token  : String?
}


struct League: Codable {
    var country: String?
    var logo: String?
    var name: String?
    var country_code: String?
    var flag: String?
    var id: Int
    var is_current: Int
    var league_id: Int
    var players: String?
    var season: Int
    var season_end: String?
    var season_start: String?
    var standings: Int
    var status: Int
    var type: String?
    var round_status: Int
}


// MARK: - MyEntries

struct MyEntries: Codable {
    var status, message: String?
    var myEnteries: MyEnteries?
}

// MARK: - MyEnteries
struct MyEnteries: Codable {
    var url: String?
    var pool_amount:String?
    var result_data: [ResultDatum]?
    var private_data: [PrivateDatum]?

}

// MARK: - ResultDatum
struct ResultDatum: Codable {
    var id, user_id, league_id, match_id: String?
    var home_team_score, away_team_score, event_date, created_at, method: String?
    var final_away_score, final_home_score: String?
    var status: String?
    var statusShort: String?
    var pinvalue: Int?
    var home_team_logo: String?
    var home_team_name: String?
    var away_team_logo: String?
    var away_team_name: String?
    var round: String?
    var league_name: String?
    var pot_amount: String?
    var date: String?
}

// MARK: - PrivateDatum
struct PrivateDatum: Codable {
    var id, user_id, league_id, match_id: String?
    var home_team_score, away_team_score, event_date, created_at, method: String?
    var final_away_score, final_home_score: String?
    var status: String?
    var statusShort: String?
    var pinvalue: Int?
    var home_team_logo: String?
    var home_team_name: String?
    var away_team_logo: String?
    var away_team_name: String?
    var round: String?
    var pot_amount: String?
    var le_name: String?

}
// MARK: - LiveScore
struct LiveScore: Codable {
    var status, message: String?
    var liveScore: LiveScoreClass?
}

// MARK: - LiveScoreClass
struct LiveScoreClass: Codable {
    var url: String?
    var result_data: [ResultDatumLiveScore]?
}

// MARK: - ResultDatum

struct ResultDatumLiveScore: Codable {
    var fixture_id, league_id: Int?
    var league_name: String?
    var round: String?
    var away_team_name, home_team_name: String?
    var home_team_logo, away_team_logo: String?
    var event_date: Date?
    var updated_at, created_at: String?
    var date: String?
    var status: String?
    var final_home_score, final_away_score: String?
    var statusShort: String?
    var league: LeagueLiveScore?

//    var event_timestamp, firstHalfStart: Int?
//    var secondHalfStart: Int?
//    var elapsed: Int?
//    var venue: String?
//    var referee: String?
//    var homeTeam, awayTeam: Team?
//    var goalsHomeTeam, goalsAwayTeam: Int?
//    var score: Score?
//    var events: [Event]?
}

// MARK: - Team
struct Team: Codable {
    var team_id: Int?
    var team_name: String?
    var logo: String?
}



// MARK: - Event
struct Event: Codable {
    var elapsed: Int?
    var elapsedPlus: Int?
    var team_id: Int?
    var teamName: String?
    var player_id: Int?
    var player: String?
    var assist_id: Int?
    var assist: String?
    var type: String?
    var detail: String?
    var comments: String?
}

//enum TypeEnum {
//    case card
//    case goal
//    case subst
//}

// MARK: - League
struct LeagueLiveScore: Codable {
    var name, country: String?
    var logo: String?
    var flag: String?
}

// MARK: - Score
struct Score: Codable {
    var halftime: String?
   // var fulltime, extratime, penalty: NSNull?
}

//enum Status {
//    case firstHalf
//    case halftime
//    case secondHalf
//}
//
//enum StatusShort {
//    case ht
//    case the1H
//    case the2H
//}


struct MyVariables {
    static var bannerData = [[String:Any]]()
    static var imageUrl = "http://52.66.253.186/uploads/banners/"
}
