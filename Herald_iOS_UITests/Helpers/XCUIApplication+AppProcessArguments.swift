import XCTest


extension XCUIApplication {
  func setProcessArguments(_ arguments: [AppProcessArguments]) {
    launchArguments = arguments.map { $0.rawValue }
  }
}
