//
//  LocalStorage.swift
//  BallerSpot
//
//  Created by Zeroit on 04/03/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation

enum localStoreKeys: String {
    
    case loginData = "loginData"
    case leaguesData = "leaguesData"
}


var D_Get_LoginData: LoginDataDict?{
    get{
        return getLoginDetails(.loginData)
    }
}

var D_Save_LoginData: LoginDataDict?{
    didSet{
        saveLoginData(D_Save_LoginData!, .loginData)
    }
}

var D_Get_LeaguesData: LeaguesModel?{
    get{
        return getLeaguesData(.leaguesData)
    }
}

var D_Save_LeaguesData: LeaguesModel?{
    didSet{
        saveLeaguesData(D_Save_LeaguesData!, .leaguesData)
    }
}

 func getLoginDetails (_ key: localStoreKeys) -> LoginDataDict? {
    if let data = UserDefaults.standard.value(forKey: key.rawValue) as? Data{
        let userDetails = try? PropertyListDecoder().decode(LoginDataDict.self, from: data)
        return userDetails!
    }
    return nil
}

private func saveLoginData (_ value: LoginDataDict, _ Key: localStoreKeys){
    UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: Key.rawValue)
//    print(LoginDataDict)
    UserDefaults.standard.synchronize()
}

private func getLeaguesData (_ key: localStoreKeys) -> LeaguesModel? {
    if let data = UserDefaults.standard.value(forKey: key.rawValue) as? Data{
        let leaguesDetails = try? PropertyListDecoder().decode(LeaguesModel.self, from: data)
        return leaguesDetails!
    }
    return nil
}

private func saveLeaguesData (_ value: LeaguesModel, _ Key: localStoreKeys){
    UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: Key.rawValue)
    UserDefaults.standard.synchronize()
}
