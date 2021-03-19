//
//  LinuxMain.swift
//  Chip8Kit
//
//  Created by Aaron Wright on 3/6/21.

import XCTest

import Chip8KitTests

var tests = [XCTestCaseEntry]()
tests += Chip8Tests.allTests()
tests += ArrayHelpersTests.allTests()
tests += ArraySubscriptTests.allTests()
tests += ByteHexTests.allTests()
tests += WordHexTests.allTests()
XCTMain(tests)
