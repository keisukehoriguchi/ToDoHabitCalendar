//
//  MainScheduleView.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/17.
//

import SwiftUI

struct MainScheduleView: View {
    
    @State var terms:Int
    @State var selectedTermsFrom = "4/17 0:00"
    @State var selectedTermsTo = "4/17 23:59"
    @State var eventString:[String] = ["13:00 美容院行く"," 18:00 家に帰る"]
    //    @EnvironmentObject var calendarUseCase:CalendarUseCase
    
    var body: some View {
        VStack{
            Picker(selection: $terms, label: Text("Picker"), content: {
                Text("Day").tag(1)
                Text("Week").tag(2)
                Text("Month").tag(3)
            })
            .pickerStyle(SegmentedPickerStyle())
            
            List{
                Section(header:
                            HStack{
                                Text(selectedTermsFrom)
                                Text(" ~ ")
                                Text(selectedTermsTo)
                            }
                            .padding(.all, 5)
                ) {
                    ForEach(eventString, id: \.self){ item in
                        Text(item)
                    }
                }
            }
        }
    }
}

struct MainScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MainScheduleView(terms: 1)
    }
}
