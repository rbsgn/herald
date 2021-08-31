import UIKit


final class ViewControllerFactory {
  private let config: AppConfig
  private let subscriptionsStorage: SubscriptionsStorage

  init(config: AppConfig) {
    self.config = config

    let url =
      FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
        .appendingPathComponent("subscriptions.json")

    self.subscriptionsStorage = CodableSubscriptionsStorage(path: url)

    if config.removeSubscriptions {
      self.subscriptionsStorage.remove()
    }
  }

  func makeSubscribeToFeed(
    delegate: SubscribeToFeedViewControllerDelegate
  ) -> UIViewController {
    let viewModel =
      SubscribeToFeedViewModel(
        feedInfoExtractor: makeRSSFeedExtracor(),
        feedInfoSaver: makeRSSInfoSaver()
      )

    let result = SubscribeToFeedViewController(viewModel: viewModel)
    result.delegate = delegate

    return result
  }

  func makeSubscriptions() -> UIViewController {
    let viewModel = SubscriptionsViewModel(storage: subscriptionsStorage)
    return SubscriptionsViewController(viewModel: viewModel)
  }

  func makeRSSFeedExtracor() -> RSSFeedExtracting {
    return
      config.fakeRSSParsing ?
        FakeFeedInfoExtractor(stubs: [df4: df4Feed]) :
        RSSFeedExtractor()
  }

  private func makeRSSInfoSaver() -> FeedInfoSaving {
    FeedInfoSaver(storage: subscriptionsStorage)
  }
}
