import XCTest


struct SubscriptionsPage {
  private let app: XCUIApplication

  init(app: XCUIApplication) {
    self.app = app
  }

  var exists: Bool {
    app.otherElements[.subscriptionsPage].exists
  }
}
