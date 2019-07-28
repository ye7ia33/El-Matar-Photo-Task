//
//  LoginViewTest.swift
//  PhotoTests
//
//  Created by Yahia El-Dow on 7/28/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//


import XCTest
@testable import Photo


class AuthTest: XCTestCase {
    
    let authVM = AuthenticationViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
  
    override func tearDown() {
        super.tearDown()
        
    }
    
    func testLogin(){
        let cancelExpectation = expectation(description: "Cancel")
        cancelExpectation.isInverted = true
        let completedExpectation = expectation(description: "Completed")

        authVM.login(WithEmailAddress: "yahia.eldow@gmail.com", password: "123456")
        authVM.completionHandler = {
            err in
            if err != nil {
               cancelExpectation.fulfill()
                return
            }
            completedExpectation.fulfill()

        }
        
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertNotNil(authVM.currentUser, "inValid Auth...")
    }
    
    
    func testRegistration(){
        let cancelExpectation = expectation(description: "Cancel")
        cancelExpectation.isInverted = true
        
        let completedExpectation = expectation(description: "Completed")
        authVM.registration(whithUserName: "Yahia Mohamed ", email: "m@gnail.com", password: "123456")
        authVM.completionHandler = {
            err in
            if err != nil {
                cancelExpectation.fulfill()
                return
            }
            completedExpectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertNotNil(authVM.currentUser, "inValid Auth...")
    }
    
    func testLogout(){
        authVM.logout()
        XCTAssertNil(authVM.currentUser, "not Logout...")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    
}
