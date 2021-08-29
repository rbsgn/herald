import UIKit


class RootViewController: UIViewController {

  private weak var textField: UITextField?
  private weak var subscribeButton: UIControl?

  override func loadView() {
    let view = UIView(frame: .zero)
    view.backgroundColor = .systemOrange

    let textField = makeTextField()
    layout(textField, in: view)
    textField.addTarget(
      self,
      action: #selector(textFieldDidChange(_:)),
      for: .editingChanged
    )

    let button = makeAddFeedButton()
    layout(button, below: textField, in: view)

    self.textField = textField
    self.subscribeButton = button
    self.view = view
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    updateSubscribeStatus(userInput: textField?.text)
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
}


private func makeTextField() -> UITextField {
  let result = UITextField(frame: .zero)
  result.borderStyle = .roundedRect
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
  return result
}

private func layout(
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
