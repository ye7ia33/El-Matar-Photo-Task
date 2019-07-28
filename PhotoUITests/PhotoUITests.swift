//
//  PhotoUITests.swift
//  PhotoUITests
//
//  Created by Yahia El-Dow on 7/24/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import XCTest

class PhotoUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLunchScreen(){
        app.launch()
    }
    
    func testHomeVC()  {
        app.launch()
        
        let completedExpectation = expectation(description: "Completed")
        completedExpectation.isInverted = true
        waitForExpectations(timeout: 10, handler: nil)
        
        let homeView = app.otherElements["homeView"]
        XCTAssertTrue(homeView.exists)

        let homeCollectionView = app.collectionViews["homeCollectionView"]
        XCTAssertTrue(homeCollectionView.exists)
        
        let cells = XCUIApplication().collectionViews.cells
        if cells.count != 0 {
            let firstCell = cells.element(boundBy: 0)
            XCTAssertTrue(firstCell.exists)
            // to expand cell
            firstCell.tap()
            // return cell to current size
            firstCell.tap()
            
            self.testingPullToRefresh(firstCell: homeCollectionView)
        }else{
            self.testingPullToRefresh(firstCell: homeCollectionView)
        }
        app.swipeUp()
        app.swipeUp()
        app.swipeDown()
        
    }
    func testingPullToRefresh(firstCell : XCUIElement ){
        let start = firstCell.coordinate(withNormalizedOffset:CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 3))
        start.press(forDuration: 0.1, thenDragTo: finish)
        
    }
    
    
    
}
