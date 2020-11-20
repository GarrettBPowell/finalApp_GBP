//
//  ContentView.swift
//  finalApp_GBP
//
//  Created by Garrett Powell on 11/12/20.
//

import SwiftUI
import UIKit
import CoreLocation


//date formatters
fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

//generates correct number of dates in month
fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}

//DAY VIEW
struct DayView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var date: Date
    
  var dateFormatter: DateFormatter {
    
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
  }

    
  var body: some View {
    VStack {
        Text(self.dateFormatter.string(from: self.date)).font(.title).padding()
        
        ScrollView {
            dayView(items: dateData[0].specificContent)
        }
        Button("Close") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
  }
}

//WEEK VIEW
struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let content: (Date) -> DateView

    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }

    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                HStack {
                    
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
            }
        }
        
    }
}

//MONTH VIEW
struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let month: Date
    let showHeader: Bool
    let content: (Date) -> DateView

    init(
        month: Date,
        showHeader: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.content = content
        self.showHeader = showHeader
    }

    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
            else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }

    private var header: some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
        return Text(formatter.string(from: month))
            .font(.title)
            .padding()
    }

    var body: some View {
        VStack {
            if showHeader {
                header
                    .foregroundColor(Color.white)
            }

            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
        
    }
}

//CALENDAR VIEW
struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    

    let interval: DateInterval
    let content: (Date) -> DateView

    init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(months, id: \.self) { month in
                        MonthView(month: month, content: self.content)
                    }
                }
            }
        }
    }
}

let dateData: [DateModel] = load("dateData.json")
struct RootView: View {
    @Environment(\.calendar) var calendar
    @State var showingDayView = false
    @State var components = DateComponents()
    @State var desiredDate = Date()
   
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    private var month: DateInterval {
        calendar.dateInterval(of: .day, for: Date())!
    }
    
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
                        NavigationView {
                VStack {
                CalendarView(interval: year) { date in
                    //keeps size the same
                    Text("30")
                        .hidden()
                        .padding(8)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .padding(.vertical, 4)
                        
                        .overlay(
                        VStack{
                          Text(String(self.calendar.component(.day, from: date)))
                            .foregroundColor(Color.white)
                        }.onTapGesture {
                                self.showingDayView.toggle()
                                
                            self.components.month = self.calendar.component(.month, from: date)
                            self.components.day = self.calendar.component(.day, from: date)
                            self.components.year = self.calendar.component(.year, from: date)
                         
                            }.sheet(isPresented: self.$showingDayView) {
                              DayView(date: self.calendar.date(from: self.components) ?? Date())
                            }
                    )}
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}


