import XCTest


class Herald_iOS_UITests: XCTestCase {

  var app: XCUIApplication!
  var subscribeFeedPage: SubscribeFeedPage!

  override func setUpWithError() throws {
    continueAfterFailure = false

    app = XCUIApplication()
    app.launch()

    subscribeFeedPage = SubscribeFeedPage(app: app)
  }

  func test_CanNotSubscribe_ToNonURL() throws {
    XCTAssertEqual(subscribeFeedPage.feedAddress, "")
    XCTAssertFalse(subscribeFeedPage.canSubscribe)

    subscribeFeedPage.typeURL("не сайт")
    XCTAssertFalse(subscribeFeedPage.canSubscribe)
  }

  // Знаем наперёд, что у сайта нет фида. Поэтому либо подделываем ответ,
  // либо сами создаём такой сайт
  func test_CanNotSubscribe_WhenURLHasNotRSSFeed() {
    subscribeFeedPage.typeURL("https://apple.com/")
    subscribeFeedPage.subscribe()

    XCTAssertTrue(subscribeFeedPage.errorMessagePresent("У сайта нет RSS-потока"))
  }
}
