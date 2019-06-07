//
//  Districts.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/3/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import Foundation

class Districts: Name {
    var cityCode :Int
    var districts:Int
    var name     :String
    init?(dictionary: DICT) {
        guard let cityCode  = dictionary["CityCode"]     as? Int    else {return nil}
        guard let districts = dictionary["DistrictCode"] as? Int    else {return nil}
        guard let name      = dictionary["Name"]         as? String else {return nil}
        self.cityCode       = cityCode
        self.districts      = districts
        self.name           = name
    }
    static func parse(dictionary: DICT) -> [Districts] {
        guard let listDistricts = dictionary["Districts"] as? [DICT] else {return []}
        return listDistricts.map{ Districts(dictionary: $0)!}
    }
}
