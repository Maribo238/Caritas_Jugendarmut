import AppIntents
import Foundation
import home_widget

@available(iOS 17, *)
public struct BackgroundIntent: AppIntent {
  static public var title: LocalizedStringResource = "Increment Counter"

  @Parameter(title: "Method")
  var method: String

  public init() {
    method = "increment"
  }

  public init(method: String) {
    self.method = method
  }

  public func perform() async throws -> some IntentResult {
    await HomeWidgetBackgroundWorker.run(
      url: URL(string: "homeWidgetCounter://\(method)"),
      appGroup: "group.com.example.caritasJugendarmut")

    return .result()
  }
}
