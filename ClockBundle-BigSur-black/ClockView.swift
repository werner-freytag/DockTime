// The MIT License
//
// Copyright 2021 Werner Freytag
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
import DockTimePlugin

class ClockView: NSView, BundleClockView {
    var bundle: Bundle?
    let granularity = Calendar.Component.nanosecond

    let defaults = UserDefaults.shared

    override func draw(_: NSRect) {
        guard let context = currentContext else { return assertionFailure("Can not access graphics context.") }
        guard let bundle = bundle else { return assertionFailure("Bundle not assigned.") }

        var image: NSImage

        image = bundle.image(named: "Background")!
        image.draw(at: .zero, from: .zero, operation: .copy, fraction: 1)

        let fractions = Calendar.current.fractions([.hour, .minute, .second, .nanosecond])

        context.saveGState {
            context.translateBy(x: 64, y: 64)
            context.concatenate(CGAffineTransform(scaleX: 1, y: -1))
            context.rotate(by: .pi)

            if defaults.showSeconds {
                context.saveGState {
                    context.rotate(by: CGFloat(2) * .pi * fractions.second)
                    image = bundle.image(named: "SecondHand")!
                    image.draw(at: CGPoint(x: -image.size.width / 2, y: -2), from: .zero, operation: .sourceOver, fraction: 1)
                }
            }

            context.saveGState {
                context.rotate(by: CGFloat(2) * .pi * fractions.minute)
                image = bundle.image(named: "MinuteHand")!
                image.draw(at: CGPoint(x: -image.size.width / 2, y: -2), from: .zero, operation: .sourceOver, fraction: 1)
            }

            context.saveGState {
                context.rotate(by: CGFloat(2) * .pi * fractions.hour)
                image = bundle.image(named: "HourHand")!
                image.draw(at: CGPoint(x: -image.size.width / 2, y: -2), from: .zero, operation: .sourceOver, fraction: 1)
            }
        }
    }
}
