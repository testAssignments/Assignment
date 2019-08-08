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
    var testViewController = CollectionViewController()
    override func setUp() {
        testViewController.setupCollectionView()
        testViewController.setUpNavigationBar()
        testViewController.refreshCollectionView()
    }
    func testDateSourceDelegate() {
        XCTAssertTrue(testViewController.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(testViewController.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(testViewController.responds(to:
            #selector(testViewController.collectionView(_:cellForItemAt:))))
        XCTAssertTrue(testViewController.responds(to:
            #selector(testViewController.numberOfSections(in:))))
        XCTAssertTrue(testViewController.responds(to:
            #selector(testViewController.collectionView(_:numberOfItemsInSection:))))
    }
    func testTableViewCellHasReuseIdentifier() {
        let cell = testViewController.collectionView.dequeueReusableCell(withReuseIdentifier: "DataCollectionCell", for: IndexPath())
        let actualReuseIdentifer = cell.reuseIdentifier
        let expectedReuseIdentifier = "DataCollectionCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
}
