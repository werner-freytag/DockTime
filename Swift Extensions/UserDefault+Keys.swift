//
//  UserDefault+Keys.swift
//  DockTime
//
//  Created by Werner Freytag on 30.08.19.
//  Copyright © 2019 Werner Freytag. All rights reserved.
//

import Foundation

extension UserDefaults {
    struct Key {
        static let selectedClockBundle = "SelectedClockBundle"
    }

    var selectedClockBundle: String? {
        set {
            setValue(newValue, forKey: Key.selectedClockBundle)
        }

        get {
            return string(forKey: Key.selectedClockBundle)
        }
    }
}
