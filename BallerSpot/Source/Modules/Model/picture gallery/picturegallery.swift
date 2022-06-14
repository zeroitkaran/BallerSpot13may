//
//  picturegallery.swift
//  BallerSpot
//
//  Created by Zeroit on 11/09/20.
//  Copyright © 2020 Zero ITSolutions. All rights reserved.
//

import Foundation
import UIKit

struct Picture: Codable {
    var status, message: String?
    var data: PictureData?
}


struct PictureData: Codable {
    var url: String?
    var resultCode: String?
    var resultData: [PictureData1]?

 }
struct PictureData1: Codable {
    var id, images, createdAt, updatedAt: String?
}
