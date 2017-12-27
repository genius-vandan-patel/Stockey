//
//  Endpoint.swift
//  Stockey
//
//  Created by Vandan Patel on 12/25/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import Foundation

var baseURL = "https://www.alphavantage.co"
var queryFunction = "/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=1min&apikey=HF1OZVTE6NYX8RP1"


protocol Endpoint {
    var urlString : String { get }
}

extension Endpoint {
    var url: URL {
        return URL(string: urlString)!
    }
    
    func changeQueryFunctionForSymbol(with str: String) -> String {
        return "/query?function=TIME_SERIES_INTRADAY&symbol=\(str)&interval=1min&apikey=HF1OZVTE6NYX8RP1"
    }
}

enum StockEndpoint: Endpoint {
    
    case stockPrice(symbol: String)
    
    var urlString: String {
        switch self {
        case .stockPrice(symbol: let sym):
            return baseURL + changeQueryFunctionForSymbol(with: sym)
        }
    }
}
