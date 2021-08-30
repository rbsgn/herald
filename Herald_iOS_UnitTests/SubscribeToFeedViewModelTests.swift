import XCTest

class SubscribeToFeedViewModelTests: XCTestCase {

  var subject: SubscribeToFeedViewModel!

  private func makeSubject(
    extractor: RSSFeedExtracting = DummyFeedInfoExtractor(),
    saver: FeedInfoSaving = DummyFeedInfoSaver()
  ) -> SubscribeToFeedViewModel {
    SubscribeToFeedViewModel(feedInfoExtractor: extractor, feedInfoSaver: saver)
  }

  func test_Initially_HasNoUserInput_And_CanNotSubscribe() {
    subject = makeSubject()

    XCTAssertEqual(subject.userInput, "")
    XCTAssertEqual(subject.canSubscribe, false)
    XCTAssertEqual(subject.errorMessage, "")
    XCTAssertEqual(subject.errorMessageHidden, true)
    XCTAssertEqual(subject.subscribedSuccessfully, false)
  }

  func test_WhenUserTypesNonURL_ThenCanNotSubscribe() {
    subject = makeSubject()
    subject.typeText("не сайт")
    XCTAssertEqual(subject.canSubscribe, false)
  }

  func test_WhenUserTypesURL_ThenCanSubscribe() {
    subject = makeSubject()
    subject.typeText("https://dodobrands.io/")
    XCTAssertEqual(subject.canSubscribe, true)
  }

  func test_WhenUserTypesURL_AndSubscribes_ThenUsesRSSFeedExtractor() throws {
    let extractor = SpyingFeedInfoExtractor()
    subject = makeSubject(extractor: extractor)

    subject.typeText("https://dodobrands.io/")
    subject.subscribe()

    let website = try XCTUnwrap(extractor.website)
    XCTAssertEqual(website, URL(string: "https://dodobrands.io/")!)
  }

  func test_WhenUserTypesSiteAddressWithoutRSSFeed_AndAttemptsSubscribe_ThenShowsErrorMessage() throws {
    let extractor = FailingFeedInfoExtractor(error: .noFeed)
    subject = makeSubject(extractor: extractor)

    subject.typeText("https://apple.com/")
    subject.subscribe()

    let message = try XCTUnwrap(subject.errorMessage)
    XCTAssertGreaterThan(message.count, 0)
    XCTAssertFalse(subject.errorMessageHidden)
  }

  func test_GivenRSSFeedInfoWasExtracted_ThenSavesIt_AndNotifiesDone() throws {
    let info = FeedInfo(title: "foo", url: URL(string: "https://example.org/")!)
    let extractor = SucceedingFeedInfoExtractor(feedInfo: info)
    let saver = FakeFeedInfoSaver()

    subject = makeSubject(extractor: extractor, saver: saver)

    subject.typeText("https://some-website.com/")
    subject.subscribe()

    let savedInfo = try XCTUnwrap(saver.savedInfo)
    XCTAssertEqual(savedInfo, info)
    XCTAssertEqual(subject.subscribedSuccessfully, true)
  }

  func test_GivenRSSFeedInfoWasExtracted_ButNotSaved_ThenShowsErrorMessage() throws {
    let info = FeedInfo(title: "foo", url: URL(string: "https://example.org/")!)
    let extractor = SucceedingFeedInfoExtractor(feedInfo: info)
    let saver = FailingFeedInfoSaver()

    subject = makeSubject(extractor: extractor, saver: saver)

    subject.typeText("https://some-website.com/")
    subject.subscribe()

    let message = try XCTUnwrap(subject.errorMessage)
    XCTAssertGreaterThan(message.count, 0)
    XCTAssertFalse(subject.errorMessageHidden)
  }
}
