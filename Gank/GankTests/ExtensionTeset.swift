//
//  ExtensionTeset.swift
//  Gank
//
//  Created by 李炜侃 on 16/7/15.
//  Copyright © 2016年 李炜侃. All rights reserved.
//

import XCTest
@testable import Gank

class ExtensionTeset: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetDailyDate() {
      let date = NSDate.dailyApiDate()
      XCTAssert(date == "2016/07/15")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
