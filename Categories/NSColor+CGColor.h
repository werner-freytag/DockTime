//
//  NSColor+CGColor.h
//  iClock
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (CGColor)

+ (NSColor *)colorWithCGColor:(CGColorRef)aColorRef;
- (CGColorRef)CGColor;

@end
