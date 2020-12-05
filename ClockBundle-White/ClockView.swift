// The MIT License
//
// Copyright 2012-2019 Werner Freytag
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

class ClockView: NSView, BundleAware {
    var bundle: Bundle?

    override func draw(_: NSRect) {
        guard let context = currentContext else { return assertionFailure("Can not access graphics context.") }
        guard let bundle = bundle else { return assertionFailure("Bundle not assigned.") }

        var image: NSImage

        context.saveGState()

        image = bundle.image(named: "Background")!
        image.draw(at: .zero, from: .zero, operation: .copy, fraction: 1)

        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.calendar, .hour, .minute, .second], from: Date())

        context.saveGState()

        context.translateBy(x: 64, y: 64)
        context.concatenate(CGAffineTransform(scaleX: 1, y: -1))
        context.rotate(by: .pi)
        context.setShadow(offset: CGSize(width: 0, height: -1), blur: 3, color: NSColor(deviceRed: 0.25, green: 0.28, blue: 0.32, alpha: 0.5).cgColor)

        context.saveGState()
        context.rotate(by: CGFloat(2) * .pi * ((CGFloat(components.hour! % 12) + CGFloat(components.minute!) / 60) / 12))
        image = bundle.image(named: "HourHand")!
        image.draw(at: CGPoint(x: -image.size.width / 2, y: 0), from: .zero, operation: .sourceOver, fraction: 1)
        context.restoreGState()

        context.saveGState()
        context.rotate(by: CGFloat(2) * .pi * (CGFloat(components.minute!) + CGFloat(components.second!) / 60) / 60)
        image = bundle.image(named: "MinuteHand")!
        image.draw(at: CGPoint(x: -image.size.width / 2, y: 0), from: .zero, operation: .sourceOver, fraction: 1.0)
        context.restoreGState()

        context.saveGState()
        context.rotate(by: CGFloat(2) * CGFloat.pi * CGFloat(components.second!) / 60)
        image = bundle.image(named: "SecondHand")!
        image.draw(at: CGPoint(x: -image.size.width / 2, y: 0), from: .zero, operation: .sourceOver, fraction: 1.0)
        context.restoreGState()

        context.setShadow(offset: CGSize(width: 0, height: -2), blur: 4, color: NSColor(deviceRed: 0.25, green: 0.28, blue: 0.32, alpha: 0.4).cgColor)
        image = bundle.image(named: "HandsMiddle")!
        image.draw(at: CGPoint(x: -image.size.width / 2, y: -image.size.width / 2), from: .zero, operation: .sourceOver, fraction: 1)
        context.restoreGState()

        image = bundle.image(named: "Foreground")!
        image.draw(at: .zero, from: .zero, operation: .sourceOver, fraction: 1)

        context.restoreGState()
    }
}