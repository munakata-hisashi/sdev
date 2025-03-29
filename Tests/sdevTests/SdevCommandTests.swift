import XCTest
import class Foundation.Bundle
import Foundation
@testable import ArgumentParser

final class SdevCommandTests: XCTestCase {
    func testHelp() throws {
        let process = try runSdev(arguments: ["--help"])
        XCTAssertEqual(process.terminationStatus, 0)
        
        let output = try getOutput(from: process)
        XCTAssertTrue(output.contains("OVERVIEW:"))
        XCTAssertTrue(output.contains("A developer utility tool"))
    }
    
    func testGreetingCommand() throws {
        let process = try runSdev(arguments: ["greeting"])
        XCTAssertEqual(process.terminationStatus, 0)
        
        let output = try getOutput(from: process)
        XCTAssertEqual(output.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), "Hello, world!")
    }
    
    func testNoArguments() throws {
        let process = try runSdev(arguments: [])
        XCTAssertEqual(process.terminationStatus, 0)
        
        let output = try getOutput(from: process)
        XCTAssertEqual(output.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), "Hello, world!")
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