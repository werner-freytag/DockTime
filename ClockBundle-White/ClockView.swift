// The MIT License
//
// Copyright 2012-2021 Werner Freytag
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import AppKit
import CoreGraphics
import QuartzCore.CALayer

class ClockView: NSView {
    // Content box
    let renderBounds = CGRect(x: 0, y: 0, width: 280, height: 280)
    let contentInset = NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    override init(frame: CGRect) {
        handsLayer = HandsLayer()

        super.init(frame: frame)

        wantsLayer = true
        layer = makeBackingLayer()

        guard let layer = layer else { return }

        layer.addSublayer(FaceBackgroundLayer())
        layer.addSublayer(FaceLayer())
        layer.addSublayer(handsLayer)

        let shadow = NSShadow()
        shadow.shadowOffset = .init(width: 0, height: -1.8)
        shadow.shadowBlurRadius = 1.8
        shadow.shadowColor = NSColor.black.withAlphaComponent(0.18)

        self.shadow = shadow
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidMoveToSuperview() {
        updateTransform()
    }

    let handsLayer: HandsLayer!

    override func draw(_ dirtyRect: NSRect) {
        let fractions = Calendar.current.fractions([.hour, .minute, .second, .nanosecond])

        rotateLayer(handsLayer.hourHand, fraction: fractions.hour)
        rotateLayer(handsLayer.minuteHand, fraction: fractions.minute)
        rotateLayer(handsLayer.secondHand, fraction: fractions.second)

        super.draw(dirtyRect)
    }

    private func updateTransform() {
        guard let layer = layer else { return assertionFailure() }

        let scale = CGPoint(
            x: (bounds.width - contentInset.left - contentInset.right) / renderBounds.width,
            y: (bounds.height - contentInset.top - contentInset.bottom) / renderBounds.height
        )

        let transform = CGAffineTransform.identity
            .translatedBy(x: contentInset.left, y: contentInset.bottom)
            .scaledBy(x: scale.x, y: scale.y)
            .scaledBy(x: 1, y: -1)
            .translatedBy(x: 0, y: -renderBounds.height)

        layer.sublayerTransform = CATransform3DMakeAffineTransform(transform)
    }

    private func rotateLayer(_ layer: CALayer, fraction: CGFloat) {
        layer.transform = CATransform3DMakeRotation(CGFloat(2) * .pi * fraction, 0, 0, 100)
    }
}
