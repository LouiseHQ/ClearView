//
//  ImageTests.swift
//  ClearView
//
//  Created by Bell on 4/11/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

import XCTest
@testable import ClearView

class ImageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testImageConversion() {
        var image = Image(image: UIImage(named: "Apple")!)
        var uiImage = image.getUIImage()
        
        let heightInPoints = uiImage.size.height
        let heightInPixels = heightInPoints * uiImage.scale
        
        let widthInPoints = uiImage.size.width
        let widthInPixels = widthInPoints * uiImage.scale
        
        XCTAssertEqual(heightInPixels, 302)
        XCTAssertEqual(widthInPixels, 302)
    }
}
