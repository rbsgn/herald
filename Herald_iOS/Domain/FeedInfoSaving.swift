struct FeedInfoSavingError: Error { }

protocol FeedInfoSaving {
  func save(
    _ feedInfo: FeedInfo,
    completion: @escaping (Result<Void, FeedInfoSavingError>) -> Void
  )
}

class FeedInfoSaver: FeedInfoSaving {

  private let storage: SubscriptionsStorage

  init(storage: SubscriptionsStorage) {
    self.storage = storage
  }

  func save(
    _ feedInfo: FeedInfo,
    completion: @escaping (Result<Void, FeedInfoSavingError>) -> Void
  ) {
    let subscription = Subscription(title: feedInfo.title, url: feedInfo.url)
    storage.appendSubscription(subscription)
    completion(.success(Void()))
  }
}
