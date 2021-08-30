import UIKit


final class ViewControllerFactory {
  func makeSubscribeFeedViewController() -> UIViewController {
    let importer = RSSFeedImporter()
    let result = SubscribeFeedViewController(feedImporter: importer)

    return result
  }
}
