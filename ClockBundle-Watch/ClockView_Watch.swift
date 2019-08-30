//
//  ClockView_Watch.m
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright © 2012-2019 Werner Freytag. All rights reserved.
//

import AppKit

class ClockView_Watch: NSView {
    private let bundle = Bundle(identifier: "com.sympnosis.DockTime-ClockBundle-Watch")!

    override func draw(_: NSRect) {
        guard let context = currentContext else { return }

        var image: NSImage

        context.saveGState()

        image = bundle.image(named: "Background")!
        image.draw(at: .zero, from: .zero, operation: .copy, fraction: 1)

        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.hour, .minute, .second], from: Date())

        context.saveGState()

        context.translateBy(x: 64, y: 64)
        context.scaleBy(x: 1, y: -1)
        context.rotate(by: .pi)
        context.setShadow(offset: CGSize(width: 0, height: -1), blur: 1, color: NSColor(deviceRed: 0, green: 0, blue: 0, alpha: 0.3).cgColor)

        context.saveGState()
        context.rotate(by: CGFloat(2) * .pi * ((CGFloat(components.hour! % 12) + CGFloat(components.minute!) / 60) / 12))
        image = bundle.image(named: "HourHand")!
        image.draw(at: CGPoint(x: -image.size.width / 2, y: 1.0), from: .zero, operation: .sourceOver, fraction: 1)
        context.restoreGState()

        context.saveGState()
        context.rotate(by: CGFloat(2) * .pi * (CGFloat(components.minute!) + CGFloat(components.second!) / 60) / 60)
        image = bundle.image(named: "MinuteHand")!
        image.draw(at: CGPoint(x: -image.size.width / 2, y: 1.0), from: .zero, operation: .sourceOver, fraction: 1)
        context.restoreGState()

        context.saveGState()
        context.rotate(by: CGFloat(2) * .pi * CGFloat(components.second!) / 60)
        image = bundle.image(named: "SecondHand")!
        image.draw(at: CGPoint(x: -image.size.width / 2, y: -8.5), from: .zero, operation: .sourceOver, fraction: 1)
        context.restoreGState()

        context.restoreGState()

        context.restoreGState()
    }
}
