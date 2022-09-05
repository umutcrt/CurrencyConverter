//
//  CurWidget.swift
//  CurWidget
//
//  Created by Umut Cörüt on 11.08.2022.
//
import Foundation
import WidgetKit
import SwiftUI
import Firebase

var rates = [String : Double]()

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), rates: [:])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let date = Date()
        downloadFunc(completion: {rates in
            let entry = SimpleEntry(date: date, rates: rates)
            completion(entry)
        })
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let date = Date()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 20, to: date)!
        downloadFunc(completion: {rates in
            let entry = SimpleEntry(date: date, rates: rates)
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        })
    }
}
struct SimpleEntry: TimelineEntry {
    let date: Date
    var rates: [String : Double]?
}

struct CurWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(.purple)
                .blendMode(.sourceAtop)
            Text("$   ¥   €   ฿")
                .foregroundColor(.green)
                .blur(radius: 4)
                .opacity(0.6)
                .font(.system(size: 64))
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .bottom, endPoint: .top)
                .opacity(0.55)
                .blur(radius: 10)
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.black)
                            .opacity(0.40)
                            .frame(width: 150.0, height: 55.0)
                        VStack {
                            Text(curView1)
                                .foregroundColor(.orange)
                                .font(.system(size: 28).monospacedDigit().smallCaps().weight(.regular))
                            Text(curView12)
                                .foregroundColor(.white).opacity(0.8)
                                .font(.system(size: 16).monospacedDigit().smallCaps().weight(.regular))
                        }
                    }
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.black)
                            .opacity(0.40)
                            .frame(width: 150.0, height: 55.0)
                        VStack {
                            Text(curView2)
                                .foregroundColor(.orange)
                                .font(.system(size: 28).monospacedDigit().smallCaps().weight(.regular))
                            Text(curView22)
                                .foregroundColor(.white).opacity(0.8)
                                .font(.system(size: 16).monospacedDigit().smallCaps().weight(.regular))
                        }
                    }
                    Spacer()
                    Spacer()
                }
                HStack {
                    Spacer()
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.black)
                            .opacity(0.40)
                            .frame(width: 150.0, height: 55.0)
                        VStack {
                            Text(curView3)
                                .foregroundColor(.orange)
                                .font(.system(size: 28).monospacedDigit().smallCaps().weight(.regular))
                            Text(curView32)
                                .foregroundColor(.white).opacity(0.8)
                                .font(.system(size: 16).monospacedDigit().smallCaps().weight(.regular))
                        }
                    }
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.black)
                            .opacity(0.40)
                            .frame(width: 150.0, height: 55.0)
                        VStack {
                            Text(curView4)
                                .foregroundColor(.orange)
                                .font(.system(size: 28).monospacedDigit().smallCaps().weight(.regular))

                            Text(curView42)
                                .foregroundColor(.white).opacity(0.8)
                                .font(.system(size: 16).monospacedDigit().smallCaps().weight(.regular))

                        }
                        .font(.system(size: 20).monospacedDigit().smallCaps().weight(.regular))
                    }
                    Spacer()
                    Spacer()
                }
                Spacer()
            }
            .multilineTextAlignment(.center)
            .scaledToFit()
            .lineSpacing(4)
        }
    }
}

@main
struct CurWidget: Widget {
    let kind: String = "CurWidget"
    init() {
           FirebaseApp.configure()
       }
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CurWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("currency widget")
        .description("This is a currency widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct CurWidget_Previews: PreviewProvider {
    static var previews: some View {
        CurWidgetEntryView(entry: SimpleEntry(date: Date(), rates: [:]))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
