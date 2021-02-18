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
import SwiftToolbox

class ClockView: NSView {
    lazy var bundle = Bundle(for: type(of: self))

    override func draw(_: NSRect) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short

        let dateString: String! = timeFormatter.string(from: Date())

        guard let components = try? dateString.match(regex: "([0-9])?([0-9])[^0-9]+([0-9]+)([0-9]+)") else { return assertionFailure("Can not parse date.") }

        var imageName: String
        var image: NSImage!

        image = bundle.image(named: "Background")!
        image.draw(at: .init(x: 8, y: 8), from: .zero, operation: .copy, fraction: 1)

        imageName = components[1].isEmpty ? "0" : components[1]
        image = bundle.image(named: imageName)
        image.draw(at: CGPoint(x: 22, y: 46), from: .zero, operation: .sourceOver, fraction: 1)

        imageName = components[2]
        image = bundle.image(named: imageName)
        image.draw(at: CGPoint(x: 41, y: 46), from: .zero, operation: .sourceOver, fraction: 1)

        imageName = components[3]
        image = bundle.image(named: imageName)
        image.draw(at: CGPoint(x: 67, y: 46), from: .zero, operation: .sourceOver, fraction: 1)

        imageName = components[4]
        image = bundle.image(named: imageName)
        image.draw(at: CGPoint(x: 86, y: 46), from: .zero, operation: .sourceOver, fraction: 1)
    }
}
