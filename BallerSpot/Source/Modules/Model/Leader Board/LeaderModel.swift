//
//  LeaderModel.swift
//  BallerSpot
//
//  Created by Zeroit on 14/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation
import UIKit
struct Leader:Codable{
     var status, message: String?
    var resultdata:[LeaderBoardData]?
}

struct LeaderBoardData: Codable{
    var id:String?
    var first_name:String?
    var image:String?
    var  pool_amount:String?
    
}
