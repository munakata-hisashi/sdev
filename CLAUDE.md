# CLAUDE.md for sdev

## Build Commands
- Build: `swift build`
- Release build: `swift build -c release`
- Run: `./.build/debug/sdev [arguments]` or `./.build/release/sdev [arguments]`
- Clean: `swift package clean`
- Update dependencies: `swift package update`
- Generate Xcode project: `swift package generate-xcodeproj`

## Test Commands
- Run all tests: `swift test`
- Run single test: `swift test --filter <TestName>`

## Code Style Guidelines
- Use 4 spaces for indentation, not tabs
- Type names: UpperCamelCase (e.g., `SdevCommand`)
- Variable/property names: lowerCamelCase (e.g., `greeting`)
- Constants: prefer `let` over `var` when possible
- Organize imports alphabetically (e.g., `ArgumentParser` then `Foundation`)
- Place opening braces on the same line as declarations
- Add documentation comments for public APIs
- Error handling: use Swift's `try`/`catch` and `throws` mechanisms
- Use Swift's strong type system - avoid `Any` and implicit unwrapping
- Follow ArgumentParser convention for CLI command design

---

# CLAUDE.md（日本語訳）

## ビルドコマンド
- ビルド: `swift build`
- リリースビルド: `swift build -c release`
- 実行: `./.build/debug/sdev [引数]` または `./.build/release/sdev [引数]`
- クリーン: `swift package clean`
- 依存関係の更新: `swift package update`
- Xcodeプロジェクト生成: `swift package generate-xcodeproj`

## テストコマンド
- すべてのテスト実行: `swift test`
- 単一テスト実行: `swift test --filter <テスト名>`

## コードスタイルガイドライン
- インデントにはタブではなく4スペースを使用
- 型名: アッパーキャメルケース（例: `SdevCommand`）
- 変数/プロパティ名: ローワーキャメルケース（例: `greeting`）
- 定数: 可能な限り `var` より `let` を優先
- インポート文はアルファベット順に整理（例: `ArgumentParser` の後に `Foundation`）
- 開き括弧は宣言と同じ行に配置
- 公開APIにはドキュメンテーションコメントを追加
- エラー処理: Swiftの `try`/`catch` と `throws` メカニズムを使用
- Swiftの強力な型システムを活用 - `Any` や暗黙的アンラップの使用を避ける
- CLIコマンド設計にはArgumentParserの規約に従う