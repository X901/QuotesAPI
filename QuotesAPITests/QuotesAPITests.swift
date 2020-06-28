////
//QuotesAPITests.swift
//QuotesAPITests
//
//Created by Basel Baragabah on 26/06/2020.
//Copyright © 2020 Basel Baragabah. All rights reserved.
//

import XCTest
@testable import QuotesAPI

class QuotesAPITests: XCTestCase {

    var vc = QuotesViewController()

    func testApiCall(){
        let e = expectation(description: "Alamofire")

        vc.requestRandomQuote { (result, state) in
            
            if state {
                if let result = result  {
                   
                    XCTAssertEqual(result.author, "Steve Jobs")

                }
            }
        e.fulfill()

        }
        waitForExpectations(timeout: 5.0, handler: nil)

    }

}
