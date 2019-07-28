//
//  PhotoTests.swift
//  PhotoTests
//
//  Created by Yahia El-Dow on 7/24/19.
//  Copyright © 2019 Yahia El-Dow. All rights reserved.
//

import XCTest
@testable import Photo

class PhotoTests: XCTestCase {
    
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
  
    let temp_jsonData = ["imgUrl":"imageURL" as AnyObject,
                         "imgaeStatus" : 1  as AnyObject,
                         "release_date": "12/01/2019" as AnyObject ,
                         "userName" : "User Name" as AnyObject]
    
    
    
    func test_full_unitTest(){
        self.testCodableDecode()
        let imgModel = Image(imgUrl: "ImageURL", imgaeStatus: 1, userName: "User Name", imageData: nil)
        self.testCodableParseToJson(imageModel: imgModel)
        self.checkStringIsEmailForrmate()
//        self.testFeatchCoreData()
        
    }
    
    
    func testCodableDecode(){
      
        
        if let imageJsonData = JsonHandler.jsonToNSData(json: temp_jsonData) {
            let modelParse = CodableHandler.decode(Image.self, from: imageJsonData)
            if modelParse is Image {
                 print("Success")
            }else{
                fatalError("Can`t Decode Json")
            }
        }else{
            fatalError("Can`t parse Temp Array to Data")
            
        }
        
    }
    func testCodableParseToJson(imageModel : Image){
        XCTAssert( ((CodableHandler.encode(imageModel) as? [String : AnyObject]) != nil))
        print("Success Parsing")
    }
    
    func testJsonParser(){
        
        XCTAssert( JsonHandler.jsonToNSData(json: self.temp_jsonData) != nil)
        print("Success Parsing")
        self.testJsonParserWithNullValues()
    }
    
    func testJsonParserWithNullValues(){
        let arrTest = ["key1":NSNull() , "key2" : NSNull()]
        XCTAssert( JsonHandler.jsonToNSData(json: arrTest) != nil)
        print("Success Parsing to Data")
    }
    

    func checkStringIsEmailForrmate(){
        let validEmail : String = "test@mail.com"
        let inValidEmail : String = "test email .com"
        // should be return true
        XCTAssert( validEmail.isValidEmail() == true )
        // should be return false
        XCTAssert( inValidEmail.isValidEmail() == false )
        print("Success Validation")
    }

    


}
