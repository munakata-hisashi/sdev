import ArgumentParser
import Foundation

struct FileDiff: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "diff",
        abstract: "Displays the difference between two files"
    )
    
    @Argument(help: "Path to the first file")
    var file1: String
    
    @Argument(help: "Path to the second file")
    var file2: String
    
    @Flag(name: .shortAndLong, help: "Show line numbers")
    var lineNumbers: Bool = false
    
    @Flag(name: [.customShort("i"), .long], help: "Ignore case when comparing")
    var ignoreCase: Bool = false
    
    func run() throws {
        let fileManager = FileManager.default
        
        // Check if files exist
        guard fileManager.fileExists(atPath: file1) else {
            throw ValidationError("File not found: \(file1)")
        }
        
        guard fileManager.fileExists(atPath: file2) else {
            throw ValidationError("File not found: \(file2)")
        }
        
        // Read file contents
        guard let contents1 = try? String(contentsOfFile: file1) else {
            throw ValidationError("Could not read file: \(file1)")
        }
        
        guard let contents2 = try? String(contentsOfFile: file2) else {
            throw ValidationError("Could not read file: \(file2)")
        }
        
        // Split contents into lines
        let lines1 = contents1.components(separatedBy: .newlines)
        let lines2 = contents2.components(separatedBy: .newlines)
        
        // Compare files line by line
        print("Diff between \(file1) and \(file2):")
        print("-----------------------------------")
        
        let maxLines = max(lines1.count, lines2.count)
        
        for i in 0..<maxLines {
            if i < lines1.count && i < lines2.count {
                let line1 = lines1[i]
                let line2 = lines2[i]
                
                let areEqual: Bool
                if ignoreCase {
                    areEqual = line1.lowercased() == line2.lowercased()
                } else {
                    areEqual = line1 == line2
                }
                
                if !areEqual {
                    if lineNumbers {
                        print("Line \(i+1):")
                    }
                    print("< \(line1)")
                    print("> \(line2)")
                    print("")
                }
            } else if i < lines1.count {
                if lineNumbers {
                    print("Line \(i+1):")
                }
                print("< \(lines1[i])")
                print("> <EOF>")
                print("")
            } else if i < lines2.count {
                if lineNumbers {
                    print("Line \(i+1):")
                }
                print("< <EOF>")
                print("> \(lines2[i])")
                print("")
            }
        }
    }
}