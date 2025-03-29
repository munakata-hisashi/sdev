import XCTest
import class Foundation.Bundle
import Foundation

final class UnixTimeTests: XCTestCase {
    func testUnixTimeToDate() throws {
        let process = try runSdev(arguments: ["unixtime", "to-date", "1609459200"])
        XCTAssertEqual(process.terminationStatus, 0)
        
        let output = try getOutput(from: process)
        XCTAssertTrue(output.contains("1609459200 → 2021-01-01 00:00:00"), "Expected timestamp 1609459200 to convert to 2021-01-01 00:00:00")
    }
    
    func testUnixTimeFromDate() throws {
        let process = try runSdev(arguments: ["unixtime", "from-date", "2021-01-01 00:00:00"])
        XCTAssertEqual(process.terminationStatus, 0)
        
        let output = try getOutput(from: process)
        XCTAssertTrue(output.contains("2021-01-01 00:00:00 → 1609459200"), "Expected date 2021-01-01 00:00:00 to convert to timestamp 1609459200")
    }
    
    func testUnixTimeWithCustomFormat() throws {
        let process = try runSdev(arguments: ["unixtime", "to-date", "1609459200", "--format", "yyyy/MM/dd"])
        XCTAssertEqual(process.terminationStatus, 0)
        
        let output = try getOutput(from: process)
        XCTAssertTrue(output.contains("1609459200 → 2021/01/01"), "Expected timestamp 1609459200 to convert to 2021/01/01")
    }
    
    // Helper method to run the executable
    private func runSdev(arguments: [String] = []) throws -> Process {
        // Find the executable path
        let sdevBinary = productsDirectory.appendingPathComponent("sdev")
        
        let process = Process()
        process.executableURL = sdevBinary
        process.arguments = arguments
        
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        
        try process.run()
        process.waitUntilExit()
        
        return process
    }
    
    // Helper to get output from process
    private func getOutput(from process: Process) throws -> String {
        let outputPipe = process.standardOutput as! Pipe
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: outputData, encoding: .utf8) ?? ""
    }
    
    /// Returns path to the built products directory.
    private var productsDirectory: URL {
        #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
        #else
        return Bundle.main.bundleURL
        #endif
    }
}