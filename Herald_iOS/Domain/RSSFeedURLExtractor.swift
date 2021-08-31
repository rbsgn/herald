import Foundation

class RSSFeedExtractor: RSSFeedExtracting {
  func feeds(
    from website: URL,
    completion: @escaping (Result<FeedInfo, RSSFeedExtractingError>) -> Void
  ) {
    completion(.success(df4Feed))
  }
}
