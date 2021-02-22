//
//  Created by Werner on 26.01.18.
//  Copyright © 2018-2021 Werner Freytag. All rights reserved.
//

import AppKit.NSBezierPath
import QuartzCore.CALayer

class HandsLayer: CALayer {
    private(set) var hourHand: CALayer = HourHandLayer()
    private(set) var minuteHand: CALayer = MinuteHandLayer()
    private(set) var secondHand: CALayer = SecondHandLayer()
    private(set) var handsMiddle: CALayer = HandsMiddleLayer()

    override init() {
        super.init()

        frame = CGRect(x: 0, y: 0, width: 280, height: 280)
        shadowOffset = CGSize(width: 0, height: 3)
        shadowRadius = 1
        shadowOpacity = 0.1

        for sublayer in [hourHand, minuteHand, secondHand, handsMiddle] {
            sublayer.position = CGPoint(x: frame.midX, y: frame.midY)
            addSublayer(sublayer)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }
}

private class HourHandLayer: CAShapeLayer {
    override init() {
        super.init()

        let bezier = NSBezierPath()
        bezier.move(to: CGPoint(x: -3, y: 0))
        bezier.addLine(to: CGPoint(x: -3, y: -75))
        bezier.addLine(to: CGPoint(x: 0, y: -80))
        bezier.addLine(to: CGPoint(x: 3, y: -75))
        bezier.addLine(to: CGPoint(x: 3, y: 0))
        bezier.close()

        path = bezier.cgPath
        fillColor = NSColor.black.cgColor
    }

    override convenience init(layer _: Any) {
        self.init()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class MinuteHandLayer: CAShapeLayer {
    override init() {
        super.init()

        let bezier = NSBezierPath()
        bezier.move(to: CGPoint(x: 0, y: -104))
        bezier.addLine(to: .zero)

        path = bezier.cgPath
        strokeColor = NSColor.black.cgColor
        lineWidth = 5
    }

    override convenience init(layer _: Any) {
        self.init()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class SecondHandLayer: CAShapeLayer {
    override init() {
        super.init()

        let bezier = NSBezierPath()
        bezier.move(to: CGPoint(x: 0, y: -105))
        bezier.addLine(to: .zero)

        path = bezier.cgPath
        strokeColor = NSColor(red: 213 / 255, green: 7 / 255, blue: 0, alpha: 1).cgColor
        lineWidth = 2
    }

    override convenience init(layer _: Any) {
        self.init()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class HandsMiddleLayer: CAShapeLayer {
    override init() {
        super.init()

        let bezier = NSBezierPath(ovalIn: CGRect(x: -10, y: -10, width: 20, height: 20))
        path = bezier.cgPath
    }

    override convenience init(layer _: Any) {
        self.init()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
