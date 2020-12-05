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

        var imageName: String
        var image: NSImage

        context.saveGState()

        image = bundle.image(named: "Background")!
        image.draw(at: .zero, from: .zero, operation: .copy, fraction: 1)

        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short

        let dateString: String! = timeFormatter.string(from: Date())

        let result = dateString.componentsMatchedByRegex("([0-9])?([0-9])[^0-9]+([0-9]+)([0-9]+)")
        let components = result[0]

        if !components[1].isEmpty {
            imageName = components[1]
            image = bundle.image(named: imageName)!
            image.draw(at: CGPoint(x: 17, y: 44), from: .zero, operation: .sourceOver, fraction: 1)

            imageName = components[2]
            image = bundle.image(named: imageName)!
            image.draw(at: CGPoint(x: 38, y: 44), from: .zero, operation: .sourceOver, fraction: 1)
        } else {
            imageName = components[2]
            image = bundle.image(named: imageName)!
            image.draw(at: CGPoint(x: 29, y: 44), from: .zero, operation: .sourceOver, fraction: 1)
        }

        imageName = components[3]
        image = bundle.image(named: imageName)!
        image.draw(at: CGPoint(x: 72, y: 44), from: .zero, operation: .sourceOver, fraction: 1)

        imageName = components[4]
        image = bundle.image(named: imageName)!
        image.draw(at: CGPoint(x: 92, y: 44), from: .zero, operation: .sourceOver, fraction: 1)

        image = bundle.image(named: "Foreground")!
        image.draw(at: .zero, from: .zero, operation: .sourceOver, fraction: 1)

        context.restoreGState()
    }
}