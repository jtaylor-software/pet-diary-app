//
//  PetDiaryWidget.swift
//  PetDiaryWidget
//
//  Created by Jeremy Taylor on 11/2/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> FactEntry {
        FactEntry(date: Date(), fact: Fact.placeholder)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (FactEntry) -> ()) {
        let entry = FactEntry(date: Date(), fact: Fact.placeholder)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let nextUpdate = Date().addingTimeInterval(86400) // one day
            
            do {
                let fact = try await HttpClient.shared.fetchFacts()
                let entry = FactEntry(date: .now, fact: fact)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}

struct FactEntry: TimelineEntry {
    let date: Date
    let fact: Fact
}

struct PetDiaryWidgetEntryView : View {
    var entry: FactEntry
    
    var body: some View {
        VStack {
            Spacer()
            Text("Random Pet Fact")
                .fontWeight(.semibold)
            Spacer()
            Text(entry.fact.fact)
                .minimumScaleFactor(0.5)
            Spacer()
            Spacer()
        }
    }
}

struct PetDiaryWidget: Widget {
    let kind: String = "PetDiaryWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PetDiaryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Random Pet Facts")
        .description("This shows a random pet fact.")
        .supportedFamilies([.systemMedium])
    }
}

struct PetDiaryWidget_Previews: PreviewProvider {
    static var previews: some View {
        PetDiaryWidgetEntryView(entry: FactEntry(date: Date(), fact: Fact.placeholder))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
