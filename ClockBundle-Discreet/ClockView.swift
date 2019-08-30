//
//  ClockView
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright © 2012-2019 Werner Freytag. All rights reserved.
//

import AppKit

class ClockView: NSView {
    private let bundle = Bundle(identifier: "io.pecora.DockTime-ClockBundle-Discreet")!

    override func draw(_: NSRect) {
        guard let context = currentContext else { return }

        var image: NSImage

        context.saveGState()

        image = bundle.image(named: "Background")!
        image.draw(at: .zero, from: .zero, operation: .copy, fraction: 1)

        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short

        let dateString = timeFormatter.string(from: Date())
        let components = dateString.arrayOfCaptureComponentsMatchedByRegex("([0-9])?([0-9])[^0-9]+([0-9]+)([0-9]+)").first!

        if !components[0].isEmpty {
            image = bundle.image(named: components[1])!
            image.draw(at: CGPoint(x: 16, y: 51), from: .zero, operation: .sourceOver, fraction: 1)
        }

        image = bundle.image(named: components[2])!
        image.draw(at: CGPoint(x: 38, y: 51), from: .zero, operation: .sourceOver, fraction: 1)

        image = bundle.image(named: "Separator")!
        image.draw(at: CGPoint(x: 63, y: 55), from: .zero, operation: .sourceOver, fraction: 1)

        image = bundle.image(named: components[3])!
        image.draw(at: CGPoint(x: 71, y: 51), from: .zero, operation: .sourceOver, fraction: 1)

        image = bundle.image(named: components[4])!
        image.draw(at: CGPoint(x: 93, y: 51), from: .zero, operation: .sourceOver, fraction: 1)

        context.restoreGState()
    }
}
