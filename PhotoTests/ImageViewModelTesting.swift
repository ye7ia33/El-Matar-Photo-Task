//
//  ImageViewModelTesting.swift
//  PhotoTests
//
//  Created by Yahia El-Dow on 7/28/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import XCTest
@testable import Photo


class ImageViewModelTest: XCTestCase {
    
    let imageVM = ImagesViewModel()
    

    
    override func tearDown() {
        super.tearDown()
        imageVM.imageList.removeAll()
    }
    
    func testPublicImage(){
     
      

        let completedExpectation = expectation(description: "Completed")
        completedExpectation.isInverted = true
        imageVM.getImages(privacy: .publicImage)
        imageVM.completionHandler = {
            err in
            XCTAssertNil(err, "error \(err.debugDescription)...")
            

        }
  
        
        waitForExpectations(timeout: 15, handler: nil)
        print("Everything is Ok.")
    }
    
    func testPrivateImage()  {
        
        let completedExpectation = expectation(description: "Completed")
        completedExpectation.isInverted = true
        
        let tempUserID = "nvOKmv08KZOuZwpHLfQFPpLvusj2"
        imageVM.getImages(privacy: .privateImage , byUserId: tempUserID)
        imageVM.completionHandler = {
            err in
            XCTAssertNil(err, "error \(err.debugDescription)...")
            XCTAssert(self.imageVM.imageList.count > 0 , "User Image Is Empty.")
        }
        
        waitForExpectations(timeout: 15, handler: nil)
        print("Everything is Ok.")

        

        
    }
    
   
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    
}
