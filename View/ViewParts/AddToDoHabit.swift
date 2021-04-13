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
    
    ///上3つの@State変数は、カレンダーにイベントを追加するときに使用します。
    
    @State private var titles: [String] = []
    @State private var startDates: [Date] = []
    @State private var endDates: [Date] = []
    
    ///上3つのArray配列を使用して、カレンダーやリマインダーに応用する。
    
    @Binding var addTaskHabitViewPushed:Bool
    
    let eventStore = EKEventStore()
    ///EKEventStoreのインスタンスを生成する。
    
    var body: some View {
        VStack{
            HStack {
                Button(action: {
                    addTaskHabitViewPushed = false
                }, label: {
                    Text("Back")
                })
                Spacer()
            }.padding()
            
            Form {
                Section {
                    TextField("タイトル", text: self.$title)
                    DatePicker(selection: self.$startDate, in: Date()..., displayedComponents: .date, label: { Text("StartDate") })
                    DatePicker(selection: self.$endDate, in: Date()..., displayedComponents: .date, label: { Text("EndDate") })
                }
                Section {
                    Button(action: {
                        if self.title != "" {
                            self.addEvent(startDate: self.startDate, endDate: self.endDate, title: self.title)
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
                        self.readEvents()
                    }) {
                        Text("Read Calendar")
                            .sheet(isPresented: self.$isShownReadCalendarView) {
                                ForEach(0..<self.titles.count, id: \.self) { i in
                                    Text(self.titles[i])
                                }
                            }
                    }
                }
                .onAppear(perform: self.allowAuthorization)
            }
        }
    }
}

extension AddToDoHabit {
    func allowAuthorization() {
        if getAuthorization_status() {
            // 許可されているので、何もしない。
            return
        } else {
            // 許可されていないので、ユーザーに許可を得ます。
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if granted {
                    return
                } else {
                    print("Not allowed")
                }
            })
        }
    }
    
    // 認証ステータスを確認する
    func getAuthorization_status() -> Bool {
        // 認証ステータスを取得
        let status = EKEventStore.authorizationStatus(for: .event)//.reminderで、リマインダーの方も指定できる。
        // ステータスの表示が許可されている場合のみtrueを返す
        switch status {
        case .notDetermined:
            print("NotDetermined")
            return false
        case .denied:
            print("Denied")
            return false
        case .authorized:
            print("Authorized")
            return true
        case .restricted:
            print("Restricted")
            return false
        @unknown default:
            literalExpression()
            fatalError("カレンダーの認証部分でエラー @unknown default")
        }
    }
    
    func listEvents() {
        // 検索条件
        let startDate = Date()
        let endDate = Date()
        let dC = eventStore.defaultCalendarForNewEvents
        guard let defaultCalendar = dC else {
            return
        }
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: [defaultCalendar])
        // イベントを検索
        let events = eventStore.eventStoreIdentifier
    }
    
    func addEvent(startDate: Date, endDate: Date?, title: String) {
        // イベントの情報を準備
        let startDate = startDate
        let endDate = endDate
        let title = title
        let defaultCalendar = eventStore.defaultCalendarForNewEvents
        // イベントを作成して情報をセット
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = defaultCalendar
        // イベントの登録
        do {
            try eventStore.save(event, span: .thisEvent)
        } catch let error {
            print(error)
        }
    }
    
    func deleteEvent(event: EKEvent) {
        do {
            try eventStore.remove(event, span: .thisEvent)
        } catch let error {
            print(error)
        }
    }
    
    func readEvents() {
        let eventStore = EKEventStore()
        let calendars = eventStore.calendars(for: .event)
        for calendar in calendars {
            //if calendar.source.title == "カレンダーの名前" {
            ///カレンダーの名前を指定することができる。
            let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
            let oneMonthAfter = Calendar.current.date(byAdding: .month, value: +1, to: Date())!
            
            let predicate = eventStore.predicateForEvents(withStart: oneMonthAgo, end: oneMonthAfter, calendars: [calendar])
            
            let events = eventStore.events(matching: predicate)
            for event in events {
                
                self.titles.append(event.title)
                self.startDates.append(event.startDate)
                self.endDates.append(event.endDate)
                
            }
            //}
        }
    }
    
    func literalExpression() {
        print("__FILE__",#file)
        print("__LINE__",#line)
        print("__COLUMN__",#column)
        print("__FUNCTION__",#function)
    }
}

struct AddToDoHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoHabit(addTaskHabitViewPushed: .constant(true))
    }
}
