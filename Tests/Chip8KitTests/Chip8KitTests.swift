import XCTest
@testable import Chip8Kit

final class Chip8KitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Chip8Kit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
