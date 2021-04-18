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
                Divider()
                HStack{
                    Spacer()
                    Text(theDay)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Divider()
                }
            }
        }
    }
}

struct DayViewOnCalendar_Previews: PreviewProvider {
    static var previews: some View {
        DayViewOnCalendar(theDay: "1")
    }
}
