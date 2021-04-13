//
//  DateItem.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/13.
//

import Foundation

struct Request {
    
    var year: Int
    var month: Int
    var day: Int
    
    init() {
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.dateComponents([.year, .month, .day], from: Date())
        year = date.year!
        month = date.month!
        day = date.day!
    }
}
