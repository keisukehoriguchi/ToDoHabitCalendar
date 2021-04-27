//
//  MainCalendarView.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/13.
//

import SwiftUI

struct MainCalendarView: View {
    @State var addTaskHabitViewPushed:Bool = false
    
    var body: some View {
        GeometryReader { g in
            ScrollView{
                VStack{
                    MonthlyCalendarView()
                        .frame(height: g.size.height*0.7)
                    MainScheduleView()
                        .frame(height: g.size.height*0.8)
                }.frame(width: g.size.width, height: g.size.height*1.5, alignment: .center)
            }
            .overlay(
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            addTaskHabitViewPushed = true
                        }, label: {
                            Image(systemName: "goforward.plus")
                                .resizable()
                        })
                        .frame(width: 70.0, height: 70.0, alignment: .bottomTrailing)
                        .sheet(isPresented: $addTaskHabitViewPushed, content: {
                            AddToDoHabit(addTaskHabitViewPushed: $addTaskHabitViewPushed)
                        })
                    }
                    .padding(.all, 7.0)
                }
            )
        }
    }
}

struct MainCalendarView_Previews: PreviewProvider {
    @StateObject static private var calendarUseCase = CalendarUseCase()
    
    static var previews: some View {
        MainCalendarView().environmentObject(calendarUseCase)
    }
}
