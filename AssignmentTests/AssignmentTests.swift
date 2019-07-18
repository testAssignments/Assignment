//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by test on 17/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import Assignment

class AssignmentTests: XCTestCase {
    var testViewController = ViewController()
    override func setUp() {
        testViewController.setupview()
        testViewController.setLayouts()
        testViewController.setupNavigationBar()
        testViewController.refreshView()
    }
    func testDateSourceDelegate() {
        XCTAssertTrue(testViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(testViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(testViewController.responds(to:
            #selector(testViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(testViewController.responds(to:
            #selector(testViewController.tableView(_:cellForRowAt:))))
        XCTAssertTrue(testViewController.responds(to:
            #selector(testViewController.tableView(_:heightForRowAt:))))
    }
    func testTableViewCellHasReuseIdentifier() {
        let cell = testViewController.tableView.dequeueReusableCell(withIdentifier: "DataCellIdentifier")
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "DataCellIdentifier"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
}
