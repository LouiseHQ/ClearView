//
//  ClearViewTests.swift
//  ClearViewTests
//
//  Created by LouiseHQ on 4/11/17.
//  Copyright © 2017 LouiseHQ. All rights reserved.
//

import XCTest
@testable import ClearView

class ClearViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testXorLearner() {
        let xorLearner: XorLearner = XorLearner()
        XCTAssert(xorLearner.classify(1, and: 1) < 0)
        XCTAssert(xorLearner.classify(1, and: -1) > 0)
        XCTAssert(xorLearner.classify(-1, and: 1) > 0)
        XCTAssert(xorLearner.classify(-1, and: -1) < 0)
    }
}
