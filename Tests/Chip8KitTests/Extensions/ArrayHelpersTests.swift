//
//  ArrayHelpersTests.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

import XCTest
@testable import Chip8Kit

final class ArrayHelpersTests: XCTestCase {
    
    func testHexValues() {
        let byteValues: [Byte] = [0xEE, 0xFF]
        let wordValues: [Word] = [0xEEEE, 0xFFFF]
        
        XCTAssertEqual(byteValues.hexValues(), ["0xEE","0xFF"])
        XCTAssertEqual(wordValues.hexValues(), ["0xEEEE","0xFFFF"])
    }
    
    func testHexString() {
        let byteValues: [Byte] = [0xEE, 0xFF]
        let wordValues: [Word] = [0xEEEE, 0xFFFF]
        
        XCTAssertEqual(byteValues.hexString(), "0xEE,0xFF")
        XCTAssertEqual(wordValues.hexString(), "0xEEEE,0xFFFF")
    }
    
    static var allTests = [
        ("testHexValues", testHexValues),
        ("testHexString", testHexString),
    ]
    
}
