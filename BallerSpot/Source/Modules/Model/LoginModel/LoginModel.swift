//
//  LoginModel.swift
//  BallerSpot
//
//  Created by Zeroit on 04/03/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation


struct LoginDataDict : Codable {
    var data : LoginModel?
}

struct LoginModel : Codable {
    var email : String?
    var id : String?
    var message : String?
    var name : String?
    var phone : String?
    var pin: String?
    var status : String?
    var pool_amount: String?
    var first_name:String?
    var ranking:String?
    var image:String?
    var last_name:String?
    var username: String?
  
}
