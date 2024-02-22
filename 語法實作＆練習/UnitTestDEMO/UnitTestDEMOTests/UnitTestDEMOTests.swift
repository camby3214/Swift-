//
//  UnitTestDEMOTests.swift
//  UnitTestDEMOTests
//
//  Created by 李韋辰 on 2022/6/14.
//

import XCTest
@testable import UnitTestDEMO

class UnitTestDEMOTests: XCTestCase {

    func testAddStuff() {
        let math = MathStuff()
        let result = math.addNumbers(x: 1, y: 2)
        XCTAssertEqual(result, 3)
    }
    
    func testMutipleStuff() {
        let math = MathStuff()
        let result = math.mutipleNumbers(x: 1, y: 2)
        XCTAssertEqual(result, 2)
    }
    func testdivideStuff() {
        let math = MathStuff()
        let result = math.divideNumbers(x: 1, y: 2)
        XCTAssertEqual(result, 0)
    }
    
    func testTimeStamp() {
        let math = MathStuff()
        let result = math.timeStringChangeTimeStamp(time: "2022 / 06 / 14 15")
        XCTAssertEqual(result, 1655190000)
    }
    
    
    
}
