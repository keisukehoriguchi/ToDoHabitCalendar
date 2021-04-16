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
        VStack{
            SampleCalendar()
            List{
                Section(header:
                            Text("3/1")
                ) {
                    HStack {
                        Text("13:00")
                        Text("Drink Water")
                    }
                    HStack {
                        Text("15:00")
                        Text("Drink Alcor")
                    }
                }
            }
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

struct MainCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MainCalendarView()
    }
}
