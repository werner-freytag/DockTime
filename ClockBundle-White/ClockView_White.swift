//
//  ClockView_White.m
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

import AppKit

class ClockView_White: NSView {
    private var currentContext: CGContext? {
        if #available(OSX 10.10, *) {
            return NSGraphicsContext.current?.cgContext
        } else if let contextPointer = NSGraphicsContext.current?.graphicsPort {
            return Unmanaged.fromOpaque(contextPointer).takeUnretainedValue()
        }
        return nil
    }

    override func draw(_: NSRect) {
        let bundle = Bundle(identifier: "com.sympnosis.DockTime-ClockBundle-White")!

        var image: NSImage

        guard let context = currentContext else { return }
        context.saveGState()

        image = bundle.imageNamed("Background")!
        image.draw(at: .zero, from: .zero, operation: .copy, fraction: 1)

        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.calendar, .hour, .minute, .second], from: Date())

        context.saveGState()

        context.translateBy(x: 64, y: 64)
        context.concatenate(CGAffineTransform(scaleX: 1, y: -1))
        context.rotate(by: .pi)
        context.setShadow(offset: CGSize(width: 0, height: -1), blur: 3, color: NSColor(deviceRed: 0.25, green: 0.28, blue: 0.32, alpha: 0.5).cgColor)

        context.saveGState()
        context.rotate(by: CGFloat(2) * CGFloat.pi * ((CGFloat(components.hour! % 12) + CGFloat(components.minute!) / 60) / 12))
        image = bundle.imageNamed("HourHand")!
        image.draw(at: CGPoint(x: -image.size.width / 2, y: 0), from: .zero, operation: .sourceOver, fraction: 1)
        context.restoreGState()

        context.saveGState()
        context.rotate(by: CGFloat(2) * .pi * (CGFloat(components.minute!) + CGFloat(components.second!) / 60) / 60)
        image = bundle.imageNamed("MinuteHand")!
        image.draw(at: CGPoint(x: -image.size.width / 2, y: 0), from: NSZeroRect, operation: .sourceOver, fraction: 1.0)
        context.restoreGState()

        context.saveGState()
        context.rotate(by: CGFloat(2) * CGFloat.pi * CGFloat(components.second!) / 60)
        image = bundle.imageNamed("SecondHand")!
        image.draw(at: CGPoint(x: -image.size.width / 2, y: 0), from: .zero, operation: .sourceOver, fraction: 1.0)
        context.restoreGState()

        context.setShadow(offset: CGSize(width: 0, height: -2), blur: 4, color: NSColor(deviceRed: 0.25, green: 0.28, blue: 0.32, alpha: 0.4).cgColor)
        image = bundle.imageNamed("HandsMiddle")!
        image.draw(at: CGPoint(x: -image.size.width / 2, y: -image.size.width / 2), from: .zero, operation: .sourceOver, fraction: 1)
        context.restoreGState()

        image = bundle.imageNamed("Foreground")!
        image.draw(at: .zero, from: .zero, operation: .sourceOver, fraction: 1)

        context.restoreGState()
    }
}
