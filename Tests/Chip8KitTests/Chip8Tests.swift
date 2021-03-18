//
//  Chip8Tests.swift
//  Chip8Kit
//
//  Copyright (c) 2021 A.C. Wright

import XCTest
@testable import Chip8Kit

final class Chip8Tests: XCTestCase {
    
    // https://github.com/corax89/chip8-test-rom
    
    static let testROM: [Byte] = [
        0x12,0x4E,0xEA,0xAC,0xAA,0xEA,0xCE,0xAA,0xAA,0xAE,0xE0,0xA0,0xA0,0xE0,0xC0,0x40,
        0x40,0xE0,0xE0,0x20,0xC0,0xE0,0xE0,0x60,0x20,0xE0,0xA0,0xE0,0x20,0x20,0x60,0x40,
        0x20,0x40,0xE0,0x80,0xE0,0xE0,0xE0,0x20,0x20,0x20,0xE0,0xE0,0xA0,0xE0,0xE0,0xE0,
        0x20,0xE0,0x40,0xA0,0xE0,0xA0,0xE0,0xC0,0x80,0xE0,0xE0,0x80,0xC0,0x80,0xA0,0x40,
        0xA0,0xA0,0xA2,0x02,0xDA,0xB4,0x00,0xEE,0xA2,0x02,0xDA,0xB4,0x13,0xDC,0x68,0x01,
        0x69,0x05,0x6A,0x0A,0x6B,0x01,0x65,0x2A,0x66,0x2B,0xA2,0x16,0xD8,0xB4,0xA2,0x3E,
        0xD9,0xB4,0xA2,0x02,0x36,0x2B,0xA2,0x06,0xDA,0xB4,0x6B,0x06,0xA2,0x1A,0xD8,0xB4,
        0xA2,0x3E,0xD9,0xB4,0xA2,0x06,0x45,0x2A,0xA2,0x02,0xDA,0xB4,0x6B,0x0B,0xA2,0x1E,
        0xD8,0xB4,0xA2,0x3E,0xD9,0xB4,0xA2,0x06,0x55,0x60,0xA2,0x02,0xDA,0xB4,0x6B,0x10,
        0xA2,0x26,0xD8,0xB4,0xA2,0x3E,0xD9,0xB4,0xA2,0x06,0x76,0xFF,0x46,0x2A,0xA2,0x02,
        0xDA,0xB4,0x6B,0x15,0xA2,0x2E,0xD8,0xB4,0xA2,0x3E,0xD9,0xB4,0xA2,0x06,0x95,0x60,
        0xA2,0x02,0xDA,0xB4,0x6B,0x1A,0xA2,0x32,0xD8,0xB4,0xA2,0x3E,0xD9,0xB4,0x22,0x42,
        0x68,0x17,0x69,0x1B,0x6A,0x20,0x6B,0x01,0xA2,0x0A,0xD8,0xB4,0xA2,0x36,0xD9,0xB4,
        0xA2,0x02,0xDA,0xB4,0x6B,0x06,0xA2,0x2A,0xD8,0xB4,0xA2,0x0A,0xD9,0xB4,0xA2,0x06,
        0x87,0x50,0x47,0x2A,0xA2,0x02,0xDA,0xB4,0x6B,0x0B,0xA2,0x2A,0xD8,0xB4,0xA2,0x0E,
        0xD9,0xB4,0xA2,0x06,0x67,0x2A,0x87,0xB1,0x47,0x2B,0xA2,0x02,0xDA,0xB4,0x6B,0x10,
        0xA2,0x2A,0xD8,0xB4,0xA2,0x12,0xD9,0xB4,0xA2,0x06,0x66,0x78,0x67,0x1F,0x87,0x62,
        0x47,0x18,0xA2,0x02,0xDA,0xB4,0x6B,0x15,0xA2,0x2A,0xD8,0xB4,0xA2,0x16,0xD9,0xB4,
        0xA2,0x06,0x66,0x78,0x67,0x1F,0x87,0x63,0x47,0x67,0xA2,0x02,0xDA,0xB4,0x6B,0x1A,
        0xA2,0x2A,0xD8,0xB4,0xA2,0x1A,0xD9,0xB4,0xA2,0x06,0x66,0x8C,0x67,0x8C,0x87,0x64,
        0x47,0x18,0xA2,0x02,0xDA,0xB4,0x68,0x2C,0x69,0x30,0x6A,0x34,0x6B,0x01,0xA2,0x2A,
        0xD8,0xB4,0xA2,0x1E,0xD9,0xB4,0xA2,0x06,0x66,0x8C,0x67,0x78,0x87,0x65,0x47,0xEC,
        0xA2,0x02,0xDA,0xB4,0x6B,0x06,0xA2,0x2A,0xD8,0xB4,0xA2,0x22,0xD9,0xB4,0xA2,0x06,
        0x66,0xE0,0x86,0x6E,0x46,0xC0,0xA2,0x02,0xDA,0xB4,0x6B,0x0B,0xA2,0x2A,0xD8,0xB4,
        0xA2,0x36,0xD9,0xB4,0xA2,0x06,0x66,0x0F,0x86,0x66,0x46,0x07,0xA2,0x02,0xDA,0xB4,
        0x6B,0x10,0xA2,0x3A,0xD8,0xB4,0xA2,0x1E,0xD9,0xB4,0xA3,0xE8,0x60,0x00,0x61,0x30,
        0xF1,0x55,0xA3,0xE9,0xF0,0x65,0xA2,0x06,0x40,0x30,0xA2,0x02,0xDA,0xB4,0x6B,0x15,
        0xA2,0x3A,0xD8,0xB4,0xA2,0x16,0xD9,0xB4,0xA3,0xE8,0x66,0x89,0xF6,0x33,0xF2,0x65,
        0xA2,0x02,0x30,0x01,0xA2,0x06,0x31,0x03,0xA2,0x06,0x32,0x07,0xA2,0x06,0xDA,0xB4,
        0x6B,0x1A,0xA2,0x0E,0xD8,0xB4,0xA2,0x3E,0xD9,0xB4,0x12,0x48,0x13,0xDC
    ]
    
    func testInit() {
        let chip8 = Chip8(rom: Chip8Tests.testROM)

        XCTAssertEqual(chip8.v, [Byte](repeating: 0, count: 16))
        XCTAssertEqual(chip8.i, 0)
        XCTAssertEqual(chip8.pc, 0x200)
        XCTAssertEqual(chip8.stack, [Word]())
        XCTAssertEqual(chip8.pixels, [Bool](repeating: false, count: 64 * 32))
        XCTAssertEqual(chip8.delayTimer, 0)
        XCTAssertEqual(chip8.soundTimer, 0)
        XCTAssertEqual(chip8.keys, [Bool](repeating: false, count: 16))
        XCTAssertFalse(chip8.needsDisplay)
        
        var ram = [Byte](repeating: 0, count: 4096)
        ram.replaceSubrange(Int(0x0)..<(Int(0x0) + Int(Chip8.Characters.count)), with: Chip8.Characters)
        ram.replaceSubrange(Int(0x200)..<(Int(0x200) + Int(Chip8Tests.testROM.count)), with: Chip8Tests.testROM)
        
        XCTAssertEqual(chip8.ram, ram)
    }
    
    func testLoad() {
        var chip8 = Chip8(rom: Chip8Tests.testROM)
        chip8.load(rom: [0x00,0x00], address: 0x200)
        
        var ram = [Byte](repeating: 0, count: 4096)
        ram.replaceSubrange(Int(0x0)..<(Int(0x0) + Int(Chip8.Characters.count)), with: Chip8.Characters)
        ram.replaceSubrange(Int(0x200)..<(Int(0x200) + Int(Chip8Tests.testROM.count)), with: Chip8Tests.testROM)
        ram[0x200] = 0x00
        ram[0x201] = 0x00
        
        XCTAssertEqual(chip8.ram, ram)
    }
    
    func testReset() {
        var chip8 = Chip8(rom: Chip8Tests.testROM)
        chip8.v = [Byte](repeating: 1, count: 16)
        chip8.i = 1
        chip8.pc = 0x400
        chip8.stack = [Word](repeating: 1, count: 16)
        chip8.pixels = [Bool](repeating: true, count: 64 * 32)
        chip8.delayTimer = 100
        chip8.soundTimer = 100
        chip8.keys = [Bool](repeating: true, count: 16)
        chip8.needsDisplay = true
        
        chip8.reset(soft: true)
        
        XCTAssertEqual(chip8.v, [Byte](repeating: 0, count: 16))
        XCTAssertEqual(chip8.i, 0)
        XCTAssertEqual(chip8.pc, 0x200)
        XCTAssertEqual(chip8.stack, [Word]())
        XCTAssertEqual(chip8.pixels, [Bool](repeating: false, count: 64 * 32))
        XCTAssertEqual(chip8.delayTimer, 0)
        XCTAssertEqual(chip8.soundTimer, 0)
        XCTAssertEqual(chip8.keys, [Bool](repeating: false, count: 16))
        XCTAssertFalse(chip8.needsDisplay)
        
        var ram = [Byte](repeating: 0, count: 4096)
        ram.replaceSubrange(Int(0x0)..<(Int(0x0) + Int(Chip8.Characters.count)), with: Chip8.Characters)
        ram.replaceSubrange(Int(0x200)..<(Int(0x200) + Int(Chip8Tests.testROM.count)), with: Chip8Tests.testROM)
        
        XCTAssertEqual(chip8.ram, ram)
        
        chip8.reset()
        
        XCTAssertEqual(chip8.ram, [Byte](repeating: 0, count: 4096))
    }
    
    func testCycle() {
        var chip8 = Chip8(rom: Chip8Tests.testROM)
        
        XCTAssertEqual(chip8.pc, 0x200)
        
        try? chip8.cycle()
        
        XCTAssertEqual(chip8.pc, 0x24E)
    }
    
    func testTick() {
        var chip8 = Chip8(rom: [])
        
        try? chip8.tick()
        
        XCTAssertEqual(chip8.delayTimer, 0)
        XCTAssertEqual(chip8.soundTimer, 0)
        
        chip8.delayTimer += 1
        chip8.soundTimer += 1
        
        XCTAssertEqual(chip8.delayTimer, 1)
        XCTAssertEqual(chip8.soundTimer, 1)
        
        try? chip8.tick()
        
        XCTAssertEqual(chip8.delayTimer, 0)
        XCTAssertEqual(chip8.soundTimer, 0)
    }
    
    func testFetch() {
        let chip8 = Chip8(rom: Chip8Tests.testROM)
        
        let opcode = try? chip8.fetch(pc: 0x200)
        
        XCTAssertEqual(opcode, 0x124E)
        
        let opcode2 = try? chip8.fetch(pc: 0x24E)
        
        XCTAssertEqual(opcode2, 0x6801)
    }
    
    func testExecute() {
        // TODO: Test opcodes
    }
    
    func testDraw() {
        var chip8 = Chip8(rom: Chip8Tests.testROM)
        
        XCTAssertEqual(chip8.pixels, [Bool](repeating: false, count: 64 * 32))
        
        // Draw a "0" from the Character set at X0, Y0
        let collision = chip8.draw(x: 0x0, y: 0x0, height: 0x5)
        
        XCTAssertFalse(collision) // No collision should be detected
        XCTAssertNotEqual(chip8.pixels, [Bool](repeating: false, count: 64 * 32))
        
        let pixels: [Bool] = [
            true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false
        ]
        
        XCTAssertEqual(chip8.pixels, pixels)
        
        // Draw a "0" from the Character set at X0, Y0
        let collision2 = chip8.draw(x: 0x0, y: 0x0, height: 0x5)
        
        XCTAssertTrue(collision2) // This time it should collide
        XCTAssertEqual(chip8.pixels, [Bool](repeating: false, count: 64 * 32))
    }

    static var allTests = [
        ("testInit", testInit),
        ("testLoad", testLoad),
        ("testReset", testReset),
        ("testCycle", testCycle),
        ("testTick", testTick),
        ("testFetch", testFetch),
        ("testExecute", testExecute),
        ("testDraw", testDraw),
    ]
    
}
