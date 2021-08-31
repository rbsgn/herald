import XCTest


/// Очень напоминает SubscribeFeedViewModel, это программное взаимодействие
/// с экраном подписки на фид
struct SubscribeFeedPage {

  var canSubscribe: Bool { subscribeButton.isEnabled }
  var feedAddress: String { feedAddressTextField.value as? String ?? "" }

  private let view: XCUIElement

  private var subscribeButton: XCUIElement { view.buttons[.subscribeButton] }
  private var feedAddressTextField: XCUIElement { view.textFields[.feedAddressTextField] }

  var exists: Bool {
    view.exists
  }

  init(app: XCUIApplication) {
    self.view = app.otherElements[.subscribeFeedScreen]
  }

  func subscribe() {
    subscribeButton.tap()
  }

  func typeURL(_ text: String) {
    feedAddressTextField.tap()
    feedAddressTextField.typeText(text)
  }

  func errorMessagePresent(_ message: String) -> Bool {
    view.staticTexts[message].exists
  }
}

