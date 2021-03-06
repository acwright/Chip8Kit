//
//  Chip8Tests.swift
//  Chip8Kit
//
//  Copyright (c) 2021 A.C. Wright

import XCTest
@testable import Chip8Kit

final class Chip8Tests: XCTestCase {
    
    func testExample() {
        let chip8 = Chip8(rom: [])
        
        try? chip8.execute(opcode: 0xF017)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
    
}
