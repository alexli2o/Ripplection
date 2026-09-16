//
//  AmbientBackground.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import SwiftUI

/// The soft, slowly shifting gradient backdrop used behind every screen.
struct AmbientBackground: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            let angle = Angle(degrees: t.truncatingRemainder(dividingBy: 60) / 60 * 360)

            // To-Do: try changing it into radial gradient (circle)
            LinearGradient(
                colors: [
                    Color(red: 0.86, green: 0.90, blue: 0.98),
                    Color(red: 0.80, green: 0.85, blue: 0.97),
                    Color(red: 0.90, green: 0.87, blue: 0.96)
                ],
                startPoint: UnitPoint(x: 0.5 + 0.5 * cos(angle.radians), y: 0.5 + 0.5 * sin(angle.radians)),
                endPoint: UnitPoint(x: 0.5 - 0.5 * cos(angle.radians), y: 0.5 - 0.5 * sin(angle.radians))
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    AmbientBackground()
}
