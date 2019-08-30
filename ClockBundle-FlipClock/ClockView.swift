//
//  ClockView
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright © 2012-2019 Werner Freytag. All rights reserved.
//

import AppKit

class ClockView: NSView {
    private let bundle = Bundle(identifier: "io.pecora.DockTime-ClockBundle-FlipClock")!

    override func draw(_: NSRect) {
        guard let context = currentContext else { return }

        var imageName: String
        var image: NSImage

        context.saveGState()

        image = bundle.image(named: "Background")!
        image.draw(at: .zero, from: .zero, operation: .copy, fraction: 1)

        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short

        let dateString: String! = timeFormatter.string(from: Date())

        let result = dateString.arrayOfCaptureComponentsMatchedByRegex("([0-9])?([0-9])[^0-9]+([0-9]+)([0-9]+)")
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
