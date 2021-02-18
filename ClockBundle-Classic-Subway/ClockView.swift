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
        guard let context = currentContext else { return assertionFailure("Can not access graphics context.") }

        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.hour, .minute, .second], from: Date())

        context.saveGState {
            var imageName: String
            var image: NSImage

            image = bundle.image(named: "Background")!
            image.draw(at: .zero, from: .zero, operation: .copy, fraction: 1)

            imageName = String(format: "%ld", components.hour! / 10)
            image = bundle.image(named: imageName)!
            image.draw(at: CGPoint(x: 21, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

            imageName = String(format: "%ld", components.hour! % 10)
            image = bundle.image(named: imageName)!
            image.draw(at: CGPoint(x: 41, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

            imageName = String(format: "%ld", components.minute! / 10)
            image = bundle.image(named: imageName)!
            image.draw(at: CGPoint(x: 63, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

            imageName = String(format: "%ld", components.minute! % 10)
            image = bundle.image(named: imageName)!
            image.draw(at: CGPoint(x: 83, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

            if defaults.showSeconds {
                image = bundle.image(named: "Dot")!

                for i in stride(from: 0, to: 60, by: 5) {
                    let angle = CGFloat.pi * 2 / 60 * CGFloat(i)
                    let x = sin(angle) * 52
                    let y = cos(angle) * 52
                    image.draw(at: CGPoint(x: 62.0 + x, y: 64.0 + y), from: .zero, operation: .sourceOver, fraction: 1)
                }

                for i in 0 ... components.second! {
                    let angle = CGFloat.pi * 2 / 60 * CGFloat(i)
                    let x = sin(angle) * 48
                    let y = cos(angle) * 48
                    image.draw(at: CGPoint(x: 62.0 + x, y: 64.0 + y), from: .zero, operation: .sourceOver, fraction: 1)
                }
            }
        }
    }
}
