struct FeedInfoSavingError: Error { }

protocol FeedInfoSaving {
  func save(
    _ feedInfo: FeedInfo,
    completion: @escaping (Result<Void, FeedInfoSavingError>) -> Void
  )
}

class FeedInfoSaver: FeedInfoSaving {
  func save(
    _ feedInfo: FeedInfo,
    completion: @escaping (Result<Void, FeedInfoSavingError>) -> Void
  ) {
    completion(.success(Void()))
  }
}
