import Foundation


protocol RSSFeedURLExtractorDelegate: AnyObject {
  func feedURLExtractor(
    _ extractor: RSSFeedURLExtractor,
    didExtract urls: [URL]
  )
  
  func feedURLExtractor(
    _ extractor: RSSFeedURLExtractor,
    didFailWithError error: Error
  )
}


class RSSFeedURLExtractor {
  weak var delegate: RSSFeedURLExtractorDelegate?

  func extract(from url: URL) {
    delegate?.feedURLExtractor(
      self,
      didFailWithError: makeWebSiteWithoutFeedError()
    )
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
