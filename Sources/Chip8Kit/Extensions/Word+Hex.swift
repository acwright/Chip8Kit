//
//  Word+Hex.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

import Foundation

extension Word {
    
    var hexValue: String {
        String(format:"0x%04X", self)
    }
    
}
