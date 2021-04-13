//
//  ContentView.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/13.
//

import SwiftUI

struct ContentView: View {
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
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
