//
//  NetworkTests.swift
//  StockeyTests
//
//  Created by Vandan Patel on 12/26/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import XCTest
@testable import Stockey

class NetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEndPointStrings() {
        let stockEndPoint_MSFT = StockEndpoint.stockPrice(symbol: "MSFT")
        let stockENDPoint_AAPL = StockEndpoint.stockPrice(symbol: "AAPL")
        
        XCTAssertEqual(stockEndPoint_MSFT.urlString, "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=1min&apikey=HF1OZVTE6NYX8RP1")
        XCTAssertEqual(stockENDPoint_AAPL.urlString, "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=AAPL&interval=1min&apikey=HF1OZVTE6NYX8RP1")
    }
    
    func testEndPointURLs() {
        let stockEndPointURL_MSFT = StockEndpoint.stockPrice(symbol: "MSFT")
        let stockENDPoint_AAPL = StockEndpoint.stockPrice(symbol: "AAPL")
        
        XCTAssertEqual(stockEndPointURL_MSFT.url, URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=1min&apikey=HF1OZVTE6NYX8RP1"))
        XCTAssertEqual(stockENDPoint_AAPL.url, URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=AAPL&interval=1min&apikey=HF1OZVTE6NYX8RP1"))
    }
    
    func testGetStockData() {
        let expectation = XCTestExpectation(description: "Get Stock Data")
        
        let stockEndPoint = StockEndpoint.stockPrice(symbol: "MSFT")
        let task = URLSession.shared.dataTask(with: stockEndPoint.url) { (data, response, error) in
            
            XCTAssertNotNil(data, "No data was downloaded")
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            XCTAssertTrue(statusCode! >= 200 && statusCode! < 300)
            
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        
        task.resume()
        wait(for: [expectation], timeout: 15.0)
    }
}
