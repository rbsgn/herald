import XCTest

/// Очень напоминает SubscribeFeedViewModel, это программное взаимодействие
/// с экраном подписки на фид
struct SubscribeFeedPage {

  var canSubscribe: Bool { subscribeButton.isEnabled }
  var feedAddress: String { feedAddressTextField.value as? String ?? "" }

  private let app: XCUIApplication

  private var subscribeButton: XCUIElement { app.buttons.firstMatch }
  private var feedAddressTextField: XCUIElement { app.textFields.firstMatch }

  init(app: XCUIApplication) {
    self.app = app
  }

  func subscribe() {
    subscribeButton.tap()
  }

  func typeURL(_ text: String) {
    feedAddressTextField.tap()
    feedAddressTextField.typeText(text)
  }

  func errorMessagePresent(_ message: String) -> Bool {
    app.staticTexts[message].exists
  }
}

