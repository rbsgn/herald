import Foundation


extension Notification.Name {
  static let subscriptionsDidChange =
    Notification.Name("subscriptionsDidChange")
}

protocol SubscriptionsStorage {
  func subscriptions() -> [Subscription]
  func appendSubscription(_ subscription: Subscription)
  func remove()
}


final class CodableSubscriptionsStorage: SubscriptionsStorage {

  private let path: URL

  init(path: URL) {
    self.path = path
  }

  func appendSubscription(_ subscription: Subscription) {
    var subs = subscriptions()
    subs.append(subscription)
    saveSubscriptions(subs)
    
    NotificationCenter.default.post(name: .subscriptionsDidChange, object: self)
  }

  func subscriptions() -> [Subscription] {
    guard
      let fileContent = try? Data(contentsOf: path)
    else {
      return []
    }

    let result = try! JSONDecoder().decode([Subscription].self, from: fileContent)
    return result
  }

  func remove() {
    try? FileManager.default.removeItem(at: path)
  }

  private func saveSubscriptions(_ subscriptions: [Subscription]) {
    try!
      JSONEncoder()
        .encode(subscriptions)
        .write(to: path, options: .atomicWrite)
  }
}
