import UIKit


protocol SubscribeToFeedViewControllerDelegate: AnyObject {
  func subscribeFeedViewControllerDidFinish(
    _ controller: SubscribeToFeedViewController
  )
}


final class SubscribeToFeedViewController: UIViewController {

  weak var delegate: SubscribeToFeedViewControllerDelegate?

  private let feedURLExtractor: RSSFeedURLExtractor

  private weak var textField: UITextField?
  private weak var subscribeButton: UIControl?
  private weak var errorLabel: UILabel?

  init(feedURLExtractor: RSSFeedURLExtractor) {
    self.feedURLExtractor = feedURLExtractor

    super.init(nibName: nil, bundle: nil)

    self.feedURLExtractor.delegate = self
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

    updateSubscribeStatus(userInput: textField?.text)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    errorLabel?.preferredMaxLayoutWidth = view.bounds.width - 8.0 * 2
  }

  @objc private func textFieldDidChange(_ sender: UITextField) {
    updateSubscribeStatus(userInput: sender.text)
  }

  private func updateSubscribeStatus(userInput: String?) {
    if let userInput = userInput {
      let possiblyURL = URL(string: userInput)
      subscribeButton?.isEnabled = possiblyURL != nil
    }
    else {
      subscribeButton?.isEnabled = false
    }
  }

  @objc private func subscribeButtonTapped(_ sender: UIButton) {
    guard
      let userInput = textField?.text,
      let url = URL(string: userInput)
    else {
      return
    }

    feedURLExtractor.extract(from: url)
  }
}


extension SubscribeToFeedViewController: RSSFeedURLExtractorDelegate {

  func feedURLExtractor(
    _ extractor: RSSFeedURLExtractor,
    didExtract urls: [URL]
  ) {
    delegate?.subscribeFeedViewControllerDidFinish(self)
  }

  func feedURLExtractor(
    _ extractor: RSSFeedURLExtractor,
    didFailWithError error: Error
  ) {
    errorLabel?.text = error.localizedDescription
    errorLabel?.isHidden = false
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
