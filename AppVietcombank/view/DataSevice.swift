//
//  DataSevice.swift
//  AppVietcombank
//
//  Created by Anh vũ on 5/29/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
var urlApi = "http://5cee41bd1c2baf00142cbca9.mockapi.io/api/googleMap"

class DataSevice {
    static let shared : DataSevice = DataSevice()
    
    func makeRequestJson(comlethander: @escaping ([ATM]) -> ()) {
        guard let url = URL(string: urlApi) else {return}
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 1000)
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            guard error == nil else {return}
            guard (reponse as? HTTPURLResponse)?.statusCode == 200 else {return}
            guard let datas = data else {return}
            do {
                let listMap = try? JSONDecoder().decode([ATM].self, from: datas)
             
                DispatchQueue.main.async {
                    comlethander(listMap!)
                }
            }catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

