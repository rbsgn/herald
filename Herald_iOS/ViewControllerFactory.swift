import UIKit


final class ViewControllerFactory {
  private let config: AppConfig

  init(config: AppConfig) {
    self.config = config
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
    SubscriptionsViewController()
  }

  func makeRSSFeedExtracor() -> RSSFeedExtracting {
    return
      config.fakeRSSParsing ?
        FakeRSSFeedExtractor() :
        RSSFeedExtractor()
  }

  private func makeRSSInfoSaver() -> FeedInfoSaving {
    FeedInfoSaver()
  }
}
