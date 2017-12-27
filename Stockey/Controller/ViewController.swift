//
//  ViewController.swift
//  Stockey
//
//  Created by Vandan Patel on 12/25/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let stockSymbols = ["AAPL", "GOOGL", "MSFT","FB","INTC","ORCL","CSCO","IBM","SAP"]
    let stockPrices = [Stock]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //these are asynchronus calls, first call doesn't necessarily returns first, so there is a field stock name in the model to store the name of the stock and values as they return. stockSybols array could be used if they are synchronus calls
        for symbol in stockSymbols {
            DataService.shared.getStockData(for: symbol, completion: { (dict) in
                let stockData = StockData(dict: dict!)
                if let value = stockData.topLevelData.first?.value {
                    let stock = Stock(dict: value, metaData: stockData.metaData)
                }
            })
        }
    }
}

