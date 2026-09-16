//
//  RipplectionApp.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import SwiftUI
import SwiftData

@main
struct RipplectionApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: CheckInEntry.self)
    }
}
