//
//  XCTestManifests.swift
//  Chip8Kit
//
//  Copyright (c) 2021 A.C. Wright

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Chip8Tests.allTests),
    ]
}
#endif
