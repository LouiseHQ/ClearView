//
//  ClearViewUITests.swift
//  ClearViewUITests
//
//  Created by LouiseHQ on 4/11/17.
//  Copyright © 2017 LouiseHQ. All rights reserved.
//

import XCTest

class ClearViewUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        XCUIDevice.shared().orientation = .faceUp
        
        let app = XCUIApplication()
        app.images["./icon/welcome.jpg"].tap()
        XCUIDevice.shared().orientation = .portrait
        XCUIDevice.shared().orientation = .faceUp
        XCUIDevice.shared().orientation = .portrait
        XCUIDevice.shared().orientation = .landscapeLeft
        XCUIDevice.shared().orientation = .faceUp
        app.buttons["library"].tap()
        app.navigationBars["Photos"].buttons["Cancel"].tap()
        XCUIDevice.shared().orientation = .portrait
        XCUIDevice.shared().orientation = .faceUp
        XCUIDevice.shared().orientation = .landscapeLeft
        XCUIDevice.shared().orientation = .portrait
        XCUIDevice.shared().orientation = .faceUp
        XCUIDevice.shared().orientation = .portrait
        XCUIDevice.shared().orientation = .faceUp
        
        
//        let app = XCUIApplication()
//        app.images["./icon/welcome.jpg"].tap()
//        
//        let snapButton = app.buttons["Snap"]
//        snapButton.tap()
//        app.buttons["manual"].tap()
//        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeRight()
//        app.buttons["Remove Reflection"].tap()
//        app.buttons["auto"].tap()
//        snapButton.tap()
//        app.buttons["Back to Wide Angle"].tap()
//        XCUIDevice.shared().orientation = .portrait
//        XCUIDevice.shared().orientation = .landscapeRight
//        XCUIDevice.shared().orientation = .portrait
//        XCUIDevice.shared().orientation = .faceUp
//        app.buttons["library"].tap()
//        app.navigationBars["Photos"].buttons["Cancel"].tap()
        
    }
    
}
