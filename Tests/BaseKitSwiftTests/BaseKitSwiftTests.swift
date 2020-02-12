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
        
        var data = Data.init([0x00, 0x01, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0x10])
        var result16 = data.readValue(as: UInt16.self)
        XCTAssertEqual(result16, 0x100)
        result16 = data.readValue(offset: 1, as: UInt16.self)
        XCTAssertEqual(result16, 0x101)
        result16 = data.readValue(offset: 2, as: UInt16.self)
        XCTAssertEqual(result16, 0x201)
        result16 = data.readValue(offset: 3, as: UInt16.self)
        XCTAssertEqual(result16, 0x302)
        result16 = data.readValue(offset: 4, as: UInt16.self)
        XCTAssertEqual(result16, 0x403)
        result16 = data.readValue(offset: 6, as: UInt16.self)
        XCTAssertEqual(result16, 0x605)
        result16 = data.readValue(offset: 8, as: UInt16.self)
        XCTAssertEqual(result16, 0x807)
        result16 = data.readValue(offset: 10, as: UInt16.self)
        XCTAssertEqual(result16, 0x1009)
        
        var result32 = data.readValue(as: UInt32.self)
        XCTAssertEqual(result32, 0x2010100)
        
        result32 = data.readValue(offset: 4, as: UInt32.self)
        XCTAssertEqual(result32, 0x6050403)
        
        result32 = data.readValue(offset: 8, as: UInt32.self)
        XCTAssertEqual(result32, 0x10090807)
        
        var result64 = data.readValue(as: UInt64.self)
        XCTAssertEqual(result64, 0x605040302010100)
        
        result64 = data.readValue(offset: 4, as: UInt64.self)
        XCTAssertEqual(result64, 0x1009080706050403)
        
        data = Data.create(0x123456, as: UInt32.self)
        result32 = data.readValue(as: UInt32.self)
        XCTAssertEqual(result32, 0x123456)
        data.append(0x1009080706050403, as: UInt64.self)
        result64 = data.readValue(offset: 4, as: UInt64.self)
        XCTAssertEqual(result64, 0x1009080706050403)
        data.storeBytes(0x6666, toByteOffset: 6, as: UInt16.self)
        result16 = data.readValue(offset: 6, as: UInt16.self)
        XCTAssertEqual(result16, 0x6666)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
