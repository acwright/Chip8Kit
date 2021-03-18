//
//  File.swift
//  
//
//  Created by Aaron Wright on 3/18/21.
//

import Foundation

extension Array where Element == Byte {
    
    func hexValues() -> [String] {
        self.map { (value) -> String in
            String(format:"%02X", value)
        }
    }
    
    func hexString() -> String {
        hexValues().joined(separator: ",")
    }
    
}

extension Array where Element == Word {
    
    func hexValues() -> [String] {
        self.map { (value) -> String in
            String(format:"%02X", value)
        }
    }
    
    func hexString() -> String {
        hexValues().joined(separator: ",")
    }
    
}
