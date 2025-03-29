// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser
import Foundation

@main
struct SdevCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "sdev",
        abstract: "A developer utility tool"
    )
    
    @Flag(name: .long, help: "Print a greeting message")
    var greeting = false
    
    func run() throws {
        if greeting {
            print("Hello, world!")
        } else {
            print("Run with --greeting to see a greeting message")
        }
    }
}
