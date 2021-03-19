//
//  Array+SubscriptTests.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

import XCTest
@testable import Chip8Kit

final class ArraySubscriptTests: XCTestCase {
    
    func testByte() {
        var bytes: [Byte] = [0xFF]
        
        XCTAssertEqual(bytes[Byte(0x00)], 0xFF)
        
        bytes[Byte(0x00)] = 0xEE
        
        XCTAssertEqual(bytes[Byte(0x00)], 0xEE)
    }
    
    func testWord() {
        var words: [Word] = [0xFFFF]
        
        XCTAssertEqual(words[Word(0x0000)], 0xFFFF)
        
        words[Word(0x0000)] = 0xEEEE
        
        XCTAssertEqual(words[Word(0x0000)], 0xEEEE)
    }
    
    static var allTests = [
        ("testByte", testByte),
        ("testWord", testWord),
    ]
    
}
