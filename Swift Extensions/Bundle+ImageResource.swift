//
//  NSBundle+Compatibility10_6.m
//  DockTime
//
//  Created by Werner on 13.07.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

import AppKit

@objc extension Bundle {
    private static var images: [String: [String: NSImage]] = [:]

    @objc(imageNamed:)
    func image(named _: String) -> NSImage? {
        if Bundle.images[bundlePath] == nil {
            Bundle.images[bundlePath] = [:]
        }

        if Bundle.images[bundlePath] == nil {
            Bundle.images[bundlePath] = [:]
        }
//
//        var bundleImages:[String: NSImage] = Bundle.images[bundlePath]!
//
//        var image: NSImage! = bundleImages.objectForKey(name)
//
//        if image == nil {
//            if respondsToSelector(Selector("imageForResource:")) {
//                image = imageForResource(name)
//            }
//            else {
//                image = NSImage.initByReferencingURL(URLForImageResource(name))
//            }
//
//            bundleImages.setObject(image, forKey: name)
//        }

        return nil
    }
}
