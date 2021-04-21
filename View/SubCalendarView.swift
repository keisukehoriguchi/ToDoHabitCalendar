//
//  SubCalendarView.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/13.
//

import SwiftUI

struct SubCalendarView: View {
    
    @EnvironmentObject var calendarUseCase:CalendarUseCase
    
    private let time = ["0:00","1:00","2:00","3:00","4:00","5:00","6:00","7:00","8:00","9:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","24:00"]
    
    var body: some View {
        VStack{
            HStack{
                Text("\(calendarUseCase.thisYear.withoutComma)/\(calendarUseCase.thisMonth)/\(calendarUseCase.today)")
                VStack{
                    //                        ForEach(){
                    Label("event1", image: "moon")
                    //                        }
                }
            }
            
            ScrollView{
                Divider()
                ForEach(time,id:\.self){ item in
                    VStack{
                        Spacer()
                        HStack{
                            Text(item)
                            Divider()
                            Spacer()
                        }
                        Spacer()
                        Divider()
                    }
                }
            }
        }
    }
}

struct SubCalendarView_Previews: PreviewProvider {
    @StateObject static private var calendarUseCase = CalendarUseCase()
    
    static var previews: some View {
        SubCalendarView().environmentObject(calendarUseCase)
    }
}
