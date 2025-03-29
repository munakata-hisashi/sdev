import XCTest
import class Foundation.Bundle
import Foundation

final class UnixTimeTests: XCTestCase {
    func testUnixTimeToDate() throws {
        let process = try TestHelpers.runSdev(arguments: ["unixtime", "to-date", "1609459200"])
        XCTAssertEqual(process.terminationStatus, 0)
        
        let output = try TestHelpers.getOutput(from: process)
        XCTAssertTrue(output.contains("1609459200 → 2021-01-01 00:00:00"), "Expected timestamp 1609459200 to convert to 2021-01-01 00:00:00")
    }
    
    func testUnixTimeFromDate() throws {
        let process = try TestHelpers.runSdev(arguments: ["unixtime", "from-date", "2021-01-01 00:00:00"])
        XCTAssertEqual(process.terminationStatus, 0)
        
        let output = try TestHelpers.getOutput(from: process)
        XCTAssertTrue(output.contains("2021-01-01 00:00:00 → 1609459200"), "Expected date 2021-01-01 00:00:00 to convert to timestamp 1609459200")
    }
    
    func testUnixTimeWithCustomFormat() throws {
        let process = try TestHelpers.runSdev(arguments: ["unixtime", "to-date", "1609459200", "--format", "yyyy/MM/dd"])
        XCTAssertEqual(process.terminationStatus, 0)
        
        let output = try TestHelpers.getOutput(from: process)
        XCTAssertTrue(output.contains("1609459200 → 2021/01/01"), "Expected timestamp 1609459200 to convert to 2021/01/01")
    }
}