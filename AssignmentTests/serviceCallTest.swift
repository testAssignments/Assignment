//
//  serviceCallTest.swift
//  AssignmentTests
//
//  Created by test on 17/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
import Foundation

class NetworkTests: XCTestCase {
    var Session: URLSession!
    override func setUp() {
        super.setUp()
        Session = URLSession(configuration: .default)
    }
    override func tearDown() {
        Session = nil
        super.tearDown()
    }
  /// Safe status code check
    func testValidCallToFactsUrlGetsHTTPStatusCode200() {
        let url =
            URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        let promise = expectation(description: "Status code: 200")
        let dataTask = Session.dataTask(with: url!) { (_ data, response, error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    /// Data Fullfilment test
    func testCallToFactsUrlCompletes() {
        let url =
            URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        let dataTask = Session.dataTask(with: url!) { (_ data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
