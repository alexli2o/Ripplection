//
//  CalendarLogView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI
import SwiftData

/// The "Log" tab: a month grid highlighting days that have a saved check-in.
struct CalendarLogView: View {
    @State private var viewModel = CalendarLogViewModel()
    @Query(sort: \CheckInEntry.date, order: .reverse) private var entries: [CheckInEntry]

    private let weekdaySymbols = ["S", "M", "T", "W", "T", "F", "S"]
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack(spacing: 24) {
            header

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(weekdaySymbols.indices, id: \.self) { index in
                    Text(weekdaySymbols[index])
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                }

                ForEach(viewModel.daysGrid()) { day in
                    dayCell(day)
                }
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .padding(.top, 80)
    }

    private var header: some View {
        HStack {
            Button { viewModel.goToPreviousMonth() } label: { Image(systemName: "chevron.left") }
            Spacer()
            Text(viewModel.monthTitle).font(.title3.weight(.semibold))
            Spacer()
            Button { viewModel.goToNextMonth() } label: { Image(systemName: "chevron.right") }
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 32)
    }

    @ViewBuilder
    private func dayCell(_ day: CalendarDay) -> some View {
        if let date = day.date {
            let hasEntry = viewModel.hasEntry(on: date, in: entries)
            let isToday = Calendar.current.isDateInToday(date)

            Text(date.formatted(.dateTime.day()))
                .font(.subheadline)
                .frame(width: 36, height: 36)
                .background {
                    if hasEntry && !isToday {
                        Circle().fill(.blue.opacity(0.15))
                    }
                }
                .glassEffect(isToday ? Glass.regular.tint(.blue) : .identity, in: Circle())
        } else {
            Color.clear.frame(width: 36, height: 36)
        }
    }
}

#Preview {
    CalendarLogView()
        .modelContainer(for: CheckInEntry.self, inMemory: true)
}
