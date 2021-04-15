//
//  SampleCalendar.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/15.
//

import SwiftUI
import UIKit

struct SampleCalendar: View {
    
    var numberOfWeeks: Int = 0
    var daysArray: [String] = ["1","2"]
    var startDayOfWeek: Int = 0
    
    private let date = DateItems.ThisMonth.Request()
    @State private var thisYear: Int = 0
    @State private var thisMonth: Int = 0
    @State private var today: Int = 0

    private let dayOfWeekLabel = ["日", "月", "火", "水", "木", "金", "土"]
    private var monthCounter = 0
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    getToday()
                }, label: {
                    Text("Today")
                })
                Spacer()
                Text("\(thisYear)/\(thisMonth)")
                    .onAppear(perform: {
                        getToday()
                    })
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "magnifyingglass")
                })
            }.padding(.horizontal, 10.0)
            HStack{
                ForEach(0...dayOfWeekLabel.count-1,id: \.self){
                    if $0 == 0 {
                        Spacer()
                    }
                    Text(dayOfWeekLabel[$0])
                    Spacer()
                }
            }.onAppear(perform: {
               updateDaysArray()
            })
            ForEach(0..<(numberOfWeeks)){ week in
                HStack{
                    if let theDay:Int = ((0+week*7)-startDayOfWeek), theDay>=0 {
                        Text(daysArray[theDay])
                    }
                    if let theDay:Int = ((1+week*7)-startDayOfWeek), theDay>=0 {
                        Text(daysArray[theDay])
                    }
                    if let theDay:Int = ((2+week*7)-startDayOfWeek), theDay>=0 {
                        Text(daysArray[theDay])
                    }
                    if let theDay:Int = ((3+week*7)-startDayOfWeek), theDay>=0 {
                        Text(daysArray[theDay])
                    }
                    if let theDay:Int = ((4+week*7)-startDayOfWeek), theDay>=0 {
                        Text(daysArray[theDay])
                    }
                    if let theDay:Int = ((5+week*7)-startDayOfWeek), theDay>=0 {
                        Text(daysArray[theDay])
                    }
                    if let theDay:Int = ((6+week*7)-startDayOfWeek), theDay>=0 {
                        Text(daysArray[theDay])
                    }
                }
            }
        }
    }
}

extension SampleCalendar {
    private func getToday() {
        thisYear = date.year
        thisMonth = date.month
        today = date.day
    }
    
    private mutating func updateDaysArray(){
        daysArray = CalendarUseCase().dateManager(year: thisYear, month: thisMonth)
    }
}

struct SampleCalendar_Previews: PreviewProvider {
    static var previews: some View {
        SampleCalendar()
    }
}
