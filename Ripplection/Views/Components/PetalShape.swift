////
////  PetalShape.swift
////  Ripplection
////
////  Created by Alexander Yofilio S on 15/09/26.
////
//
//import SwiftUI
//
///// A single teardrop-shaped petal, drawn pointing "up" from the shape's
///// center before rotation is applied by the parent view.
//struct PetalShape: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let width = rect.width
//        let height = rect.height
//
//        path.move(to: CGPoint(x: width / 2, y: height))
//        path.addQuadCurve(to: CGPoint(x: width / 2, y: 0), control: CGPoint(x: width, y: height * 0.55))
//        path.addQuadCurve(to: CGPoint(x: width / 2, y: height), control: CGPoint(x: 0, y: height * 0.55))
//        return path
//    }
//}

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
    /// How far the curve's control point overshoots the frame's edge, as a
    /// multiple of `width`. A quadratic Bézier curve never reaches its own
    /// control point — at `bulge = 1.0` (control point sitting exactly on
    /// the frame edge) the curve only ever reaches about 75% of the way
    /// there, making the petal look thin. Overshooting the control point
    /// past the edge (values above 1.0) pulls the curve closer to the
    /// frame's actual width, producing a visibly thicker petal.
    var bulge: CGFloat = 1.25

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let controlOffset = width * bulge

        path.move(to: CGPoint(x: width / 2, y: height))
        path.addQuadCurve(
            to: CGPoint(x: width / 2, y: 0),
            control: CGPoint(x: controlOffset, y: height * 0.55)
        )
        path.addQuadCurve(
            to: CGPoint(x: width / 2, y: height),
            control: CGPoint(x: width - controlOffset, y: height * 0.55)
        )
        return path
    }
}
