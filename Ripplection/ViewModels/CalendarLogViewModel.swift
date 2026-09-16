//
//  CalendarLogViewModel.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftData
import Observation

/// Backs the monthly log view: which month is showing, and which days in it
/// have an entry.
@Observable
final class CalendarLogViewModel {
    private(set) var displayedMonth: Date

    init(displayedMonth: Date = .now) {
        self.displayedMonth = Calendar.current.startOfMonth(for: displayedMonth)
    }

    func goToPreviousMonth() {
        displayedMonth = Calendar.current.date(byAdding: .month, value: -1, to: displayedMonth) ?? displayedMonth
    }

    func goToNextMonth() {
        displayedMonth = Calendar.current.date(byAdding: .month, value: 1, to: displayedMonth) ?? displayedMonth
    }

    var monthTitle: String {
        displayedMonth.formatted(.dateTime.month(.wide).year())
    }

    /// All calendar cells to render, including leading blanks before day 1.
    func daysGrid() -> [CalendarDay] {
        let calendar = Calendar.current
        guard let monthRange = calendar.range(of: .day, in: .month, for: displayedMonth),
              let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth))
        else { return [] }

        let weekdayOfFirst = calendar.component(.weekday, from: firstOfMonth) // 1 = Sunday
        let leadingBlanks = weekdayOfFirst - 1

        var days: [CalendarDay] = (0..<leadingBlanks).map { _ in CalendarDay(date: nil) }
        days += monthRange.map { dayNumber in
            CalendarDay(date: calendar.date(byAdding: .day, value: dayNumber - 1, to: firstOfMonth))
        }
        return days
    }

    func hasEntry(on date: Date, in entries: [CheckInEntry]) -> Bool {
        entries.contains { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
}

/// A single grid cell in the month view. `date` is nil for leading blanks.
struct CalendarDay: Identifiable {
    let id = UUID()
    let date: Date?
}

extension Calendar {
    func startOfMonth(for date: Date) -> Date {
        self.date(from: dateComponents([.year, .month], from: date)) ?? date
    }
}
