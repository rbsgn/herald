import Foundation

struct Feed {
  let title: String
  let url: URL
}

enum RSSFeedExtractingError: Error {
  case noFeed
}

protocol RSSFeedExtracting {
  func feeds(
    from website: URL,
    completion: @escaping (Result<Feed, RSSFeedExtractingError>) -> Void
  )
}
