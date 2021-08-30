import Foundation


extension ProcessInfo {
  var appArguments: [AppProcessArguments] {
    arguments.compactMap { AppProcessArguments(rawValue: $0) }
  }
}
