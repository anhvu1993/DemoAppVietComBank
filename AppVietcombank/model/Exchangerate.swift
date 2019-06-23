//
//  Exchangerate.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/15/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import Foundation
class Exchangerate {
    var currency: String
    var buying: String
    var sell: String
    init(currency: String, buying: String, sell: String ) {
       self.currency = currency
        self.buying = buying
        self.sell = sell
    }
}
