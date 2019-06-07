//
//  Cities.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/3/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import Foundation
protocol Name {
    var name:String{get set}
}

class Cities: Name {
    var cityCode:Int
    var name:    String
    init?(dictionary: DICT) {
        guard let cityCode = dictionary["CityCode"] as? Int else {return nil}
        guard let name = dictionary["Name"] as? String else {return nil}
        self.cityCode = cityCode
        self.name = name
    }
    static func parse(dictionary: DICT) -> [Cities] {
      guard let listDistrict = dictionary["Cities"] as? [DICT] else {return []}
        return listDistrict.map{Cities(dictionary: $0)!}
    }
}
