//
//  Stock.swift
//  Stockey
//
//  Created by Vandan Patel on 12/25/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import Foundation

struct StockData {
    let topLevelData: [String: [String: Any]]
    let metaData: [String: Any]
    
    init(dict: [String: [String:Any]]) {
        self.topLevelData = dict["Time Series (1min)"] as! [String : [String : Any]]
        self.metaData = dict["Meta Data"]!
    }
}

struct Stock {
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String
    let name: String
    let lastRefreshed: String
    let timeZone: String
    
    init(dict: [String: Any], metaData:  [String:Any]) {
        self.open = dict["1. open"] as! String
        self.high = dict["2. high"] as! String
        self.low = dict["3. low"] as! String
        self.close = dict["4. close"] as! String
        self.volume = dict["5. volume"] as! String
        self.name = metaData["2. Symbol"] as! String
        self.lastRefreshed = metaData["3. Last Refreshed"] as! String
        self.timeZone = metaData["6. Time Zone"] as! String
    }
}
