//
//  LiquidWaveShape.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import SwiftUI

/// A horizontal sine wave used as the fill surface inside `LiquidOrb`.
/// `level` (0...1) is the fill height; `phase` animates the wave's horizontal motion.
struct LiquidWaveShape: Shape {
    var level: Double
    var phase: Double
    var amplitude: CGFloat = 8
    var wavelength: CGFloat = 1.25

    var animatableData: Double {
        get { level }
        set { level = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let fillY = rect.height * (1 - CGFloat(level.clamped(to: 0...1)))
        let wavelengthPx = max(rect.width * wavelength, 1)

        path.move(to: CGPoint(x: 0, y: fillY))
        var x: CGFloat = 0
        while x <= rect.width {
            let relative = x / wavelengthPx
            let y = fillY + sin(relative * 2 * .pi + phase) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
            x += 2
        }
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}
