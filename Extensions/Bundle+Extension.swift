//
//  Bundle+Tools.swift
//  DockTime
//
//  Created by Werner Freytag on 29.08.19.
//  Copyright © 2019 Pecora GmbH. All rights reserved.
//

import Foundation

extension Bundle {
    static var plugin: Bundle = {
        if let bundle = Bundle(identifier: "com.sympnosis.DockTime-DockTilePlugin") { return bundle }

        let path = Bundle.path(forResource: "DockTilePlugin", ofType: "docktileplugin", inDirectory: Bundle.main.builtInPlugInsPath!)!
        return Bundle(path: path)!
    }()

    class var allClockBundles: [Bundle] {
        return Bundle.paths(forResourcesOfType: "clockbundle", inDirectory: Bundle.plugin.builtInPlugInsPath!).compactMap { Bundle(path: $0) }
    }
}
