//
//  NSView+CGContext.swift
//  ClockBundle-Subway
//
//  Created by Werner Freytag on 30.08.19.
//  Copyright © 2019 Pecora GmbH. All rights reserved.
//

import AppKit

extension NSView {
    var currentContext: CGContext? {
        if #available(OSX 10.10, *) {
            return NSGraphicsContext.current?.cgContext
        } else if let contextPointer = NSGraphicsContext.current?.graphicsPort {
            return Unmanaged.fromOpaque(contextPointer).takeUnretainedValue()
        }
        return nil
    }
}
