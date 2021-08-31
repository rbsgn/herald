import XCTest

struct SubscriptionsPage {
  private let app: XCUIApplication

  init(app: XCUIApplication) {
    self.app = app
  }

  func containsSubscription(title: String, subtitle: String) -> Bool {
    let givenSubscriptionPredicate =
      NSPredicate { evaluated, _ in
        let element = evaluated as! XCUIElement

        return
          element.staticTexts[title].exists &&
          element.staticTexts[subtitle].exists
      }

    return
      app
        .tables
        .firstMatch
        .cells
        .element(matching: givenSubscriptionPredicate)
        .exists
  }
}
