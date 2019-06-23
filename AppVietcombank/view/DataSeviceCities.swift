//
//  DataSeviceCities.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/3/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import Foundation

typealias DICT = Dictionary<AnyHashable, Any>

class DataSeviceCities {
    static let shared : DataSeviceCities = DataSeviceCities()
    lazy var dataCitis: [Cities] = {
        return getData(fileName: "Cities", parseData: Cities.parse)
    }()
    lazy var dataDistricts: [Districts] = {
        return getData(fileName: "Districts", parseData: Districts.parse)
    }()
    
    var selecteDistricts: [Districts] = []
    var selecterCity: Cities? {
        didSet {
            if selecterCity != nil {
                selecteDistricts = dataDistricts.filter{ $0.cityCode ==  selecterCity!.cityCode}
            }
        }
    }
    
    func getData<T> (fileName: String, parseData: (DICT) -> [T]) -> [T] {
        var result: [T] = []
        guard let plistPath = Bundle.main.path(forResource: fileName, ofType: "plist") else {return []}
        guard let plistData = FileManager.default.contents(atPath: plistPath) else {return[]}
        do {
            guard let plistDic = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: nil) as? DICT else {return[]}
            result = parseData(plistDic)
        } catch {
            print("error")
        }
        return result
    }
}
