//
//  LiveNewsModel.swift
//  BallerSpot
//
//  Created by Zeroit on 11/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Welcome
struct LiveNews: Codable {
    var status, message: String?
    var data: DataClass?
}


struct DataClass: Codable {
    var url: String?
    var resultData: [Newsdata]?

   
}


struct Newsdata: Codable {
    var id, pid: Int?
    var seo, tit, des, con: String?
    var pub: Int?
    var tst: String?
    var thb, img: String?
    var cap, aut, ava: String?
    
}

