//
//  Tests.swift
//  Tests
//
//  Created by Bryan Irace on 9/8/15.
//  Copyright (c) 2015 Bryan Irace. All rights reserved.
//

import XCTest
import Nibble

class Tests: XCTestCase {
    let phoneNumber = ""; // Fill me in
    
    func testRequestCode() {
        let expectation = expectationWithDescription("requestCode")
        
        let task = API().requestCode(phoneNumber) { response in
            XCTAssertTrue(response.success, "Response should be successful")
            expectation.fulfill()
        }
        task.resume()
        
        waitForExpectationsWithTimeout(10) { error in
            XCTFail("Timed out")
        }
    }
    
    func testAuth() {
        let code = ""; // Fill me in
        
        let expectation = expectationWithDescription("auth")
        
        let task = API().auth(phoneNumber, code: code) { response, user in
            XCTAssertTrue(response.success, "Response should be successful")
            expectation.fulfill()
        }
        task.resume()
        
        waitForExpectationsWithTimeout(10) { error in
            XCTFail("Timed out")
        }
    }
    
    private func API() -> ByteAPI {
        return ByteAPI(session: NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()))
    }
}
