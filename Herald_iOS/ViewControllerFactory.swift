import UIKit


final class ViewControllerFactory {
  private let config: AppConfig

  init(config: AppConfig) {
    self.config = config
  }

  func makeSubscribeToFeed() -> UIViewController {
    let extractor = makeRSSFeedExtracor()
    let result = SubscribeToFeedViewController(feedExtractor: extractor)

    return result
  }

  func makeSubscriptions() -> UIViewController {
    SubscriptionsViewController()
  }

  func makeRSSFeedExtracor() -> RSSFeedExtracting {
    return
      config.fakeRSSParsing ?
        FakeRSSFeedExtractor() :
        RSSFeedExtractor()
  }
}
