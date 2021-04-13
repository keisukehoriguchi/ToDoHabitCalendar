//
//  CalendarUseCase.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/13.
//

import Foundation

let isLeapYear = { (year: Int) in year % 400 == 0 || (year % 4 == 0 && year % 100 != 0) }

let zellerCongruence = { (year: Int, month: Int, day: Int) in (year + year/4 - year/100 + year/400 + (13 * month + 8)/5 + day) % 7 }


func dayOfWeek(_ year: Int, _ month: Int, _ day: Int) -> Int {
    var year = year
    var month = month
    if month == 1 || month == 2 {
        year -= 1
        month += 12
    }
    return zellerCongruence(year, month, day)
}

func conditionFourWeeks(_ year: Int, _ month: Int) -> Bool {
    let firstDayOfWeek = dayOfWeek(year, month, 1)
    return !isLeapYear(year) && month == 2 && (firstDayOfWeek == 0)
}

func conditionSixWeeks(_ year: Int, _ month: Int) -> Bool {
    let firstDayOfWeek = dayOfWeek(year, month, 1)
    let days = numberOfDays(year, month)
    return (firstDayOfWeek == 6 && days == 30) || (firstDayOfWeek >= 5 && days == 31)
}

func numberOfWeeks(_ year: Int, _ month: Int) -> Int {
    if conditionFourWeeks(year, month) {
        return 4
    } else if conditionSixWeeks(year, month) {
        return 6
    } else {
        return 5
    }
}
