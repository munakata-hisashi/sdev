# sdev

A developer utility tool built with Swift.

## Features

- Simple CLI interface using Swift ArgumentParser
- Currently supports a basic greeting command

## Installation

```bash
# Build the project
swift build -c release

# Install to a location in your PATH
cp .build/release/sdev /usr/local/bin/
```

## Usage

```bash
# Show help
sdev --help

# Display greeting message
sdev --greeting
```

## Development

### Requirements

- Swift 6.0 or later

### Build Commands

- Build: `swift build`
- Release build: `swift build -c release`
- Run: `./.build/debug/sdev [arguments]` or `./.build/release/sdev [arguments]`
- Clean: `swift package clean`
- Update dependencies: `swift package update`
- Generate Xcode project: `swift package generate-xcodeproj`

### Test Commands

- Run all tests: `swift test`
- Run single test: `swift test --filter <TestName>`