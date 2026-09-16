//
//  PetalShape.swift
//  Ripplection
//
//  Created by Alexander Yofilio S on 15/09/26.
//

import SwiftUI

/// A single teardrop-shaped petal, drawn pointing "up" from the shape's
/// center before rotation is applied by the parent view.
struct PetalShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: width / 2, y: height))
        path.addQuadCurve(to: CGPoint(x: width / 2, y: 0), control: CGPoint(x: width, y: height * 0.55))
        path.addQuadCurve(to: CGPoint(x: width / 2, y: height), control: CGPoint(x: 0, y: height * 0.55))
        return path
    }
}
