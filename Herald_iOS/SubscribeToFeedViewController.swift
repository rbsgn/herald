import UIKit


protocol SubscribeToFeedViewControllerDelegate: AnyObject {
  func subscribeFeedViewControllerDidFinish(
    _ controller: SubscribeToFeedViewController
  )
}

final class SubscribeToFeedViewController: UIViewController {

  weak var delegate: SubscribeToFeedViewControllerDelegate?

  private let viewModel: SubscribeToFeedViewModel

  private weak var textField: UITextField?
  private weak var subscribeButton: UIControl?
  private weak var errorLabel: UILabel?

  private var isSubscribeEnabledToken: NSKeyValueObservation?
  private var isErrorMessageHiddenToken: NSKeyValueObservation?
  private var successfullySubscribedToken: NSKeyValueObservation?

  init(viewModel: SubscribeToFeedViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  deinit {
    isSubscribeEnabledToken?.invalidate()
    isErrorMessageHiddenToken?.invalidate()
    successfullySubscribedToken?.invalidate()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  override func loadView() {
    let view = UIView(frame: .zero)
    view.backgroundColor = .systemOrange
    view.accessibilityId = .subscribeFeedScreen

    let textField = makeTextField()
    layout(textField, in: view)
    textField.addTarget(
      self,
      action: #selector(textFieldDidChange(_:)),
      for: .editingChanged
    )

    let button = makeAddFeedButton()
    layoutSubscribeButton(button, below: textField, in: view)
    button.addTarget(
      self,
      action: #selector(subscribeButtonTapped(_:)),
      for: .touchUpInside
    )

    let errorLabel = makeErrorLabel()
    layoutErrorLabel(errorLabel, below: button, in: view)

    self.errorLabel = errorLabel
    self.textField = textField
    self.subscribeButton = button
    self.view = view
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    bindUIToViewModel()
  }

  private func bindUIToViewModel() {
    isSubscribeEnabledToken =
      viewModel.observe(
        \.canSubscribe,
        options: [.initial, .new],
        changeHandler: { [unowned self] observedViewModel, change in
          self.subscribeButton?.isEnabled = observedViewModel.canSubscribe
        }
      )

    isErrorMessageHiddenToken =
      viewModel.observe(
        \.errorMessageHidden,
        options: [.initial, .new],
        changeHandler: { [unowned self] observedViewModel, change in
          self.errorLabel?.text = observedViewModel.errorMessage
          self.errorLabel?.isHidden = observedViewModel.errorMessageHidden
        }
      )

    successfullySubscribedToken =
      viewModel.observe(
        \.errorMessageHidden,
        options: [.initial, .new],
        changeHandler: { [unowned self] observedViewModel, change in
          if observedViewModel.subscribedSuccessfully {
            self.delegate?.subscribeFeedViewControllerDidFinish(self)
          }
        }
      )
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    errorLabel?.preferredMaxLayoutWidth = view.bounds.width - 8.0 * 2
  }

  @objc private func textFieldDidChange(_ sender: UITextField) {
    viewModel.typeText(sender.text ?? "")
  }

  @objc private func subscribeButtonTapped(_ sender: UIButton) {
    viewModel.subscribe()
  }

  private func handleExtractedFeed(_ feed: FeedInfo) {
    delegate?.subscribeFeedViewControllerDidFinish(self)
  }
}


private func makeTextField() -> UITextField {
  let result = UITextField(frame: .zero)
  result.borderStyle = .roundedRect
  result.accessibilityId = .feedAddressTextField
  return result
}

private func layout(_ textField: UIView, in host: UIView) {
  host.addSubview(textField)
  textField.translatesAutoresizingMaskIntoConstraints = false

  let safeArea = host.safeAreaLayoutGuide

  NSLayoutConstraint.activate([
    textField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
    textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
    textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8)
  ])
}

private func makeAddFeedButton() -> UIControl {
  let result = UIButton(type: .system)
  result.setTitle("Subscribe", for: .normal)
  result.accessibilityId = .subscribeButton
  return result
}

private func layoutSubscribeButton(
  _ button: UIView,
  below textField: UIView,
  in host: UIView
) {
  host.addSubview(button)
  button.translatesAutoresizingMaskIntoConstraints = false

  NSLayoutConstraint.activate([
    button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
    button.centerXAnchor.constraint(equalTo: textField.centerXAnchor)
  ])
}

private func makeErrorLabel() -> UILabel {
  let result = UILabel(frame: .zero)
  result.isHidden = true
  result.numberOfLines = 0
  result.accessibilityId = .subscriptionErrorLabel
  return result
}

private func layoutErrorLabel(
  _ errorLabel: UIView,
  below aboveError: UIView,
  in host: UIView
) {
  host.addSubview(errorLabel)
  errorLabel.translatesAutoresizingMaskIntoConstraints = false

  NSLayoutConstraint.activate([
    errorLabel.topAnchor.constraint(equalTo: aboveError.bottomAnchor, constant: 8),
    errorLabel.leadingAnchor.constraint(equalTo: aboveError.leadingAnchor),
    errorLabel.trailingAnchor.constraint(equalTo: aboveError.trailingAnchor)
  ])
}
