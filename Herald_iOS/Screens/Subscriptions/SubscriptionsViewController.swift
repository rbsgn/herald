import UIKit


final class SubscriptionsViewController: UIViewController {

  private let viewModel: SubscriptionsViewModel

  private weak var tableView: UITableView?
  private var subscriptionsToken: NSKeyValueObservation?

  init(viewModel: SubscriptionsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    let view = UIView(frame: .zero)
    view.backgroundColor = .systemTeal
    view.accessibilityId = .subscriptionsPage

    let tableView = makeTableView()
    layoutSubscriptions(tableView, in: view)
    tableView.dataSource = self

    self.tableView = tableView
    self.view = view
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    subscriptionsToken =
      viewModel.observe(
        \.subscriptions,
        options: [.initial, .new], changeHandler: { [unowned self] observedModel, _ in
          self.tableView?.reloadData()
        }
      )

    viewModel.beginObservingSubscriptions()
  }
}

extension SubscriptionsViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModel.subscriptions.count
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "subscription")
    if cell == nil {
      cell = UITableViewCell(style: .subtitle, reuseIdentifier: "subscription")
    }

    let subscription = viewModel.subscriptions[indexPath.row]
    cell?.textLabel?.text = subscription.title
    cell?.detailTextLabel?.text = subscription.subtitle

    return cell ?? UITableViewCell()
  }
}


private func makeTableView() -> UITableView {
  let result = UITableView(frame: .zero, style: .grouped)
  return result
}

private func layoutSubscriptions(_ tableView: UIView, in host: UIView) {
  host.addSubview(tableView)
  tableView.translatesAutoresizingMaskIntoConstraints = false

  NSLayoutConstraint.activate([
    tableView.topAnchor.constraint(equalTo: host.topAnchor),
    tableView.leadingAnchor.constraint(equalTo: host.leadingAnchor),
    tableView.bottomAnchor.constraint(equalTo: host.bottomAnchor),
    tableView.trailingAnchor.constraint(equalTo: host.trailingAnchor)
  ])
}
