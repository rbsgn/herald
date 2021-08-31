import XCTest

struct SubscriptionElement: Equatable {
  let title: String
  let subtitle: String
}

struct SubscriptionsPage {
  private let app: XCUIApplication

  init(app: XCUIApplication) {
    self.app = app
  }

  func subscriptions() -> [SubscriptionElement] {
    let cells = app.tables.firstMatch.cells
    var result: [SubscriptionElement] = []

    for i in 0 ..< cells.count {
      let element = cells.element(boundBy: i)
      let subscription =
        SubscriptionElement(
          title: element.staticTexts[.subscriptionTitle].label,
          subtitle: element.staticTexts[.subscriptionSubtitle].label
        )

      result.append(subscription)
    }

    return result
  }
}
