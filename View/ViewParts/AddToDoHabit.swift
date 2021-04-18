//
//  AddToDoHabit.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/13.
//

import SwiftUI
import EventKit

struct AddToDoHabit: View {
    @State private var isShownReadCalendarView: Bool = false
    @State private var title = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
    @State private var taskOrHabit:Int = 0
    
    @EnvironmentObject var eventRepository:EventRepository
    
    ///上3つの@State変数は、カレンダーにイベントを追加するときに使用します。
    
    @Binding var addTaskHabitViewPushed:Bool
    
    ///EKEventStoreのインスタンスを生成する
    
    var body: some View {
        VStack{
            HStack {
                Button(action: {
                    addTaskHabitViewPushed = false
                }, label: {
                    Text("Back")
                })
                Spacer()
            }.padding(.all, 5)
            
            Form {
                Picker("", selection: $taskOrHabit) {
                    Text("タスク").tag(0)
                    Text("習慣").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Section {
                    TextField("タイトル", text: self.$title)
                    DatePicker(selection: self.$startDate, in: Date()..., displayedComponents: .date, label: { Text("StartDate") })
                    DatePicker(selection: self.$endDate, in: Date()..., displayedComponents: .date, label: { Text("EndDate") })
                }
                Section {
                    Button(action: {
                        if self.title != "" {
                            eventRepository.addEvent(startDate: self.startDate, endDate: self.endDate, title: self.title, taskOrHabit:self.taskOrHabit)
                        } else {
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.error)
                        }
                    }) {
                        Text("add Event")
                    }
                }
                Section {
                    Button(action: {
                        self.isShownReadCalendarView = true
                        eventRepository.readEvents()
                    }) {
                        Text("Read Calendar")
                            .sheet(isPresented: self.$isShownReadCalendarView) {
                                ForEach(0..<eventRepository.titles.count, id: \.self) { i in
                                    Text(eventRepository.titles[i])
                                }
                            }
                    }
                }
                .onAppear(perform: eventRepository.allowAuthorization)
            }
        }
    }
}

struct AddToDoHabit_Previews: PreviewProvider {
    @StateObject static private var eventRepository = EventRepository()
    
    static var previews: some View {
        AddToDoHabit(addTaskHabitViewPushed: .constant(true)).environmentObject(eventRepository)
    }
}
