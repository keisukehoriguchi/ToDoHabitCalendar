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
