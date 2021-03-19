//
//  Array+Subscript.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

import Foundation

extension Array {
    
    subscript(place: Byte) -> Element {
        get {
            return self[Int(place)]
        }
        set {
            self[Int(place)] = newValue
        }
    }
    
    subscript(place: Word) -> Element {
        get {
            return self[Int(place)]
        }
        set {
            self[Int(place)] = newValue
        }
    }
    
}
