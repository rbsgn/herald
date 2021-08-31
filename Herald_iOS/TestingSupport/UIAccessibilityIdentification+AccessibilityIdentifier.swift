import UIKit

/// Упрощает настройку `accessibilityIdentifier` в коде приложения, убирая boilerplate вида
/// `view.accessibilityIdentifier = AccessibilityIdentifier.someCase.rawValue`
/// Протоколу `UIAccessibilityIdentification` конформят все элементы интерфейса,
/// поддерживающие `accessibilityIdentifier`.
extension UIAccessibilityIdentification {
  var accessibilityId: AccessibilityIdentifier? {
    get {
      if let id = accessibilityIdentifier {
        return AccessibilityIdentifier.init(rawValue: id)
      }

      return nil
    }
    set {
      accessibilityIdentifier = newValue?.rawValue
    }
  }
}
