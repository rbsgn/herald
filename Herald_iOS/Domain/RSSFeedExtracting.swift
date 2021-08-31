import Foundation

enum RSSFeedExtractingError: Error {
  case noFeed
}

protocol RSSFeedExtracting {
  func feeds(
    from website: URL,
    completion: @escaping (Result<FeedInfo, RSSFeedExtractingError>) -> Void
  )
}
