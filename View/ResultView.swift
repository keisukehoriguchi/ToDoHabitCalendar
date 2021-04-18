//
//  ResultView.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/13.
//

import SwiftUI

struct ResultView: View {
    @State var toDo_habit:Bool
    
    var body: some View {
        VStack{
            Picker(selection: $toDo_habit, label: Text("Picker"), content: {
                Text("Task").tag(true)
                Text("Habit").tag(false)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Image(systemName: "moon")
                .resizable()
                .frame(width: 250, height: 250, alignment: .center)
            Image(systemName: "goforward")
                .resizable()
                .frame(width: 250, height: 250, alignment: .center)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(toDo_habit: true)
    }
}
