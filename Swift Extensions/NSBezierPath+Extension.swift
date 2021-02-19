// The MIT License
//
// Copyright 2012-2021 Werner Freytag
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import AppKit.NSBezierPath
import Foundation

public extension NSBezierPath {
    func addLine(to: CGPoint) {
        line(to: to)
    }

    var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        for i in 0 ..< elementCount {
            let type = element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo: path.move(to: points[0])
            case .lineTo: path.addLine(to: points[0])
            case .curveTo: path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath: path.closeSubpath()
            @unknown default:
                fatalError()
            }
        }
        return path
    }

    var usesEvenOddFillRule: Bool {
        get {
            return windingRule == .evenOdd
        }
        set {
            windingRule = newValue ? .evenOdd : .nonZero
        }
    }

    func apply(_ transform: CGAffineTransform) {
        self.transform(using: AffineTransform(transform: transform))
    }

    convenience init(roundedRect rect: CGRect, cornerRadius radius: CGFloat) {
        self.init(roundedRect: rect, xRadius: radius, yRadius: radius)
    }
}

private extension AffineTransform {
    init(transform: CGAffineTransform) {
        self.init(m11: transform.a, m12: transform.b, m21: transform.c, m22: transform.a, tX: transform.tx, tY: transform.ty)
    }
}
