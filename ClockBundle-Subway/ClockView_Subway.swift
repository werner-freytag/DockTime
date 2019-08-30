//
//  ClockView_Subway.m
//  DockTime
//
//  Created by Werner Freytag on 10.03.12.
//  Copyright © 2012-2019 Werner Freytag. All rights reserved.
//

import AppKit

class ClockView_Subway: NSView {
    private let bundle = Bundle(identifier: "com.sympnosis.DockTime-ClockBundle-Subway")!

    override func draw(_: NSRect) {
        guard let context = currentContext else { return }

        var imageName: String
        var image: NSImage

        context.saveGState()

        image = bundle.image(named: "Background")!
        image.draw(at: .zero, from: .zero, operation: .copy, fraction: 1)

        let currentCalendar = Calendar.current
        let components = currentCalendar.dateComponents([.hour, .minute, .second], from: Date())

        imageName = String(format: "%ld", components.hour! / 10)
        image = bundle.image(named: imageName)!
        image.draw(at: CGPoint(x: 21, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

        imageName = String(format: "%ld", components.hour! % 10)
        image = bundle.image(named: imageName)!
        image.draw(at: CGPoint(x: 41, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

        imageName = String(format: "%ld", components.minute! / 10)
        image = bundle.image(named: imageName)!
        image.draw(at: CGPoint(x: 63, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

        imageName = String(format: "%ld", components.minute! % 10)
        image = bundle.image(named: imageName)!
        image.draw(at: CGPoint(x: 83, y: 50), from: .zero, operation: .sourceOver, fraction: 1)

        image = bundle.image(named: "Dot")!

        for i in stride(from: 0, to: 60, by: 5) {
            let angle = CGFloat.pi * 2 / 60 * CGFloat(i)
            let x = sin(angle) * 52
            let y = cos(angle) * 52
            image.draw(at: CGPoint(x: 62.0 + x, y: 64.0 + y), from: .zero, operation: .sourceOver, fraction: 1)
        }

        for i in 0 ... components.second! {
            let angle = CGFloat.pi * 2 / 60 * CGFloat(i)
            let x = sin(angle) * 48
            let y = cos(angle) * 48
            image.draw(at: CGPoint(x: 62.0 + x, y: 64.0 + y), from: .zero, operation: .sourceOver, fraction: 1)
        }

        context.restoreGState()
    }
}
