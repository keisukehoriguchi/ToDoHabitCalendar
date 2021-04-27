//
//  MainScheduleView.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/17.
//

import SwiftUI
import EventKit

struct MainScheduleView: View {
    
    @EnvironmentObject var eventRepository:EventRepository
    @EnvironmentObject var calendarUseCase:CalendarUseCase
    
    //    @State var terms:Int = 0
    
    ///eventsだけでは日付が変わった時の表示の変化をうまく出せなかったからしようとしたら、思ったより複雑だったのとそこまで必要じゃないと思ったので中止
    @State var eventForDetail:[String:[EKEvent]] = ["":[]]
    @State var events:[EKEvent] = []
    
    var body: some View {
        VStack{
            Picker(selection: $eventRepository.terms, label: Text("Picker"), content: {
                Text("Day").tag(0)
                Text("Week").tag(1)
                Text("Month").tag(2)
            })
            .padding(.all, 5)
            .pickerStyle(SegmentedPickerStyle())
            .onReceive(eventRepository.$terms, perform: { value in
                updateEvent(value: value)
                updateEventDetail()
            })
            //            List {
            ScrollView{
                ForEach(Array(eventForDetail.keys), id: \.self) { key in
                    if key != "" {
                        if let currentEvents:[EKEvent] = eventForDetail[key] {
                            ScheduleLineView(title: key, events: currentEvents)
                        }
                    }
                }
                //            }
            }
        }
    }
}

extension MainScheduleView {
    
    func updateEventDetail(){
        eventForDetail = ["":[]]
        var forAdd:[EKEvent] = []
        var checkDay:String = ""
        for i in 0 ..< (events.count) {
            //最後の処理じゃない場合
            if i != (events.count-1) {
                //日付が変わった場合
                if checkDay != events[i].startDate.toString {
                    //最初の処理でもない場合、追加でやること
                    if checkDay != "" {
                        eventForDetail[checkDay] = forAdd
                    }
                    checkDay = events[i].startDate.toString
                    forAdd = []
                    forAdd.append(events[i])
                    //日付が変わらなかった場合
                } else if checkDay == events[i].startDate.toString {
                    forAdd.append(events[i])
                }
                //最後の処理
            } else {
                //日付が変わった場合と最初の処理
                if checkDay != events[i].startDate.toString {
                    if checkDay != "" {
                        eventForDetail[checkDay] = forAdd
                    }
                    checkDay = events[i].startDate.toString
                    forAdd = []
                    forAdd.append(events[i])
                    eventForDetail[checkDay] = forAdd
                } else if checkDay == events[i].startDate.toString {
                    forAdd.append(events[i])
                    eventForDetail[checkDay] = forAdd
                }
            }
        }
    }
    
    func updateEvent(value:Int){
        if value == 0 {
            events = eventRepository.readEventsDay(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.selectedDay)
        } else if value == 1 {
            events = eventRepository.readEventsWeek(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.selectedDay)
        } else if value == 2 {
            events = eventRepository.readEventsMonth(startYear: calendarUseCase.thisYear, startMonth: calendarUseCase.thisMonth, startDay: calendarUseCase.selectedDay)
        }
    }
}


struct MainScheduleView_Previews: PreviewProvider {
    @StateObject static private var calendarUseCase = CalendarUseCase()
    @StateObject static private var eventRepository = EventRepository()
    
    static var previews: some View {
        MainScheduleView().environmentObject(calendarUseCase).environmentObject(eventRepository)
    }
}
