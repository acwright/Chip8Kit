//
//  ByteHexTests.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

import XCTest
@testable import Chip8Kit

final class ByteHexTests: XCTestCase {
    
    func testHexValue() {
        let byte: Byte = 0xFF
        
        XCTAssertEqual(byte.hexValue, "0xFF")
    }
    
    static var allTests = [
        ("testHexValue", testHexValue),
    ]
    
}
