//
//  DayViewOnCalendar.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/16.
//

import SwiftUI
import EventKit

struct DayViewOnCalendar: View {
    
    @State var year:Int
    @State var month:Int
    @State var theDay:Int
    
    @State var events:[EKEvent]
    @EnvironmentObject var eventRepository:EventRepository
    @EnvironmentObject var calendarUseCase:CalendarUseCase
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                HStack{
                    Spacer()
                    if theDay != 0  {
                        Text("\(theDay)")
                            .multilineTextAlignment(.center)
                    } else {
                        Text("")
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                ForEach(events, id: \.self) { event in
                    if event.availability.rawValue == 1 {
                        Text(event.title)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(3)
                            .frame(height: 18)
                            .font(.footnote)
                        
                    } else if event.availability.rawValue == 0 {
                        Text(event.title)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(3)
                            .frame(height: 18)
                            .font(.footnote)
                    } else {
                        Text(event.title)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(3)
                            .frame(height: 18)
                            .font(.footnote)
                    }
                }
                .border(Color.gray, width: 0.3)
            }
        }
    }
}

struct DayViewOnCalendar_Previews: PreviewProvider {
    @StateObject static private var eventRepository = EventRepository()
    @StateObject static private var calendarUseCase = CalendarUseCase()
    
    static var previews: some View {
        DayViewOnCalendar(year: 2021, month: 4, theDay: 1, events: []).environmentObject(eventRepository).environmentObject(calendarUseCase)
    }
}
