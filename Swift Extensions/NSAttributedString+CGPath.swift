// The MIT License
//
// Copyright 2014-2021 Werner Freytag
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

import CoreGraphics
import CoreText
import Foundation

extension NSAttributedString {
    var cgPath: CGPath {
        let letters = CGMutablePath()
        let line = CTLineCreateWithAttributedString(self)
        let runArray = CTLineGetGlyphRuns(line) as! [CTRun]

        for run in runArray {
            let attributes = CTRunGetAttributes(run) as Dictionary
            let runFont = attributes[kCTFontAttributeName] as! CTFont

            for runGlyphIndex in 0 ..< CTRunGetGlyphCount(run) {
                let glyphRange = CFRangeMake(runGlyphIndex, 1)

                var glyph: CGGlyph = 0
                var position: CGPoint = .zero

                CTRunGetGlyphs(run, glyphRange, &glyph)
                CTRunGetPositions(run, glyphRange, &position)

                let letter = CTFontCreatePathForGlyph(runFont, glyph, nil)!
                let t = CGAffineTransform(translationX: position.x, y: position.y)
                letters.addPath(letter, transform: t)
            }
        }

        var t = CGAffineTransform(scaleX: 1, y: -1)
            .translatedBy(x: 0, y: -letters.boundingBox.size.height)

        return withUnsafePointer(to: &t) {
            letters.copy(using: $0)
        }!
    }
}
