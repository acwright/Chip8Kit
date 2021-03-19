//
//  WordHexTests.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

import XCTest
@testable import Chip8Kit

final class WordHexTests: XCTestCase {
    
    func testHexValue() {
        let word: Word = 0xFFFF
        
        XCTAssertEqual(word.hexValue, "0xFFFF")
    }
    
    static var allTests = [
        ("testHexValue", testHexValue),
    ]
    
}
