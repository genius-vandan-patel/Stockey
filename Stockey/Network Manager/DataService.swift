//
//  DataService.swift
//  Stockey
//
//  Created by Vandan Patel on 12/25/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import Foundation

class DataService {
    static let shared = DataService()
    private init() {}
    
    
    
    func getStockData(for stockSymbol: String ,completion: @escaping ([String: [String:Any]]?)->()) {
        let stockEndPoint = StockEndpoint.stockPrice(symbol: stockSymbol)
        let task = URLSession.shared.dataTask(with: stockEndPoint.url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                completion(nil)
            } else {
                guard let data = data else { completion(nil); return }
                if let jsonDict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: [String:Any]]{
                    completion(jsonDict)
                } else {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
