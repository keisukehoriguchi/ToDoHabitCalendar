//
//  ScheduleLineView.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/21.
//

import SwiftUI
import EventKit

struct ScheduleLineView: View {
    
    @State var title:String = "2021/04/26"
    @State var events:[EKEvent] = []
    let clearBlue = Color.blue.opacity(0.1)
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.body)
                Spacer()
            }
            .padding(.leading, 15)
            
            ForEach(events, id: \.self) {event in
                HStack{
                    Text(event.startDate.toDetailString)
                    VStack{
                        Text(event.title)
                        if let note = event.notes {
                            Text(note)
                        }
                    }
                    Spacer()
                }
                .padding(.all,10    )
                .background(clearBlue)
                .cornerRadius(5)
            }
            .padding(.horizontal, 10)
        }
        
    }
    
}

struct ScheduleLineView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleLineView()
    }
}
