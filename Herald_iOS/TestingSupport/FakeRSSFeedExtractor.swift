import Foundation


class FakeRSSFeedExtractor: RSSFeedExtracting {
  func feeds(
    from website: URL,
    completion: @escaping (Result<FeedInfo, RSSFeedExtractingError>) -> Void
  ) {
    if website.host == "daringfireball.net" {
      let stubFeed =
        FeedInfo(
          title: "Daring Fireball",
          url: URL(string: "https://daringfireball.net/feeds/main")!
        )

      completion(.success(stubFeed))
    }
    else {
      completion(.failure(.noFeed))
    }
  }
}
