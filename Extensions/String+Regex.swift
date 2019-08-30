//
//  String+Regex.swift
//  ClockBundle-Discreet
//
//  Created by Werner Freytag on 30.08.19.
//  Copyright © 2019 Pecora GmbH. All rights reserved.
//

import Foundation

@objc extension NSString {
    func arrayOfCaptureComponentsMatchedByRegex(_ string: String) -> [[String]] {
        let regex = try! NSRegularExpression(pattern: string, options: [])
        let result = regex.matches(in: self as String, options: [], range: NSMakeRange(0, length))
        return result.map { result in
            (0 ..< result.numberOfRanges).map {
                (self as NSString).substring(with: result.range(at: $0))
            }
        }
    }
}
