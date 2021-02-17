//
//  UpdateInterval.swift
//  DockTime
//
//  Created by Werner on 17.02.21.
//  Copyright © 2021 Werner Freytag. All rights reserved.
//

import Foundation

enum UpdateInterval {
    case minute
    case second
    case continual
}

extension UpdateInterval {
    init?(_ string: String) {
        switch string.lowercased() {
        case "continual":
            self = .continual
        case "minute":
            self = .minute
        case "second":
            self = .second
        default:
            return nil
        }
    }
}
