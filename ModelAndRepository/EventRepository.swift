//
//  EventRepository.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/17.
//

import Foundation
import EventKit

class EventRepository:ObservableObject {
    
    @Published var titles: [String] = []
    @Published var startDates: [Date] = []
    @Published var endDates: [Date] = []
    
    ///上3つのArray配列を使用して、カレンダーやリマインダーに応用する。
    
    let eventStore = EKEventStore()
    
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
    
    func addEvent(startDate: Date, endDate: Date?, title: String, taskOrHabit:Int) {
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
        event.availability = EKEventAvailability.init(rawValue: taskOrHabit) ?? EKEventAvailability.busy
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
//            let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
            let twentyYears:Double = (60*60*30*12*20)
            let threeMonths:Double = (60*60*30*3)
            let fixedDay = Date(timeIntervalSinceReferenceDate: twentyYears+threeMonths)
            let oneYearAfter = Calendar.current.date(byAdding: .month, value: +12, to: Date())!
            
            let predicate = eventStore.predicateForEvents(withStart: fixedDay, end: oneYearAfter, calendars: [calendar])
            
            let events = eventStore.events(matching: predicate)
            for event in events {
                self.titles.append(event.title)
                self.startDates.append(event.startDate)
                self.endDates.append(event.endDate)
            }
        }
    }
}
