//
//  Byte+Hex.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

import Foundation

extension Byte {
    
    var hexValue: String {
        String(format:"0x%02X", self)
    }
    
}
