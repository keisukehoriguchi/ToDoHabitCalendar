//
//  MonthlyCalendarView.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/13.
//

import SwiftUI

struct MonthlyCalendarView: View {
    let days = ["月","火", "水", "木", "金", "土", "日"]
    var weeks = ["",""]
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    
                }, label: {
                    Text("Today")
                })
                Spacer()
                Text("2021/04")
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "magnifyingglass")
                })
            }.padding(.horizontal, 10.0)
            HStack{
                ForEach(0...days.count-1,id: \.self){
                    if $0 == 0 {
                        Spacer()
                    }
                    Text(days[$0])
                    Spacer()
                }
            }
//            ForEach(0...weeks.count){_ in 
//                
//            }
            
        }
    }
}

struct MonthlyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyCalendarView()
    }
}
