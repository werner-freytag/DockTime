//
//  Bundle+Image
//  DockTime
//
//  Created by Werner on 13.07.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

import AppKit

@objc extension Bundle {
    @nonobjc private static var images: [String: [String: NSImage?]] = [:]

    // TODO: Replace with image(named:)
    func imageNamed(_ name: String) -> NSImage? {
        if !Bundle.images.keys.contains(bundlePath) {
            Bundle.images[bundlePath] = [:]
        }
        if !Bundle.images[bundlePath]!.keys.contains(name) {
            Bundle.images[bundlePath]![name] = image(forResource: name)
        }

        return Bundle.images[bundlePath]![name]!
    }
}
