//
//  MainTabView.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI
import SwiftData

/// The app's root: two tabs (Reflect / Log) with a floating glass tab bar.
struct MainTabView: View {
    @State private var selection: MainTab = .reflect

    var body: some View {
        ZStack(alignment: .bottom) {
            AmbientBackground()

            Group {
                switch selection {
                case .reflect: HomeView()
                case .log: CalendarLogView()
                }
            }

            GlassTabBar(selection: $selection)
                .padding(.bottom, 12)
        }
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: CheckInEntry.self, inMemory: true)
}
