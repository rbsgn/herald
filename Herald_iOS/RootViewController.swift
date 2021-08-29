import UIKit


class RootViewController: UIViewController {
  override func loadView() {
    let view = UIView(frame: .zero)
    view.backgroundColor = .systemOrange

    let textField = makeTextField()
    layout(textField, in: view)

    let button = makeAddFeedButton()
    layout(button, below: textField, in: view)

    self.view = view
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
