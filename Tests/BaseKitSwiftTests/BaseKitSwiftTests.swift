//
//  BaseKitSwiftTests.swift
//  BaseKitSwiftTests
//
//  Created by ldc on 2019/5/23.
//  Copyright © 2019 Xiamen Hanin. All rights reserved.
//

import XCTest
@testable import BaseKitSwift

class BaseKitSwiftTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testIpPredicate() -> Void {
        
        var ip = "255.255.255.255"
        XCTAssertTrue(ip.isIp)
        
        ip = "0.0.0.0"
        XCTAssertTrue(ip.isIp)
        
        ip = "9.12.123.9"
        XCTAssertTrue(ip.isIp)
        
        ip = "001.01.023.23"
        XCTAssertTrue(ip.isIp)
        
        ip = "256.01.023.23"
        XCTAssertTrue(!ip.isIp)
        
        ip = "321.01.023.23"
        XCTAssertTrue(!ip.isIp)
    }
    
    func testReadData() -> Void {
        
        let data = Data.init([0x00, 0x01, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0x10])
        let result1 = data.read(to: UInt16.self)!
        XCTAssertEqual(result1, 0x100)
        let result2 = data.read(to: UInt16.self, offset: 1)!
        XCTAssertEqual(result2, 0x101)
        let result3 = data.read(to: UInt16.self, offset: 2)!
        XCTAssertEqual(result3, 0x201)
        let result4 = data.read(to: UInt16.self, offset: 3)!
        XCTAssertEqual(result4, 0x302)
        let result5 = data.read(to: UInt16.self, offset: 4)!
        XCTAssertEqual(result5, 0x403)
        let result6 = data.read(to: UInt16.self, offset: 6)!
        XCTAssertEqual(result6, 0x605)
        let result7 = data.read(to: UInt16.self, offset: 8)!
        XCTAssertEqual(result7, 0x807)
        let result8 = data.read(to: UInt16.self, offset: 10)!
        XCTAssertEqual(result8, 0x1009)
        
        let result9 = data.read(to: UInt32.self)!
        XCTAssertEqual(result9, 0x2010100)
        
        let result10 = data.read(to: UInt32.self, offset: 4)!
        XCTAssertEqual(result10, 0x6050403)
        
        let result11 = data.read(to: UInt32.self, offset: 8)!
        XCTAssertEqual(result11, 0x10090807)
        
        let result12 = data.read(to: UInt64.self)!
        XCTAssertEqual(result12, 0x605040302010100)
        
        let result13 = data.read(to: UInt64.self, offset: 4)!
        XCTAssertEqual(result13, 0x1009080706050403)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
