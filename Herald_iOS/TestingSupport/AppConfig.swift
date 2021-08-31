struct AppConfig {
  let fakeRSSParsing: Bool
  let removeSubscriptions: Bool

  init(processArguments: [String]) {
    fakeRSSParsing =
      processArguments.contains(AppProcessArguments.fakeRSSParsing.rawValue)

    removeSubscriptions =
      processArguments.contains(AppProcessArguments.removeSubscriptions.rawValue)
  }
}
