//
//  MainScheduleView.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/17.
//

import SwiftUI
import EventKit

struct MainScheduleView: View {
    
    @State var terms:Int
    
    @State var selectedTermsFrom = "4/17 0:00"
    @State var selectedTermsTo = "4/17 23:59"
    @State var eventString:[String] = ["13:00 美容院行く"," 18:00 家に帰る"]
    @State var events:[EKEvent] = []
    @State var sameDay:String = ""
    
    @EnvironmentObject var eventRepository:EventRepository
    @EnvironmentObject var calendarUseCase:CalendarUseCase
    //    @EnvironmentObject var calendarUseCase:CalendarUseCase
    
    var body: some View {
        VStack{
            Picker(selection: $terms, label: Text("Picker"), content: {
                Text("Day").tag(1)
                Text("Week").tag(2)
                Text("Month").tag(3)
            })
            .padding(.all, 5)
            .pickerStyle(SegmentedPickerStyle())
            .onReceive([self.terms].publisher.first(), perform: { (value) in
                if value == 1 {
                    events = eventRepository.readEventsDay(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.selectedDay)
                } else if value == 2 {
                    events = eventRepository.readEventsWeek(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.selectedDay)
                } else if value == 3 {
                    events = eventRepository.readEventsMonth(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.selectedDay)
                }
            })
            List{
                Section(header:
                            HStack{
                                Spacer()
                                Text("\(calendarUseCase.thisYear.withoutComma)/\(calendarUseCase.thisMonth)/\(calendarUseCase.selectedDay) 0:00")
                                Text(" ~ ")
                                if terms == 1 {
                                    Text("\(calendarUseCase.thisYear.withoutComma)/\(calendarUseCase.thisMonth)/\(calendarUseCase.selectedDay) 23:59")
                                } else if terms == 2 {
                                    Text("\(calendarUseCase.thisYear.withoutComma)/\(calendarUseCase.thisMonth)/\(calendarUseCase.selectedDay+6) 23:59")
                                } else {
                                    Text("\(calendarUseCase.thisYear.withoutComma)/\(calendarUseCase.thisMonth)/\(calendarUseCase.today+30) 23:59")
                                }
                                Spacer()
                            }
                            .padding(.all, 10)
                ) { ForEach(events, id: \.self){ event in
                        HStack{
                            if sameDay != event.startDate.toString {
                                Text(event.startDate.toString)
                                    .foregroundColor(.blue)
//                                sameDay = event.startDate.toString
                            }
                            
                            if event.availability.rawValue == 0 {
                                Text(event.startDate.toDetailString)
                                Label(event.title, systemImage: "checkmark.circle")
                            } else if event.availability.rawValue == 1 {
                                Text(event.startDate.toDetailString)
                                Label(event.title, systemImage: "arrow.counterlockwise.circle")
                            } else {
                                Text(event.startDate.toDetailString)
                                Label(event.title, systemImage: "aqi.low")
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: {
            events = eventRepository.readEventsDay(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.selectedDay)
        })
    }
}


struct MainScheduleView_Previews: PreviewProvider {
    @StateObject static private var calendarUseCase = CalendarUseCase()
    @StateObject static private var eventRepository = EventRepository()
    
    static var previews: some View {
        MainScheduleView(terms: 1).environmentObject(calendarUseCase).environmentObject(eventRepository)
    }
}
