//
//  DayViewOnCalendar.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/16.
//

import SwiftUI

struct DayViewOnCalendar: View {
    
    var theDay:String
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                HStack{
                    Spacer()
                    Text(theDay)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
//                Text("task1")
//                    .foregroundColor(Color.white)
//                    .background(Color.blue)
//                Text("task1")
//                    .foregroundColor(Color.white)
//                    .background(Color.green)
            }
//            .frame(width: (geometry.frame(in: .global).size.width)/8, height: (geometry.frame(in: .global).size.width)/8, alignment: .center)
        }
    }
}

struct DayViewOnCalendar_Previews: PreviewProvider {
    static var previews: some View {
        DayViewOnCalendar(theDay: "1")
    }
}
