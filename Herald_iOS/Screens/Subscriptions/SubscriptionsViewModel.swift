import Foundation

final class SubscriptionViewModel: NSObject {
  let title: String
  let subtitle: String

  init(title: String, subtitle: String) {
    self.title = title
    self.subtitle = subtitle
  }
}

final class SubscriptionsViewModel: NSObject {
  @objc dynamic private(set) var subscriptions: [SubscriptionViewModel]

  private let storage: SubscriptionsStorage

  init(storage: SubscriptionsStorage) {
    self.storage = storage
    self.subscriptions =
      storage.subscriptions().map {
        SubscriptionViewModel(title: $0.title, subtitle: $0.url.absoluteString)
      }
  }

  func beginObservingSubscriptions() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(subscriptionsDidChange(_:)),
      name: .subscriptionsDidChange,
      object: storage
    )
  }

  func endObservingSubscriptions() {
    NotificationCenter.default.removeObserver(
      self,
      name: .subscriptionsDidChange,
      object: storage
    )
  }

  @objc private func subscriptionsDidChange(_ notification: Notification) {
    self.subscriptions =
      storage.subscriptions().map {
        SubscriptionViewModel(title: $0.title, subtitle: $0.url.absoluteString)
      }
  }
}
