//
//  Created by Werner on 04.02.18.
//  Copyright © 2018-2021 Werner Freytag. All rights reserved.
//

import AppKit.NSBezierPath
import QuartzCore.CAShapeLayer

class FaceLinesLayer: CAShapeLayer {
    init(frame: CGRect) {
        super.init()

        let lineOuter = frame.width * 0.29
        let lineLength = frame.width * 0.028

        let bezierPath = NSBezierPath()

        for minute in 0 ..< 5 {
            for hour in 0 ..< 12 {
                let stroke: CGFloat = minute == 0 ? 3 : 0.75
                let rect = NSBezierPath(rect: CGRect(x: -stroke / 2, y: -lineOuter, width: stroke, height: lineLength))
                let transform = CGAffineTransform(translationX: frame.midX, y: frame.midY)
                    .rotated(by: 6 * (5 * CGFloat(hour) + CGFloat(minute)) * .pi / 180)
                rect.apply(transform)

                bezierPath.append(rect)
            }
        }

        path = bezierPath.cgPath
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
