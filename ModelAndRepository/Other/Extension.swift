//
//  Extension.swift
//  ToDoHabitCalendar
//
//  Created by Keisuke Horiguchi on 2021/04/17.
//

import Foundation
import SwiftUI
import EventKit

struct CardViewModifier: ViewModifier {
    let color: Color
    let radius: CGFloat
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: color, radius: radius, x: 4, y: 4)
    }
}

extension View {
    func card(
        color: Color = Color.gray.opacity(0.4),
        radius: CGFloat = 8) -> some View {
        self.modifier(CardViewModifier(color: color, radius: radius))
    }
}

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
//        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.locale = NSLocale.current
        return dateFormatter.string(from: self)
    }
    var toDetailString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
//        dateFormatter.locale = Locale(identifier: "ja_JP")
//        dateFormatter.locale = NSLocale.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
    
    var toStringOnlyDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
//        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.locale = NSLocale.current
        return dateFormatter.string(from: self)
    }
    
}

private let formatter: NumberFormatter = {
    let f = NumberFormatter()
    f.numberStyle = .decimal
    f.groupingSeparator = ""
    f.groupingSize = 3
    return f
}()

extension Int {
    var withoutComma: String {
        return formatter.string(from: NSNumber(integerLiteral: self)) ?? "\(self)"
    }
}
