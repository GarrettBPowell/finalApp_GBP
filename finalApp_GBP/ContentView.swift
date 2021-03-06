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

func matchDate(dateString: String) -> DateModel
{
    for item in dateData
    {
        if(item.actualDate == dateString) {
            return item
        }
    }
    return dateData[0]
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

    //need to pass day View the date cooresponding to the one clicked
  var body: some View {
    VStack {
        Text(self.dateFormatter.string(from: self.date)).font(.title).padding()
        NavigationView{
            VStack{
                ScrollView {
                    dayView(items: (matchDate(dateString: self.dateFormatter.string(from: self.date)).specificContent), model: (matchDate(dateString: self.dateFormatter.string(from: self.date))), theDate: self.dateFormatter.string(from: self.date))
                }
                Spacer()
                NavigationLink(destination: addDate(dateClicked: self.dateFormatter.string(from: self.date))) {
                    Text("Add Event")
                        .foregroundColor(.blue)
                }
            }
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



func getColor(date: String) -> Color {
    
    for item in dateData {
        if(item.actualDate == date){
            switch(item.specificContent.count)
            {
            case 0: return .blue
            case 1: return .yellow
            case 2: return .yellow
            case 3: return .orange
            case 4: return .orange
            case 5: return .orange
            default: return .red
            }
            
        }
    }
    return .blue
}

var dateData: [DateModel] = load()

func checker() {
    print("\n")
    print(dateData[0].actualDate)
    print("\n)")
}

func updateDateData ()
{
    dateData = load()
    checker()
}
struct RootView: View {
    @Environment(\.calendar) var calendar
    @State var showingDayView = false
    @State var outside = true
    @State var components = DateComponents()
    @State var desiredDate = Date()


    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    private var month: DateInterval {
        calendar.dateInterval(of: .day, for: Date())!
    }
    var body: some View {
        ZStack
        {
            CalendarView(interval: year) { date in
            //keeps size the same
            Text("30")
                .hidden()
                .padding(8)
                .background(getColor(date: "\(self.calendar.component(.month, from: date))\("/")\(self.calendar.component(.day, from: date))\("/")\(self.calendar.component(.year, from: date)%100)" ))
                .clipShape(Circle())
                .padding(.vertical, 4)
                
                .overlay(
                VStack
                {
                  Text(String(self.calendar.component(.day, from: date)))
                    .foregroundColor(Color.white)
                }.onTapGesture {
                    if(outside){
                        self.showingDayView.toggle()}
                        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}


