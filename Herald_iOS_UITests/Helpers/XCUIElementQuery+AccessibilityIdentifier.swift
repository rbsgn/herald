import XCTest

/// Сокращает boilerplate код при поиске элементов по нашему идентификатору
extension XCUIElementQuery {
  subscript(id: AccessibilityIdentifier) -> XCUIElement {
    get {
      matching(identifier: id.rawValue).firstMatch
    }
  }
}
