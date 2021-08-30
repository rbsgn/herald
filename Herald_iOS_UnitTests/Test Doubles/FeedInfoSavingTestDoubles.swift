import Foundation


class DummyFeedInfoSaver: FeedInfoSaving {
  func save(_ feedInfo: FeedInfo) { }
}

class SpyingFeedInfoSaver: FeedInfoSaving {
  private(set) var savedInfo: FeedInfo?

  func save(_ feedInfo: FeedInfo) {
    self.savedInfo = feedInfo
  }
}
