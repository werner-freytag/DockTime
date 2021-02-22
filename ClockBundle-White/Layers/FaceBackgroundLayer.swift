//
//  Created by Werner on 02.02.18.
//  Copyright © 2018-2021 Werner Freytag. All rights reserved.
//

import AppKit.NSBezierPath
import QuartzCore.CAGradientLayer

class FaceBackgroundLayer: CAGradientLayer {
    let renderBounds = CGRect(x: 0, y: 0, width: 280, height: 280)

    override init() {
        super.init()
        frame = renderBounds

        colors = [NSColor(white: 1, alpha: 1).cgColor, NSColor(white: 0.93, alpha: 0.9).cgColor]

        let maskLayer = CAShapeLayer()
        maskLayer.path = NSBezierPath(ovalIn: frame).cgPath

        mask = maskLayer
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
