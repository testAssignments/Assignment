//
//  serviceCallTest.swift
//  AssignmentTests
//
//  Created by test on 17/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
import Foundation
import Alamofire
@testable import Assignment

class NetworkTests: XCTestCase {
    var session: URLSession!
    override func setUp() {
        super.setUp()
        session = URLSession(configuration: .default)
    }
    override func tearDown() {
        session = nil
        super.tearDown()
    }
  /// Safe status code check
    func testValidCallToFactsUrlGetsHTTPStatusCode200() {
        let url =
            URL(string: DataViewModel().getURLFromPlist())
        let promise = expectation(description: "Status code: 200")
        let dataTask = session.dataTask(with: url!) { (_ data, response, error) in
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
            URL(string: DataViewModel().getURLFromPlist())
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        let dataTask = session.dataTask(with: url!) { (_ data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    func testAPIJSONResponse() {
        let exp = expectation(description: "API JSON Response")
        Alamofire.request(Constant.url) .validate().responseString { (response) in
            if response.result.isSuccess {
                guard let data = response.value?.data(using: .utf8) else { return }
                do {
                    //JSON data parsing using Codable protocol
                    let decoder = JSONDecoder()
                    let viewData = try decoder.decode(ApiData.self, from: data)
                    
                    if let count = viewData.rows?.count, count > 0 {
                        exp.fulfill()
                    } else {
                        
                        XCTFail("API DOES NOT CONTAIN ANY DATA TO DISPLAY ON COLLECTIONVIEW")
                    }
                } catch let err {
                    XCTFail(err.localizedDescription)
                }
            } else {
                XCTFail(response.error?.localizedDescription ?? "ERROR")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
