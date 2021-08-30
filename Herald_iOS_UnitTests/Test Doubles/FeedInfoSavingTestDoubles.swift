import Foundation


class DummyFeedInfoSaver: FeedInfoSaving {
  func save(
    _ feedInfo: FeedInfo,
    completion: @escaping (Result<Void, FeedInfoSavingError>) -> Void
  ) {

  }
}

class FakeFeedInfoSaver: FeedInfoSaving {
  private(set) var savedInfo: FeedInfo?

  func save(
    _ feedInfo: FeedInfo,
    completion: @escaping (Result<Void, FeedInfoSavingError>) -> Void
  ) {
    self.savedInfo = feedInfo
    completion(.success(Void()))
  }
}

class FailingFeedInfoSaver: FeedInfoSaving {
  func save(
    _ feedInfo: FeedInfo,
    completion: @escaping (Result<Void, FeedInfoSavingError>) -> Void
  ) {
    completion(.failure(FeedInfoSavingError()))
  }
}
