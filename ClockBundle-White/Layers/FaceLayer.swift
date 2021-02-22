//
//  Created by Werner on 26.01.18.
//  Copyright © 2018-2021 Werner Freytag. All rights reserved.
//

import AppKit.NSFont
import QuartzCore.CALayer

class FaceLayer: CALayer {
    let renderBounds = CGRect(x: 0, y: 0, width: 280, height: 280)

    override init() {
        super.init()
        frame = renderBounds

        addSublayer(FaceLinesLayer(frame: renderBounds))

        addSublayer(NumberLayer(number: 1, at: CGPoint(x: 192, y: 28)))
        addSublayer(NumberLayer(number: 2, at: CGPoint(x: 233, y: 72)))
        addSublayer(NumberLayer(number: 3, at: CGPoint(x: 247, y: 127)))
        addSublayer(NumberLayer(number: 4, at: CGPoint(x: 232, y: 187)))
        addSublayer(NumberLayer(number: 5, at: CGPoint(x: 190, y: 230)))
        addSublayer(NumberLayer(number: 6, at: CGPoint(x: 130, y: 244)))
        addSublayer(NumberLayer(number: 7, at: CGPoint(x: 75, y: 230)))
        addSublayer(NumberLayer(number: 8, at: CGPoint(x: 31, y: 187)))
        addSublayer(NumberLayer(number: 9, at: CGPoint(x: 15, y: 127)))
        addSublayer(NumberLayer(number: 10, at: CGPoint(x: 25, y: 72)))
        addSublayer(NumberLayer(number: 11, at: CGPoint(x: 68, y: 28)))
        addSublayer(NumberLayer(number: 12, at: CGPoint(x: 124, y: 13)))
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class NumberLayer: CAShapeLayer {
    init(number: Int, at: CGPoint) {
        super.init()

        let textAttributes = [NSAttributedString.Key.font: NSFont.boldSystemFont(ofSize: 28)]
        path = NSAttributedString(string: String(number), attributes: textAttributes).cgPath
        position = at
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
