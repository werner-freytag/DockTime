// The MIT License
//
// Copyright 2021 Werner Freytag
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

import Foundation

extension Calendar {
    func fractions(_ components: Set<Calendar.Component> = [.hour, .minute, .second, .nanosecond], from date: Date = .init()) -> (hour: CGFloat, minute: CGFloat, second: CGFloat) {
        let components = dateComponents(components, from: date)

        let secondFraction = (CGFloat(components.second ?? 0) + CGFloat(components.nanosecond ?? 0) / 1_000_000_000) / 60
        let minuteFraction = (CGFloat(components.minute ?? 0) + secondFraction) / 60
        let hourFraction = (CGFloat(components.hour ?? 0 % 12) + minuteFraction) / 12

        return (hour: hourFraction, minute: minuteFraction, second: secondFraction)
    }
}
