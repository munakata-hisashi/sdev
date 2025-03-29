import ArgumentParser
import Foundation

struct UnixTime: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "unixtime",
        abstract: "Convert between Unix timestamp and human-readable date"
    )
    
    enum ConversionMode: String, ExpressibleByArgument {
        case toDate = "to-date"
        case fromDate = "from-date"
    }
    
    @Argument(help: "Conversion mode: to-date (unix timestamp to date) or from-date (date to unix timestamp)")
    var mode: ConversionMode
    
    @Argument(help: "Value to convert: unix timestamp (for to-date) or date string (for from-date)")
    var value: String
    
    @Option(name: .shortAndLong, help: "Date format (default: yyyy-MM-dd HH:mm:ss)")
    var format: String = "yyyy-MM-dd HH:mm:ss"
    
    func run() throws {
        switch mode {
        case .toDate:
            // Convert Unix timestamp to date
            guard let timestamp = TimeInterval(value) else {
                throw ValidationError("Invalid Unix timestamp: \(value)")
            }
            
            let date = Date(timeIntervalSince1970: timestamp)
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            let dateString = formatter.string(from: date)
            
            print("\(value) → \(dateString)")
            
        case .fromDate:
            // Convert date to Unix timestamp
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            
            guard let date = formatter.date(from: value) else {
                throw ValidationError("Invalid date: \(value). Expected format: \(format)")
            }
            
            let timestamp = date.timeIntervalSince1970
            print("\(value) → \(Int(timestamp))")
        }
    }
}