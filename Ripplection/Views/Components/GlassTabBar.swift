//
//  GlassTabBar.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import Foundation
import SwiftUI

enum MainTab: String, CaseIterable, Hashable {
    case reflect, log

    var title: String { rawValue.capitalized }
    var systemImage: String {
        switch self {
        case .reflect: return "sparkles"
        case .log: return "calendar"
        }
    }
}

/// The persistent bottom navigation between the "Reflect" flow and the "Log" calendar.
struct GlassTabBar: View {
    @Binding var selection: MainTab

    var body: some View {
        GlassEffectContainer {
            HStack(spacing: 12) {
                ForEach(MainTab.allCases, id: \.self) { tab in
                    tabButton(for: tab)
                }
            }
            .padding(8)
        }
    }

    private func tabButton(for tab: MainTab) -> some View {
        Button {
            selection = tab
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.systemImage)
                Text(tab.title).font(.caption2)
            }
            .foregroundStyle(selection == tab ? .primary : .secondary)
            .frame(width: 72, height: 48)
        }
        .buttonStyle(.glass)
    }
}

#Preview {
    @Previewable @State var selection: MainTab = .reflect
    return GlassTabBar(selection: $selection)
}
