
//  API_List.swift
//  BallerSpot
//  Created by Zero ITSolutions on 24/01/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.

import Foundation

var baseUrl = "http://52.66.253.186/ballerspotapi/index.php/"
class APIList: NSObject  {
    static let shared = APIList()
    
    var getchildLeagues = baseUrl + "app_Admin/Api/getchildLeagues"
    var getLeagues = baseUrl + "app_getleagues"
    var getsubLeagues = baseUrl + "app_getsubLeagues"
    var getMatches = baseUrl + "app_Admin/Api/getMatches"
    var getFixtureRapid = baseUrl + "app_Admin/Api/getFixtureRapid"
    var galleryImages = baseUrl + "app_Admin/Api/galleryImages"
    var savePredictions = baseUrl+"savePredictions"
    var signup = baseUrl + "app_signup"
    var login = baseUrl + "app_login"
    var forgetpassword = baseUrl + "app_Admin/Api/forgetpassword"
    var changepassword = baseUrl + "app_Admin/Api/changepassword"
    var changeuserpassword = baseUrl + "app_changepassword"
    var getMyEntriesPrivate = baseUrl + "app_Admin/Api/getMyEntries"
    var getMyEntriesPublic = baseUrl + "app_myentries"
    var fixturesLeague = "https://api-football-v1.p.rapidapi.com/v2/fixtures/league/524/next/15"
    var updateProfile = baseUrl + "app_updateprofile"
    var charity = baseUrl + "save_charity"
    var pinvalue = baseUrl + "save_pinvalue"
    var privacypolicy = baseUrl + "app_privacypolicy"
    var contactUs = baseUrl + "app_contactus"
    var getrules = baseUrl + "app_getrules"
    var leaderboard = baseUrl + "app_leaderboard"
    var personalleaderboard = baseUrl + "leagueLeaderBoard"
    var picturegallery = baseUrl + "app_picturegallery"
    var livenews  = baseUrl + "app_livenews"
    var livescore = baseUrl + "app_livescore"
    var myentries = baseUrl + "app_myentries"
    var startvideo = baseUrl + "app_startvideo"
    var banners = baseUrl + "app_banners"
    var getrounds = baseUrl + "app_getrounds"
    var app_getrounds = baseUrl + "app_getrounds"
    var getmatches = baseUrl + "app_getmatches"
    var guruSection = baseUrl + "app_gurusection"
    var getUserWallet = baseUrl + "getUserWallet"
    var get_lastManStandingMatch = baseUrl + "get_lastManStandingMatch"
    var get_headtohead = baseUrl + "get_headtohead"
    var get_standingsLeaderboard = baseUrl + "get_standingsLeaderboard"
    var getUserPicksByLeague = baseUrl + "getUserPicksByLeague"
    var save_standingPrediction = baseUrl + "save_standingPrediction"
    var getroundsdetails = baseUrl + "app_getroundsdetails"
    var getRoundUsers = baseUrl + "get_roundUsers"
    var videos = baseUrl + "app_videochannel"
    var profiledetails = baseUrl + "app_profiledetails"
    var get_notifications = baseUrl + "get_notifications"
    var delete_notification = baseUrl + "delete_notification"
    var app_completedFixtures = baseUrl + "app_completedFixtures"
    var app_notify = baseUrl + "app_notify"
    var get_euro_rounds = baseUrl + "get_euro_rounds"
}

