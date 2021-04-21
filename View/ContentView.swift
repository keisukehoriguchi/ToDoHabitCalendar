//
//  ContentView.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/13.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject static private var calendarUseCase = CalendarUseCase()
    @StateObject static private var eventRepository = EventRepository()
    
    var body: some View {
        TabView {
            MainCalendarView()
            .tabItem {
                Image(systemName: "0.circle")
                Text("Calendar")}.tag(0)
            SubCalendarView()
            .tabItem {
                Image(systemName: "1.circle")
                Text("Calendar")}.tag(1)
            ResultView(toDo_habit: true)
            .tabItem {
                Image(systemName: "2.circle")
                Text("Calendar")}.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static private var calendarUseCase = CalendarUseCase()
    @StateObject static private var eventRepository = EventRepository()
    
    static var previews: some View {
        ContentView().environmentObject(calendarUseCase).environmentObject(eventRepository)
    }
}
