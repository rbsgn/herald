import UIKit


final class ViewControllerFactory {
  func makeSubscribeToFeed() -> UIViewController {
    let extractor = RSSFeedURLExtractor()
    let result = SubscribeToFeedViewController(feedURLExtractor: extractor)

    return result
  }

  func makeSubscriptions() -> UIViewController {
    SubscriptionsViewController()
  }
}
