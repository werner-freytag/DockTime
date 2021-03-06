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
import SwiftToolbox

class ClockView: NSView {
    lazy var bundle = Bundle(for: type(of: self))

    override func draw(_: NSRect) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short

        guard let components = try? timeFormatter.string(from: Date()).match(regex: "([0-9])?([0-9])[^0-9]+([0-9]+)([0-9]+)") else { return assertionFailure("Can not parse date.") }

        let dateString = components[0]

        var image: NSImage!

        image = bundle.image(named: "Background")
        image.draw(at: .init(x: 9, y: 7), from: .zero, operation: .copy, fraction: 1)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let font = NSFont.systemFont(ofSize: 36, weight: .light)

        let shadow = NSShadow()
        shadow.shadowColor = NSColor.black.withAlphaComponent(0.05)
        shadow.shadowOffset = NSSize(width: 0, height: -2)
        shadow.shadowBlurRadius = 4

        let attrs = [NSAttributedString.Key.font: font, .paragraphStyle: paragraphStyle, .foregroundColor: NSColor.white, .shadow: shadow]

        dateString.draw(with: CGRect(x: 10, y: -4 - font.pointSize / 2, width: 108, height: 108), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
    }
}
