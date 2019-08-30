//
//  ClockView
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

import AppKit

class ClockView: NSView {
    private let bundle = Bundle(identifier: "io.pecora.DockTime-ClockBundle-White")!

    override func draw(_: NSRect) {
        guard let context = currentContext else { return }

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
