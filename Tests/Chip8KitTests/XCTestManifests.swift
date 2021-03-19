//
//  XCTestManifests.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Chip8Tests.allTests),
        testCase(ArrayHelpersTests.allTests),
        testCase(ArraySubscriptTests.allTests),
        testCase(ByteHexTests.allTests),
        testCase(WordHexTests.allTests),
    ]
}
#endif
