//
//  Chip8Tests.swift
//  Chip8Kit
//
//  Copyright (c) 2021 A.C. Wright

import XCTest
@testable import Chip8Kit

final class Chip8Tests: XCTestCase {
    
    func testExample() {
        var chip8 = Chip8(rom: [])
        
        try? chip8.execute(opcode: 0xF017)
        
        let opcode: Opcode = 0x64FD
//        let result = (opcode & 0x0F00) >> 8
//
        try? chip8.execute(opcode: opcode)
        XCTAssertTrue(chip8.v[4] == 0xFD)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
    
}
