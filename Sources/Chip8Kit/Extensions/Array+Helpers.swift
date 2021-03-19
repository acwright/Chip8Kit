//
//  Array+Helpers.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

import Foundation

extension Array where Element == Byte {
    
    func hexValues() -> [String] {
        self.map { (value) -> String in
            value.hexValue
        }
    }
    
    func hexString() -> String {
        hexValues().joined(separator: ",")
    }
    
}

extension Array where Element == Word {
    
    func hexValues() -> [String] {
        self.map { (value) -> String in
            value.hexValue
        }
    }
    
    func hexString() -> String {
        hexValues().joined(separator: ",")
    }
    
}
