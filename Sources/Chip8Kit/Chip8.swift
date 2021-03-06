//
//  Chip8.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

import Foundation

public typealias Byte = UInt8
public typealias Word = UInt16
public typealias Opcode = Word

/// Chip8 Emulator
public struct Chip8 {
    
    /// Chip8 character set
    private static let Characters: [Byte] = [
        0xF0, 0x90, 0x90, 0x90, 0xF0, // 0
        0x20, 0x60, 0x20, 0x20, 0x70, // 1
        0xF0, 0x10, 0xF0, 0x80, 0xF0, // 2
        0xF0, 0x10, 0xF0, 0x10, 0xF0, // 3
        0x90, 0x90, 0xF0, 0x10, 0x10, // 4
        0xF0, 0x80, 0xF0, 0x10, 0xF0, // 5
        0xF0, 0x80, 0xF0, 0x90, 0xF0, // 6
        0xF0, 0x10, 0x20, 0x40, 0x40, // 7
        0xF0, 0x90, 0xF0, 0x90, 0xF0, // 8
        0xF0, 0x90, 0xF0, 0x10, 0xF0, // 9
        0xF0, 0x90, 0xF0, 0x90, 0x90, // A
        0xE0, 0x90, 0xE0, 0x90, 0xE0, // B
        0xF0, 0x80, 0x80, 0x80, 0xF0, // C
        0xE0, 0x90, 0x90, 0x90, 0xE0, // D
        0xF0, 0x80, 0xF0, 0x80, 0xF0, // E
        0xF0, 0x80, 0xF0, 0x80, 0x80  // F
    ]
    
    /// Errors
    enum Chip8Error: Error {
        case MemoryOutOfRange
        case InvalidOpcode(opcode: Opcode)
    }
    
    /// General purpose registers V0-VF
    public var v: [Byte] = [Byte](repeating: 0, count: 16)
    
    /// Index register
    public var i: Word = 0x0
    
    /// Program counter
    public var pc: Word = 0x200
    
    /// RAM
    public var ram: [Byte] = [Byte](repeating: 0, count: 4096)
    
    /// Stack
    public var stack: [Word] = [Word]()
    
    /// Pixels
    public var pixels: [Byte] = [Byte](repeating: 0, count: 64 * 32)
    
    /// Timers
    public var delayTimer: Byte = 0x0
    public var soundTimer: Byte = 0x0
    
    /// Keyboard
    public var keys: Word = 0x0
    
    /// Helpers
    public var isSounding: Bool { return soundTimer > 0 }
    public var needsDisplay: Bool = false
    
    /// Initialize the system and load ROM data
    ///
    /// - Parameter rom: The ROM data to load
    public init(rom: [Byte]) {
        // Perform a hard reset
        reset()
        
        // Load the character set at address 0x0
        load(rom: Chip8.Characters, address: 0x0)
        
        // Load the ROM into RAM at address 0x200
        load(rom: rom)
    }
    
    /// Reset the system
    ///
    /// - Parameter rom: The ROM data to load
    /// - Parameter address: The address in RAM at which to load the ROM data
    public mutating func load(rom: [Byte], address: Word = 0x200) {
        ram.replaceSubrange(Int(address)..<(Int(address) + Int(rom.count)), with: rom)
    }
    
    /// Reset the system
    ///
    /// - Parameter hard: Perform a hard reset (Erase the RAM)
    public mutating func reset(hard: Bool = true) {
        v = [Byte](repeating: 0, count: 16)
        i = 0x0
        pc = 0x200
        stack = [Word]()
        pixels = [Byte](repeating: 0, count: 64 * 32)
        delayTimer = 0x0
        soundTimer = 0x0
        keys = 0x0
        needsDisplay = false
        
        // Perform a hard reset by erasing RAM
        if hard {
            ram = [Byte](repeating: 0, count: 4096)
        }
    }
    
    /// Emulate one CPU cycle by fetching and executing next opcode
    public mutating func cycle() throws {
        // Fetch Opcode
        let opcode = try fetch(pc: pc)
        
        // Execute Opcode
        try execute(opcode: opcode)
    }
    
    /// Emulate one timer tick by decrementing timers
    public mutating func tick() throws {
        if delayTimer < 0 { delayTimer -= 1 }
        if soundTimer < 0 { soundTimer -= 1 }
    }
    
    /// Fetch the next opcode
    ///
    /// - Parameter pc: The program counter
    internal func fetch(pc: Word) throws -> Opcode {
        // Ensure program counter will not overflow RAM range
        // We need two bytes and max ram count is 4096 so use < 4095
        guard pc < 4095 else { throw Chip8Error.MemoryOutOfRange }
        
        return Word(ram[pc]) << 8 | Word(ram[pc + 1])
    }
    
    /// Decode and execute the next opcode
    ///
    /// - Parameter opcode: The opcode to execute
    internal mutating func execute(opcode: Opcode) throws {
        switch opcode & 0xF000 {
        case 0x0000:
            switch opcode & 0x000F {
            case 0x0000:
                // 0x00E0 Cleers the screen.
                pixels = [Byte](repeating: 0, count: 64 * 32)
                pc += 2
            case 0x000E:
                // 0x00EE Return from subroutine.
                pc = stack.removeLast()
                pc += 2
            default:
                // NOP (Calls machine code routine (RCA 1802 for COSMAC VIP) at address NNN).
                break
            }
        case 0x1000:
            // 0x1NNN Jump to address NNN.
            pc = opcode & 0x0FFF
        case 0x2000:
            // 0x2NNN Calls subroutine at NNN.
            stack.append(pc)
            pc = opcode & 0x0FFF
        case 0x3000:
            // 0x3XNN Skips the next instruction if VX equals NN. (Usually the next instruction is a jump to skip a code block).
            pc = v[(opcode & 0x0F00) >> 8] == opcode & 0x00FF ? pc + 4 : pc + 2
        case 0x4000:
            // 0x4XNN Skips the next instruction if VX doesn't equal NN. (Usually the next instruction is a jump to skip a code block).
            pc = v[(opcode & 0x0F00) >> 8] != opcode & 0x00FF ? pc + 4 : pc + 2
            break
        case 0x5000:
            switch opcode & 0x000F {
            case 0x0000:
                // 0x5XY0 Skips the next instruction if VX equals VY. (Usually the next instruction is a jump to skip a code block).
                pc = v[(opcode & 0x0F00) >> 8] == v[(opcode & 0x00F0) >> 4] ? pc + 4 : pc + 2
                break
            default:
                throw Chip8Error.InvalidOpcode(opcode: opcode)
            }
        case 0x6000:
            // 0x6XNN Sets VX to NN
            v[(opcode & 0x0F00) >> 8] = UInt8(opcode & 0x00FF)
            pc += 2
        case 0x7000:
            // 0x7XNN Adds NN to VX. (Carry flag is not changed).
            v[(opcode & 0x0F00) >> 8] = v[(opcode & 0x0F00) >> 8] &+ UInt8(opcode & 0x00FF)
            pc += 2
        case 0x8000:
            switch opcode & 0x000F {
            case 0x0000:
                // 0x8XY0 Sets VX to the value of VY.
                v[(opcode & 0x0F00) >> 8] = v[(opcode & 0x00F0) >> 4]
                pc += 2
            case 0x0001:
                // 0x8XY1 Sets VX to VX OR VY. (Bitwise OR operation).
                v[(opcode & 0x0F00) >> 8] |= v[(opcode & 0x00F0) >> 4]
                pc += 2
            case 0x0002:
                // 0x8XY2 Sets VX to VX AND VY. (Bitwise AND operation).
                v[(opcode & 0x0F00) >> 8] &= v[(opcode & 0x00F0) >> 4]
                pc += 2
            case 0x0003:
                // 0x8XY3 Sets VX to VX XOR VY.
                v[(opcode & 0x0F00) >> 8] ^= v[(opcode & 0x00F0) >> 4]
                pc += 2
            case 0x0004:
                // 0x8XY4 Adds VY to VX. VF is set to 1 when there's a carry, and to 0 when there isn't.
                let overflow = v[(opcode & 0x0F00) >> 8].addingReportingOverflow(v[(opcode & 0x00F0) >> 4]).1
                v[0xF] = overflow ? 0x1 : 0x0
                pc += 2
            case 0x0005:
                // 0x8XY5 VY is subtracted from VX. VF is set to 0 when there's a borrow, and 1 when there isn't.
                let overflow = v[(opcode & 0x0F00) >> 8].subtractingReportingOverflow(v[(opcode & 0x00F0) >> 4]).1
                v[0xF] = overflow ? 0x0 : 0x1
                pc += 2
            case 0x0006:
                // 0x8XY6 Stores the least significant bit of VX in VF and then shifts VX to the right by 1
                v[0xF] = v[(opcode & 0x0F00) >> 8] & 0x1
                v[(opcode & 0x0F00) >> 8] = v[(opcode & 0x0F00) >> 8] >> 1
                pc += 2
            case 0x0007:
                // 0x8XY7 Sets VX to VY minus VX. VF is set to 0 when there's a borrow, and 1 when there isn't.
                let result = v[(opcode & 0x00F0) >> 4].subtractingReportingOverflow(v[(opcode & 0x0F00) >> 8])
                v[(opcode & 0x0F00) >> 8] = result.0
                v[0xF] = result.1 ? 0x0 : 0x1
                pc += 2
            case 0x000E:
                // 0x8XYE Stores the most significant bit of VX in VF and then shifts VX to the left by 1.
                v[0xF] = v[(opcode & 0x0F00) >> 8] & 0b10000000
                v[(opcode & 0x0F00) >> 8] = v[(opcode & 0x0F00) >> 8] << 1
                pc += 2
            default:
                throw Chip8Error.InvalidOpcode(opcode: opcode)
            }
        case 0x9000:
            switch opcode & 0x000F {
            case 0x0000:
                // 0x9XY0 Skips the next instruction if VX doesn't equal VY. (Usually the next instruction is a jump to skip a code block).
                pc = v[(opcode & 0x0F00) >> 8] != v[(opcode & 0x00F0) >> 4] ? pc + 4 : pc + 2
            default:
                throw Chip8Error.InvalidOpcode(opcode: opcode)
            }
        case 0xA000:
            // 0xANNN Sets I to the address NNN.
            i = opcode & 0x0FFF
            pc += 2
        case 0xB000:
            // 0xBNNN Jumps to the address NNN plus V0.
            pc = (opcode & 0x0FFF) + Word(v[0])
        case 0xC000:
            // 0xCXNN Sets VX to the result of a bitwise and operation on a random number (Typically: 0 to 255) and NN.
            v[(opcode & 0x0F00) >> 8] = Byte(opcode & 0x00FF) & Byte(arc4random_uniform(255))
            pc += 2
        case 0xD000:
            // 0xDXYN
            // Draws a sprite at coordinate (VX, VY) that has a width of 8 pixels and a height of N+1 pixels.
            // Each row of 8 pixels is read as bit-coded starting from memory location I; I value doesn’t change after the execution of this instruction.
            // As described above, VF is set to 1 if any screen pixels are flipped from set to unset when the sprite is drawn, and to 0 if that doesn’t happen
            break
        case 0xE000:
            switch opcode & 0x00FF {
            case 0x009E:
                // 0xEX9E Skips the next instruction if the key stored in VX is pressed. (Usually the next instruction is a jump to skip a code block).
                break
            case 0x001A:
                // 0xEX1A Skips the next instruction if the key stored in VX isn't pressed. (Usually the next instruction is a jump to skip a code block).
                break
            default:
                throw Chip8Error.InvalidOpcode(opcode: opcode)
            }
        case 0xF000:
            switch opcode & 0x00FF {
            case 0x0007:
                // 0xFX07 Sets VX to the value of the delay timer.
                break
            case 0x000A:
                // 0xFX0A A key press is awaited, and then stored in VX. (Blocking Operation. All instruction halted until next key event).
                break
            case 0x0015:
                // 0xFX15 Sets the delay timer to VX.
                break
            case 0x0018:
                // 0xFX18 Sets the sound timer to VX.
                break
            case 0x001E:
                // 0xFX1E Adds VX to I. VF is not affected.
                break
            case 0x0029:
                // 0xFX29 Sets I to the location of the sprite for the character in VX. Characters 0-F (in hexadecimal) are represented by a 4x5 font.
                break
            case 0x0033:
                // 0xFX33
                // Stores the binary-coded decimal representation of VX, with the most significant of three digits at the address in I, the middle digit at I plus 1, and the least significant digit at I plus 2.
                // (In other words, take the decimal representation of VX, place the hundreds digit in memory at location in I, the tens digit at location I+1, and the ones digit at location I+2.)
                break
            case 0x0055:
                // 0xFX55 Stores V0 to VX (including VX) in memory starting at address I. The offset from I is increased by 1 for each value written, but I itself is left unmodified
                break
            case 0x0065:
                // 0xFX65 Fills V0 to VX (including VX) with values from memory starting at address I. The offset from I is increased by 1 for each value written, but I itself is left unmodified.
                break
            default:
                throw Chip8Error.InvalidOpcode(opcode: opcode)
            }
        default:
            throw Chip8Error.InvalidOpcode(opcode: opcode)
        }
    }
    
}
