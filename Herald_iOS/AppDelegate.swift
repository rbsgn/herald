import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)

    let config = AppConfig(processArguments: ProcessInfo.processInfo.arguments)
    let viewControllerFactory = ViewControllerFactory(config: config)

    let subscriptions = viewControllerFactory.makeSubscriptions()
    let subscribeToFeed = viewControllerFactory.makeSubscribeToFeed()

    window.rootViewController = subscriptions
    window.makeKeyAndVisible()

    subscriptions.present(subscribeToFeed, animated: false)

    self.window = window

    return true
  }
}

