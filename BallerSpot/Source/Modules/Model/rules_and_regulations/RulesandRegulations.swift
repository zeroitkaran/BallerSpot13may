//
//  RulesandRegulations.swift
//  BallerSpot
//
//  Created by Zeroit on 14/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation
import UIKit


struct rules: Codable {
    var status, message: String?
    var data: RulesData?
}


struct RulesData: Codable {
    var id, rules: String?
}

