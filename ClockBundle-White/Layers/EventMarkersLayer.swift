//
//  HandsLayer.swift
//  Time
//
//  Created by Werner on 26.01.18.
//  Copyright © 2018 Werner Freytag. All rights reserved.
//

import EventKit
import QuartzCore.CALayer

class EventMarkersLayer: CALayer {
    let renderBounds = CGRect(x: 0, y: 0, width: 280, height: 280)

    typealias Marker = (from: CGFloat, to: CGFloat)

    var markers: [Marker] = [] {
        didSet {
            DispatchQueue.main.async {
                self.refreshMarkers()
            }
        }
    }

    override init() {
        super.init()
        frame = renderBounds
        backgroundColor = Color(red: 0.4, green: 0.45, blue: 0.5, alpha: 0.8).cgColor
        drawsAsynchronously = true
        mask = CALayer()

        let lines = FaceLinesLayer(frame: bounds)
        lines.fillColor = Color.white.cgColor
        addSublayer(lines)
    }

    override convenience init(layer: Any) {
        self.init()
        guard let layer = layer as? EventMarkersLayer else { return }

        markers = layer.markers
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func refreshMarkers() {
        for sublayer in sublayers ?? [] where sublayer is MarkerLayer {
            sublayer.removeFromSuperlayer()
        }

        let mask = CALayer()
        for marker in markers {
            let layer = MarkerLayer(marker: marker, at: CGPoint(x: bounds.midX, y: bounds.midY))
            mask.addSublayer(layer)
        }

        self.mask = mask
    }
}

private class MarkerLayer: CAShapeLayer {
    typealias Marker = EventMarkersLayer.Marker

    private let center: CGPoint
    private let marker: Marker

    var radius = CGFloat(77.25) {
        didSet {
            refreshPath()
        }
    }

    init(marker: Marker, at center: CGPoint) {
        self.center = center
        self.marker = marker
        super.init()

        fillColor = nil
        strokeColor = Color(white: 0, alpha: 1).cgColor
        lineWidth = 12

        refreshPath()
    }

    func refreshPath() {
        let distance = marker.to - marker.from
        strokeEnd = distance - floor(distance)
        strokeEnd = min(0.98, strokeEnd)

        let rect = CGRect(origin: CGPoint(x: -radius, y: -radius), size: CGSize(width: radius * 2, height: radius * 2))
        let transform = CGAffineTransform.identity
            .translatedBy(x: center.x, y: center.y)
            .rotated(by: (marker.from - 0.25) * 2 * .pi)
        path = CGPath(ellipseIn: rect, transform: nil)

        mask = MaskLayer()

        setAffineTransform(transform)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class MaskGradientLayer: CAGradientLayer {
    let renderBounds = CGRect(x: 0, y: -120, width: 140, height: 105)

    override init() {
        super.init()
        frame = renderBounds

        colors = [Color.white.cgColor, Color.white.withAlphaComponent(0).cgColor]
        locations = [0.5, 1]
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class MaskLayer: CAShapeLayer {
    let renderBounds = CGRect(x: 0, y: 0, width: 280, height: 280)

    override init() {
        super.init()
        frame = renderBounds

        let bezier = BezierPath()
        bezier.appendRect(CGRect(x: -renderBounds.midX, y: -5, width: renderBounds.width, height: renderBounds.midY))
        bezier.appendRect(CGRect(x: -renderBounds.midX, y: -renderBounds.midY, width: renderBounds.midY, height: renderBounds.height))

        path = bezier.cgPath

        addSublayer(MaskGradientLayer())
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
