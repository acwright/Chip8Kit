//
//  Chip8Tests.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

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
        var chip8 = Chip8(rom: Chip8Tests.testROM)
        
        // 0x00E0 - Clear the screen
        let _ = chip8.draw(x: 0x0, y: 0x0, height: 0x5) // Draw a "0" from the Character set at X0, Y0
        try? chip8.execute(opcode: 0x00E0)
        XCTAssertEqual(chip8.pixels, [Bool](repeating: false, count: 64 * 32))
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        
        // 0x00EE - Returns from a subroutine.
        chip8.stack.append(0x200)
        try? chip8.execute(opcode: 0x00EE)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        
        // 0x0NNN - NOP
        try? chip8.execute(opcode: 0x0000)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)

        // 0x1NNN - Jump to address NNN.
        try? chip8.execute(opcode: 0x1300)
        XCTAssertEqual(chip8.pc, 0x0300)
        chip8.reset(soft: true)
        
        // 0x2NNN - Calls subroutine at NNN.
        try? chip8.execute(opcode: 0x2300)
        XCTAssertTrue(chip8.stack.contains(0x0200))
        XCTAssertEqual(chip8.pc, 0x0300)
        chip8.reset(soft: true)
        
        // 0x3NNN - Skips the next instruction if VX equals NN. (Usually the next instruction is a jump to skip a code block).
        chip8.v[0x0] = 0xFF
        try? chip8.execute(opcode: 0x30FF)
        XCTAssertEqual(chip8.pc, 0x0204)
        chip8.reset(soft: true)
        chip8.v[0x0] = 0xFF
        try? chip8.execute(opcode: 0x30EE)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        
        // 0x4XNN - Skips the next instruction if VX doesn't equal NN. (Usually the next instruction is a jump to skip a code block).
        chip8.v[0x0] = 0xFF
        try? chip8.execute(opcode: 0x40FF)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        chip8.v[0x0] = 0xFF
        try? chip8.execute(opcode: 0x40EE)
        XCTAssertEqual(chip8.pc, 0x0204)
        chip8.reset(soft: true)
        
        // 0x5XY0 - Skips the next instruction if VX equals VY. (Usually the next instruction is a jump to skip a code block).
        chip8.v[0x0] = 0xFF
        chip8.v[0x1] = 0xFF
        try? chip8.execute(opcode: 0x5010)
        XCTAssertEqual(chip8.pc, 0x0204)
        chip8.reset(soft: true)
        chip8.v[0x0] = 0xFF
        chip8.v[0x1] = 0xEE
        try? chip8.execute(opcode: 0x5010)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        XCTAssertThrowsError(try chip8.execute(opcode: 0x5011))
        
        // 0x6XNN - Sets VX to NN
        try? chip8.execute(opcode: 0x60FF)
        XCTAssertEqual(chip8.v[0x0], 0xFF)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        
        // 0x7XNN - Adds NN to VX. (Carry flag is not changed).
        chip8.v[0x0] = 0x11
        try? chip8.execute(opcode: 0x7011)
        XCTAssertEqual(chip8.v[0x0], 0x22)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        
        // 0x8XY0 - Sets VX to the value of VY.
        XCTAssertEqual(chip8.v[0x0], 0x00)
        chip8.v[0x1] = 0xFF
        try? chip8.execute(opcode: 0x8010)
        XCTAssertEqual(chip8.v[0x0], 0xFF)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        
        // 0x8XY1 - Sets VX to VX OR VY. (Bitwise OR operation).
        chip8.v[0x0] = 0x01
        chip8.v[0x1] = 0x10
        try? chip8.execute(opcode: 0x8011)
        XCTAssertEqual(chip8.v[0x0], 0x11)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        
        // 0x8XY2 - Sets VX to VX AND VY. (Bitwise AND operation).
        chip8.v[0x0] = 0x01
        chip8.v[0x1] = 0x10
        try? chip8.execute(opcode: 0x8012)
        XCTAssertEqual(chip8.v[0x0], 0x00)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        
        // 0x8XY3 - Sets VX to VX XOR VY.
        chip8.v[0x0] = 0x11
        chip8.v[0x1] = 0x10
        try? chip8.execute(opcode: 0x8013)
        XCTAssertEqual(chip8.v[0x0], 0x01)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        
        // 0x8XY4 - Adds VY to VX. VF is set to 1 when there's a carry, and to 0 when there isn't.
        chip8.v[0x0] = 0x01
        chip8.v[0x1] = 0x01
        try? chip8.execute(opcode: 0x8014)
        XCTAssertEqual(chip8.v[0x0], 0x02) // 1 + 1 = 2
        XCTAssertEqual(chip8.v[0xF], 0x00) // Carry not set
        chip8.reset(soft: true)
        chip8.v[0x0] = 0xFF
        chip8.v[0x1] = 0x01
        try? chip8.execute(opcode: 0x8014)
        XCTAssertEqual(chip8.v[0x0], 0x00) // 256 + 1 = 0 (carry 1)
        XCTAssertEqual(chip8.v[0xF], 0x01) // Carry set
        chip8.reset(soft: true)
        
        // 0x8XY5 - VY is subtracted from VX. VF is set to 0 when there's a borrow, and 1 when there isn't.
        chip8.v[0x0] = 0x01
        chip8.v[0x1] = 0x01
        try? chip8.execute(opcode: 0x8015)
        XCTAssertEqual(chip8.v[0x0], 0x00) // 1 - 1 = 0
        XCTAssertEqual(chip8.v[0xF], 0x01) // No borrow
        chip8.reset(soft: true)
        chip8.v[0x0] = 0x00
        chip8.v[0x1] = 0x01
        try? chip8.execute(opcode: 0x8015)
        XCTAssertEqual(chip8.v[0x0], 0xFF) // 0 - 1 = 0 (borrow 1)
        XCTAssertEqual(chip8.v[0xF], 0x00) // Borrow
        chip8.reset(soft: true)
        
        // 0x8XY6 - Stores the least significant bit of VX in VF and then shifts VX to the right by 1
        // TODO
        
        // 0x8XY7 - Sets VX to VY minus VX. VF is set to 0 when there's a borrow, and 1 when there isn't.
        chip8.v[0x0] = 0x01
        chip8.v[0x1] = 0x01
        try? chip8.execute(opcode: 0x8015)
        XCTAssertEqual(chip8.v[0x0], 0x00) // 1 - 1 = 0
        XCTAssertEqual(chip8.v[0xF], 0x01) // No borrow
        chip8.reset(soft: true)
        chip8.v[0x0] = 0x01
        chip8.v[0x1] = 0x02
        try? chip8.execute(opcode: 0x8015)
        XCTAssertEqual(chip8.v[0x0], 0xFF) // 1 - 2 = 255 (borrow 1)
        XCTAssertEqual(chip8.v[0xF], 0x00) // Borrow
        chip8.reset(soft: true)
        
        // 0x8XYE - Stores the most significant bit of VX in VF and then shifts VX to the left by 1.
        // TODO
        
        // 0x8NNF - Invalid
        XCTAssertThrowsError(try chip8.execute(opcode: 0x801F))
        
        // 0x9XY0 - Skips the next instruction if VX doesn't equal VY. (Usually the next instruction is a jump to skip a code block).
        chip8.v[0x0] = 0xFF
        chip8.v[0x1] = 0xEE
        try? chip8.execute(opcode: 0x9010)
        XCTAssertEqual(chip8.pc, 0x0204)
        chip8.reset(soft: true)
        chip8.v[0x0] = 0xFF
        chip8.v[0x1] = 0xFF
        try? chip8.execute(opcode: 0x9010)
        XCTAssertEqual(chip8.pc, 0x0202)
        chip8.reset(soft: true)
        XCTAssertThrowsError(try chip8.execute(opcode: 0x9011))
        
        // 0xANNN - Sets I to the address NNN.
        // TODO
        
        // 0xBNNN - Jumps to the address NNN plus V0.
        // TODO
        
        // 0xCXNN - Sets VX to the result of a bitwise and operation on a random number (Typically: 0 to 255) and NN.
        // TODO
        
        // 0xDXYN - Draw
        // TODO
        
        // 0xEX9E Skips the next instruction if the key stored in VX is pressed. (Usually the next instruction is a jump to skip a code block).
        // TODO
        
        // 0xEX1A Skips the next instruction if the key stored in VX isn't pressed. (Usually the next instruction is a jump to skip a code block).
        // TODO
        
        // 0xENNN - Invalid
        XCTAssertThrowsError(try chip8.execute(opcode: 0xE000))
        
        // 0xFX07 - Sets VX to the value of the delay timer.
        // TODO
        
        // 0xFX0A - A key press is awaited, and then stored in VX. (Blocking Operation. All instruction halted until next key event).
        // TODO
        
        // 0xFX15 - Sets the delay timer to VX.
        // TODO
        
        // 0xFX18 - Sets the sound timer to VX.
        // TODO
        
        // 0xFX1E - Adds VX to I. VF is not affected.
        // TODO
        
        // 0xFX29 Sets I to the location of the sprite for the character in VX. Characters 0-F (in hexadecimal) are represented by a 4x5 font.
        // TODO
        
        // 0xFX33 - Store BCD
        // TODO
        
        // 0xFX55 Stores V0 to VX (including VX) in memory starting at address I. The offset from I is increased by 1 for each value written, but I itself is left unmodified.
        // TODO
        
        // 0xFX65 Fills V0 to VX (including VX) with values from memory starting at address I. The offset from I is increased by 1 for each value written, but I itself is left unmodified.
        // TODO
        
        // 0xFNNN - Invalid
        XCTAssertThrowsError(try chip8.execute(opcode: 0xF000))
        
        // Test Program Counter Overflow
        chip8.pc = 0x0FFF
        XCTAssertThrowsError(try chip8.execute(opcode: 0x0000))
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
    
    func testIsSounding() {
        var chip8 = Chip8(rom: [])
        
        XCTAssertFalse(chip8.isSounding)
        
        chip8.soundTimer = 100
        
        XCTAssertTrue(chip8.isSounding)
    }
    
    func testDescription() {
        let chip8 = Chip8(rom: [])
        
        XCTAssertNotNil(chip8.description)
    }

    func testDebugDescription() {
        let chip8 = Chip8(rom: [])
        
        XCTAssertNotNil(chip8.debugDescription)
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
        ("testIsSounding", testIsSounding),
        ("testDescription", testDescription),
        ("testDebugDescription", testDebugDescription),
    ]
    
}
