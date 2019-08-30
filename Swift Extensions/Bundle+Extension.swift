//
//  Bundle+Tools.swift
//  DockTime
//
//  Created by Werner Freytag on 29.08.19.
//  Copyright © 2019 Pecora GmbH. All rights reserved.
//

import Foundation

extension Bundle {
    class var allClockBundles: [Bundle] {
        return Bundle.paths(forResourcesOfType: "clockbundle", inDirectory: Bundle.main.builtInPlugInsPath!).compactMap { Bundle(path: $0) }
    }
}
