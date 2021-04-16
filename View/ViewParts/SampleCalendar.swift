//
//  SampleCalendar.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/15.
//

import SwiftUI
import UIKit

struct SampleCalendar: View {
    private let dayOfWeekLabel = ["日", "月", "火", "水", "木", "金", "土"]
    @EnvironmentObject var calendarUseCase:CalendarUseCase
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    
                }, label: {
                    Text("Today")
                })
                Spacer()
                Text("\(calendarUseCase.thisYear)/\(calendarUseCase.thisMonth)")
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
            }
            ForEach(0..<(calendarUseCase.numberOfWeeks)){ week in
                HStack{
                    DayViewOnCalendar(theDay: calendarUseCase.daysArray[(0+week*7)])
                    DayViewOnCalendar(theDay: calendarUseCase.daysArray[(1+week*7)])
                    DayViewOnCalendar(theDay: calendarUseCase.daysArray[(2+week*7)])
                    DayViewOnCalendar(theDay: calendarUseCase.daysArray[(3+week*7)])
                    DayViewOnCalendar(theDay: calendarUseCase.daysArray[(4+week*7)])
                    DayViewOnCalendar(theDay: calendarUseCase.daysArray[(5+week*7)])
                    DayViewOnCalendar(theDay: calendarUseCase.daysArray[(6+week*7)])
                }
            }
        }
    }
}

struct SampleCalendar_Previews: PreviewProvider {
    @StateObject static private var calendarUseCase = CalendarUseCase()
    
    static var previews: some View {
        SampleCalendar().environmentObject(calendarUseCase)
    }
}
