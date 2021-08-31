import UIKit


final class SubscriptionsViewController: UIViewController {
  override func loadView() {
    self.view = UIView(frame: .zero)
    self.view.backgroundColor = .systemTeal
    self.view.accessibilityId = .subscriptionsPage
  }
}
