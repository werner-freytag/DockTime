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

import AppKit

class ClockView: NSView {
    lazy var bundle = Bundle(for: type(of: self))
    let defaults = UserDefaults.shared

    override func draw(_: NSRect) {
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())

        var imageName: String
        var image: NSImage

        image = bundle.image(named: "Background")!
        image.draw(at: .init(x: 9, y: 8), from: .zero, operation: .copy, fraction: 1)

        imageName = String(format: "%ld", components.hour! / 10)
        image = bundle.image(named: imageName)!
        image.draw(at: CGPoint(x: 29, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

        imageName = String(format: "%ld", components.hour! % 10)
        image = bundle.image(named: imageName)!
        image.draw(at: CGPoint(x: 46, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

        imageName = String(format: "%ld", components.minute! / 10)
        image = bundle.image(named: imageName)!
        image.draw(at: CGPoint(x: 66, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

        imageName = String(format: "%ld", components.minute! % 10)
        image = bundle.image(named: imageName)!
        image.draw(at: CGPoint(x: 83, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

        if defaults.showSeconds {
            image = bundle.image(named: "Dot")!
            let center = CGPoint(x: 62.5, y: 62.5)
            for i in 0 ... components.second! {
                let angle = CGFloat(i) * .pi * 2 / 60
                image.draw(at: center.applying(angle: angle, distance: 42), from: .zero, operation: .sourceOver, fraction: 1)
                if i % 5 == 0 {
                    image.draw(at: center.applying(angle: angle, distance: 46), from: .zero, operation: .sourceOver, fraction: 1)
                }
            }
        }
    }
}

extension CGPoint {
    func applying(angle: CGFloat, distance: CGFloat) -> CGPoint {
        let x = sin(angle) * distance
        let y = cos(angle) * distance
        return applying(.init(translationX: x, y: y))
    }
}
