//
//  ViewControllerUITests.swift
//  StockeyUITests
//
//  Created by Vandan Patel on 12/27/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import XCTest

class ViewControllerUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRefreshButtonDisabledAfterTap() {
        let refreshButton = app.navigationBars["Tech Stocks"].buttons["Refresh"]
        refreshButton.tap()
        XCTAssert(refreshButton.isEnabled == false, "Refresh Button is not disabled")
    }
    
    func testTitleLabel() {
        XCTAssert(app.navigationBars["Tech Stocks"].exists, "Tech Stocks title does not exist")
    }
    
    func testRefreshButtonExists() {
        let refreshButton = app.navigationBars["Tech Stocks"].buttons["Refresh"]
        XCTAssert(refreshButton.exists, "Refresh button does not exist")
    }
}
