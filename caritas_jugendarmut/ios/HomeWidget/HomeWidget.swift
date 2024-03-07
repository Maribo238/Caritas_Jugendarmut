import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> CounterEntry {
    CounterEntry(date: Date(), count: 0)
  }

  func getSnapshot(in context: Context, completion: @escaping (CounterEntry) -> Void) {
    // Get the UserDefaults for the AppGroup
    let prefs = UserDefaults(suiteName: "group.com.example.caritasJugendarmut")
    // Load the current Count
    let entry = CounterEntry(date: Date(), count: prefs?.integer(forKey: "amount") ?? 0)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
    getSnapshot(in: context) { (entry) in
      let timeline = Timeline(entries: [entry], policy: .atEnd)
      completion(timeline)
    }
  }
}

struct CounterEntry: TimelineEntry {
  let date: Date
  let count: Int
}

struct MoneyButton: View {
    let amount: Int

    var body: some View {
        Button(intent: BackgroundIntent(method: "\(amount)")) {
            Text("\(amount) €")
        }
    }
}

struct FlutterIOSWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
         VStack {
            Text("Total Amount:")
            Text("\(entry.count) €")
            
            // Add your buttons here
            HStack {
                MoneyButton(amount: 1)
                MoneyButton(amount: 2)
                MoneyButton(amount: 5)
            }
        }
    }
}

struct HomeWidget: Widget {
  let kind: String = "HomeWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      if #available(iOS 17.0, *) {
        FlutterIOSWidgetEntryView(entry: entry)
          .containerBackground(.fill.tertiary, for: .widget)
      } else {
        FlutterIOSWidgetEntryView(entry: entry)
          .padding()
          .background()
      }
    }
    .configurationDisplayName("Home Widget")
    .description("Easy way to track your outgoings.")
  }
}