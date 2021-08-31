struct AppConfig {
  let fakeRSSParsing: Bool

  init(processArguments: [String]) {
    fakeRSSParsing =
      processArguments.contains(AppProcessArguments.fakeRSSParsing.rawValue)
  }
}
