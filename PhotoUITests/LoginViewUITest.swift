//
//  LoginTest.swift
//  PhotoUITests
//
//  Created by Yahia El-Dow on 7/28/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import XCTest

class LoginViewUITest: XCTestCase {
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
    
    func testLoggingLoginScreenViewed() {
        

        let loginView = app.otherElements["loginView"]
        XCTAssertTrue(loginView.exists)
        

        let txtEmail = app.textFields["txtEmail"]
        let txtPassword = app.secureTextFields["txtPassword"]
        let btn_login = app.buttons["btn_login"]
        let btnSignup = app.buttons["btnSignup"]
        
        XCTAssertTrue(btn_login.exists)
        XCTAssertTrue(btnSignup.exists)
        XCTAssertTrue(txtEmail.exists)
        XCTAssertTrue(txtPassword.exists)
        
        btn_login.tap()
        app.alerts["!"].buttons["OK"].tap()

        txtEmail.tap()
        
        let mKey = app.keys["m"]
        let aaKey = app.keys["@"]
        let aKey = app.keys["a"]
        let iKey = app.keys["i"]
        let lKey = app.keys["l"]
        let dotKey = app.keys["."]

        mKey.tap()
        aaKey.tap()
        mKey.tap()
        aKey.tap()
        iKey.tap()
        lKey.tap()
        dotKey.tap()
        mKey.tap()
        mKey.tap()

        btn_login.tap()
        app.alerts["!"].buttons["OK"].tap()
        
        btn_login.tap()
    }

}
