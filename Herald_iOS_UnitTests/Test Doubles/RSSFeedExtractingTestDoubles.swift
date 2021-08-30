import Foundation


class DummyFeedInfoExtractor: RSSFeedExtracting {
  func feeds(
    from website: URL,
    completion: @escaping (Result<FeedInfo, RSSFeedExtractingError>) -> Void
  ) {

  }
}

class SucceedingFeedInfoExtractor: RSSFeedExtracting {
  private let feedInfo: FeedInfo

  init(feedInfo: FeedInfo) {
    self.feedInfo = feedInfo
  }

  func feeds(
    from website: URL,
    completion: @escaping (Result<FeedInfo, RSSFeedExtractingError>) -> Void
  ) {
    completion(.success(feedInfo))
  }
}

class FailingFeedInfoExtractor: RSSFeedExtracting {
  private let error: RSSFeedExtractingError

  init(error: RSSFeedExtractingError) {
    self.error = error
  }

  func feeds(
    from website: URL,
    completion: @escaping (Result<FeedInfo, RSSFeedExtractingError>) -> Void
  ) {
    completion(.failure(error))
  }
}

class SpyingFeedInfoExtractor: RSSFeedExtracting {
  private(set) var website: URL?

  func feeds(
    from website: URL,
    completion: @escaping (Result<FeedInfo, RSSFeedExtractingError>) -> Void
  ) {
    self.website = website
  }
}
