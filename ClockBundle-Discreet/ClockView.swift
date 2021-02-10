// The MIT License
//
// Copyright 2012-2019, 2021 Werner Freytag
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
import SwiftToolbox

class ClockView: NSView, BundleClockView {
    var bundle: Bundle?
    let granularity = Calendar.Component.minute

    override func draw(_: NSRect) {
        guard let context = currentContext else { return assertionFailure("Can not access graphics context.") }
        guard let bundle = bundle else { return assertionFailure("Bundle not assigned.") }

        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short

        let dateString = timeFormatter.string(from: Date())
        guard let components = try? dateString.match(regex: "([0-9])?([0-9])[^0-9]+([0-9]+)([0-9]+)") else { return assertionFailure("Can not parse date.") }

        context.saveGState {
            var image: NSImage!

            image = bundle.image(named: "Background")
            image.draw(at: .zero, from: .zero, operation: .copy, fraction: 1)

            let imageName = components[1].isEmpty ? "0" : components[1]
            image = bundle.image(named: imageName)
            image.draw(at: CGPoint(x: 25 - image.size.width / 2, y: 51), from: .zero, operation: .sourceOver, fraction: 1)

            image = bundle.image(named: components[2])
            image.draw(at: CGPoint(x: 47 - image.size.width / 2, y: 51), from: .zero, operation: .sourceOver, fraction: 1)

            image = bundle.image(named: "Separator")
            image.draw(at: CGPoint(x: 61, y: 55), from: .zero, operation: .sourceOver, fraction: 1)

            image = bundle.image(named: components[3])
            image.draw(at: CGPoint(x: 80 - image.size.width / 2, y: 51), from: .zero, operation: .sourceOver, fraction: 1)

            image = bundle.image(named: components[4])
            image.draw(at: CGPoint(x: 102 - image.size.width / 2, y: 51), from: .zero, operation: .sourceOver, fraction: 1)
        }
    }
}
