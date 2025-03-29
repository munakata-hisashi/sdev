// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser
import Foundation

// Main command
struct SdevCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "sdev",
        abstract: "A developer utility tool",
        subcommands: [
            Greeting.self
        ],
        defaultSubcommand: Greeting.self
    )
}

// Entry point
SdevCommand.main()