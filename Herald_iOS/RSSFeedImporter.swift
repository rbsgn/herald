import Foundation

protocol RSSFeedImporterDelegate: AnyObject {
  func feedImporter(
    _ importer: RSSFeedImporter,
    didFailWithError error: Error
  )
}

class RSSFeedImporter {
  weak var delegate: RSSFeedImporterDelegate?

  func `import`(from url: URL) {
    delegate?.feedImporter(self, didFailWithError: makeWebSiteWithoutFeedError())
  }

  private func makeWebSiteWithoutFeedError() -> Error {
    NSError(
      domain: "com.roman-busygin.herald",
      code: 1,
      userInfo: [
        NSLocalizedDescriptionKey: "У сайта нет RSS-потока"
      ]
    )
  }
}
