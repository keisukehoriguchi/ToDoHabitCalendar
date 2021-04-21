//
//  MonthlyCalendarView.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/13.
//

import SwiftUI
import Swift

struct MonthlyCalendarView: View {
    
    private let dayOfWeekLabel = ["日", "月", "火", "水", "木", "金", "土"]
    @EnvironmentObject var calendarUseCase:CalendarUseCase
    @EnvironmentObject var eventRepository:EventRepository
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    calendarUseCase.backToToday()
                }, label: {
                    Image(systemName: "calendar")
                })
                Spacer()
                Text("\(calendarUseCase.thisYear.withoutComma)/\(calendarUseCase.thisMonth)")
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                })
            }
            .padding(.horizontal, 10)
            .padding(.top, 15)
            .padding(.bottom, 5)
            
            HStack{
                ForEach(0...dayOfWeekLabel.count-1,id: \.self){
                    Spacer()
                    Text(dayOfWeekLabel[$0])
                    Spacer()
                    Divider()
                }
            }
            .frame(height: 30)
            ForEach(calendarUseCase.numberOfWeeksArray.indices , id: \.self){ week in
                HStack{
                    DayViewOnCalendar(year: calendarUseCase.thisYear, month: calendarUseCase.thisMonth, theDay: calendarUseCase.daysArray[(0+week*7)], events: eventRepository.readEventsDay(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.daysArray[(0+week*7)]))
                    DayViewOnCalendar(year: calendarUseCase.thisYear, month: calendarUseCase.thisMonth, theDay: calendarUseCase.daysArray[(1+week*7)], events: eventRepository.readEventsDay(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.daysArray[(1+week*7)]))
                    DayViewOnCalendar(year: calendarUseCase.thisYear, month: calendarUseCase.thisMonth, theDay: calendarUseCase.daysArray[(2+week*7)], events: eventRepository.readEventsDay(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.daysArray[(2+week*7)]))
                    DayViewOnCalendar(year: calendarUseCase.thisYear, month: calendarUseCase.thisMonth, theDay: calendarUseCase.daysArray[(3+week*7)], events: eventRepository.readEventsDay(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.daysArray[(3+week*7)]))
                    DayViewOnCalendar(year: calendarUseCase.thisYear, month: calendarUseCase.thisMonth, theDay: calendarUseCase.daysArray[(4+week*7)], events: eventRepository.readEventsDay(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.daysArray[(4+week*7)]))
                    DayViewOnCalendar(year: calendarUseCase.thisYear, month: calendarUseCase.thisMonth, theDay: calendarUseCase.daysArray[(5+week*7)], events: eventRepository.readEventsDay(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.daysArray[(5+week*7)]))
                    DayViewOnCalendar(year: calendarUseCase.thisYear, month: calendarUseCase.thisMonth, theDay: calendarUseCase.daysArray[(6+week*7)], events: eventRepository.readEventsDay(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.daysArray[(6+week*7)]))
                }
            }
        }
        .gesture(DragGesture()
                    .onEnded({ value in
                        if Int(value.translation.width) > 10 {
                            calendarUseCase.monthCounter -= 1
                        } else if Int(value.translation.width) < -10 {
                            calendarUseCase.monthCounter += 1
                        }
                    })
        )
    }
}

struct MonthlyCalendarView_Previews: PreviewProvider {
    @StateObject static private var calendarUseCase = CalendarUseCase()
    @StateObject static private var eventRepository = EventRepository()
    
    static var previews: some View {
        MonthlyCalendarView().environmentObject(calendarUseCase).environmentObject(eventRepository)
    }
}
