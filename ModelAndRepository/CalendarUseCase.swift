//
//  CalendarUseCase.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/13.
//

import Foundation
import SwiftUI

class CalendarUseCase: ObservableObject {
    
    init() {
        getToday()
        updateCalendar(y: thisYear, m: thisMonth)
    }
    
    @Published var thisYear: Int = 0
    @Published var thisMonth: Int = 0
    @Published var today: Int = 0
    
    var monthCounter = 0 {
        didSet{
            let date = DateItems.MoveMonth.Request(monthCounter)
            thisYear = date.year
            thisMonth = date.month
            updateCalendar(y: thisYear, m: thisMonth)
        }
    }
    
    @Published var numberOfWeeks: Int = 0
    @Published var daysArray: [String] = ["1","2"]
    @Published var numberOfWeeksArray:[String] = []
    var startDayOfWeek: Int = 0
    
    private let date = DateItems.ThisMonth.Request()
    
    let isLeapYear = { (year: Int) in year % 400 == 0 || (year % 4 == 0 && year % 100 != 0) }
    let zellerCongruence = { (year: Int, month: Int, day: Int) in (year + year/4 - year/100 + year/400 + (13 * month + 8)/5 + day) % 7 }

    func dateManager(year: Int, month: Int){
        let firstDayOfWeek = dayOfWeek(year, month, 1)
        let numberOfCells = numberOfWeeks(year, month) * 7
        let days = numberOfDays(year, month)
        let Array = alignmentOfDays(firstDayOfWeek, numberOfCells, days)
        daysArray = Array
    }
    
    func numberOfWeeks(year: Int, month: Int) {
        let weeks = numberOfWeeks(year, month)
        numberOfWeeks = weeks
        
        numberOfWeeksArray = []
        for item in 0 ..< numberOfWeeks {
            let toStrig = String(item)
            numberOfWeeksArray.append(toStrig)
        }
    }
    
    func updateCalendar(y:Int, m:Int) {
        dateManager(year: y, month: m)
        numberOfWeeks(year: y, month: m)
    }
    
    func backToToday(){
        getToday()
        updateCalendar(y: thisYear, m: thisMonth)
    }

}

extension CalendarUseCase {

    private func dayOfWeek(_ year: Int, _ month: Int, _ day: Int) -> Int {
        var year = year
        var month = month
        if month == 1 || month == 2 {
            year -= 1
            month += 12
        }
        return zellerCongruence(year, month, day)
    }

    private func numberOfWeeks(_ year: Int, _ month: Int) -> Int {
        if conditionFourWeeks(year, month) {
            return 4
        } else if conditionSixWeeks(year, month) {
            return 6
        } else {
            return 5
        }
    }

    private func numberOfDays(_ year: Int, _ month: Int) -> Int {
        var monthMaxDay = [1:31, 2:28, 3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31]
        if month == 2, isLeapYear(year) {
            monthMaxDay.updateValue(29, forKey: 2)
        }
        return monthMaxDay[month]!
    }

    private func conditionFourWeeks(_ year: Int, _ month: Int) -> Bool {
        let firstDayOfWeek = dayOfWeek(year, month, 1)
        return !isLeapYear(year) && month == 2 && (firstDayOfWeek == 0)
    }

    private func conditionSixWeeks(_ year: Int, _ month: Int) -> Bool {
        let firstDayOfWeek = dayOfWeek(year, month, 1)
        let days = numberOfDays(year, month)
        return (firstDayOfWeek == 6 && days == 30) || (firstDayOfWeek >= 5 && days == 31)
    }

    private func alignmentOfDays(_ firstDayOfWeek: Int, _ numberOfCells: Int, _ days: Int) -> [String] {
        var daysArray: [String] = []
        var dayCount = 0
        for i in 0 ... numberOfCells {
            let diff = i - firstDayOfWeek
            if diff < 0 || dayCount >= days {
                daysArray.append("")
            } else {
                daysArray.append(String(diff + 1))
                dayCount += 1
            }
        }
        return daysArray
    }
    
    func getToday() {
        thisYear = date.year
        thisMonth = date.month
        today = date.day
    }
}
