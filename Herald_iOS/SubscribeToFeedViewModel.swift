import Foundation

class SubscribeToFeedViewModel {
  private(set) var userInput = ""
  private(set) var canSubscribe = false
  private(set) var errorMessage = ""
  private(set) var errorMessageHidden = true
  private(set) var subscribedSuccessfully = false

  private let feedInfoExtractor: RSSFeedExtracting
  private let feedInfoSaver: FeedInfoSaving

  init(
    feedInfoExtractor: RSSFeedExtracting,
    feedInfoSaver: FeedInfoSaving
  ) {
    self.feedInfoExtractor = feedInfoExtractor
    self.feedInfoSaver = feedInfoSaver
  }

  func typeText(_ text: String) {
    canSubscribe = URL(string: text) != nil
    userInput = text
  }

  func subscribe() {
    guard let url = URL(string: userInput) else { return }

    feedInfoExtractor.feeds(from: url) { [weak self] result in
      self?.handleFeedInfoExtractionResult(result)
    }
  }

  private func handleFeedInfoExtractionResult(
    _ result: Result<FeedInfo, RSSFeedExtractingError>
  ) {
    switch result {
    case .success(let feedInfo):
      handleSuccessfulExtraction(feedInfo)
    case .failure(let error):
      handleFailedExtraction(error)
    }
  }

  private func handleSuccessfulExtraction(_ feedInfo: FeedInfo) {
    feedInfoSaver.save(feedInfo) { [weak self] result in
      self?.handleFeedInfoSavingResult(result)
    }
  }

  private func handleFailedExtraction(_ error: RSSFeedExtractingError) {
    switch error {
    case .noFeed:
      errorMessage = "У сайта нет RSS потока"
    }

    errorMessageHidden = false
  }

  private func handleFeedInfoSavingResult(
    _ result: Result<Void, FeedInfoSavingError>
  ) {
    switch result {
    case .success:
      subscribedSuccessfully = true

    case .failure:
      errorMessage = "Невозможно сохранить подписку"
      errorMessageHidden = false
    }
  }
}
