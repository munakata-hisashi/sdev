import XCTest
import class Foundation.Bundle
import Foundation

class TestHelpers {
    /// Run the sdev executable with the given arguments
    static func runSdev(arguments: [String] = []) throws -> Process {
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
    
    /// Get the output from a process
    static func getOutput(from process: Process) throws -> String {
        let outputPipe = process.standardOutput as! Pipe
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: outputData, encoding: .utf8) ?? ""
    }
    
    /// Returns path to the built products directory.
    static var productsDirectory: URL {
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