import ArgumentParser
import Foundation

struct Greeting: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "greeting",
        abstract: "Displays greeting messages"
    )
    
    func run() throws {
        print("Hello, world!")
    }
}