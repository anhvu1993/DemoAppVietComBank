//
//  Map.swift
//  AppVietcombank
//
//  Created by Anh vũ on 5/29/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit

struct ATM: Decodable {
    var addressbank: String?
    var name: String?
    var tatitudeBank: Double?
    var longitudeBank: Double?
    var tatitudeAtm: Double?
    var longitudeAtm: Double?
    var tatitudebranch: Double?
    var longitudebranch: Double?
    var logoUrlBranch: String?
    var googleUrl: String?
    var zoom: Int?
}
