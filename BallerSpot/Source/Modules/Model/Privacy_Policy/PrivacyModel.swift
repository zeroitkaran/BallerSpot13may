//
//  PrivacyModel.swift
//  BallerSpot
//
//  Created by Zeroit on 14/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation
import UIKit




struct Privacy: Codable {
    var status, message: String?
    var data: PrivacyData?
}


struct PrivacyData: Codable {
    var id, policystr: String?
}

