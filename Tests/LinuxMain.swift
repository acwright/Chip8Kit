//
//  LinuxMain.swift
//  Chip8Kit
//
//  Copyright (c) 2021 A.C. Wright

import XCTest

import Chip8KitTests

var tests = [XCTestCaseEntry]()
tests += Chip8Tests.allTests()
XCTMain(tests)
