import XCTest

/// Содержит тесты, сгруппированные по какому-то признаку:
///   * Тесты на класс
///   * Тесты на какой-то экран приложения
class Herald_iOS_UITests: XCTestCase {

  /// Вызывается единственный раз перед запуском тестов в сценарии.
  /// Может использоваться, например, для начального состояния *всех* тестов
  override class func setUp() { }

  /// Вызывается единственный раз после выполнения последнего теста в сценарии.
  /// Может использоваться для подчистки того, что сделали тесты
  override class func tearDown() { }

  /// Вызывается перед запуском каждого теста. Используется для создания объектов,
  /// необходимых для тестирования или приведение приложения в нужное состояние
  override func setUpWithError() throws {

    /// Флаг, отвечающий за продолжение работы тестового сценария при возникновения ошибки.
    /// Обычно, ставится в `false`.
    continueAfterFailure = false
  }

  /// Вызывается сразу после завершения каждого теста. Как и class-вариант, используется для
  /// подчистки за тестом (удаление файлов, отписывание от уведомлений и т.п.)
  override func tearDownWithError() throws {

  }

  func test_CanNotSubscribe_ToNonURL() throws {
    let app = XCUIApplication()
    app.launch()

    let text = try XCTUnwrap(app.textFields.firstMatch.value as? String)
    XCTAssertEqual(text, "")
    XCTAssertFalse(app.buttons.firstMatch.isEnabled)

    app.textFields.firstMatch.tap()
    app.textFields.firstMatch.typeText("не сайт")

    XCTAssertFalse(app.buttons["Subscribe"].isEnabled)
  }
}
