//
//  ViewControllerTests.swift
//  StockeyTests
//
//  Created by Vandan Patel on 12/27/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import XCTest
@testable import Stockey

class ViewControllerTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        let _ = viewController.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStockSymbolsCount() {
        let count =  viewController.stockSymbols.count
        XCTAssertEqual(count, 9)
    }
    
    func testLoadData() {
        let stockDispatchGroup = DispatchGroup()
        for symbol in viewController.stockSymbols {
            stockDispatchGroup.enter()
            DataService.shared.getStockData(for: symbol, completion: { (dict) in
                let stockData = StockData(dict: dict!)
                if let value = stockData.topLevelData.first?.value {
                    let stock = Stock(dict: value, metaData: stockData.metaData)
                    self.viewController.stocks.append(stock)
                }
                stockDispatchGroup.leave()
            })
        }
        stockDispatchGroup.notify(queue: .main) {
            XCTAssertEqual(self.viewController.stocks.count, 9)
        }
    }
    
    func testRefresh() {
        viewController.stocks.removeAll()
        let stockDispatchGroup = DispatchGroup()
        for symbol in viewController.stockSymbols {
            stockDispatchGroup.enter()
            DataService.shared.getStockData(for: symbol, completion: { (dict) in
                let stockData = StockData(dict: dict!)
                if let value = stockData.topLevelData.first?.value {
                    let stock = Stock(dict: value, metaData: stockData.metaData)
                    self.viewController.stocks.append(stock)
                }
                stockDispatchGroup.leave()
            })
        }
        stockDispatchGroup.notify(queue: .main) {
            XCTAssertEqual(self.viewController.stocks.count, 9)
        }
    }
}
