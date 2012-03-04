//
//  NSColor+CGColor.m
//  DockClock
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "NSColor+CGColor.h"

@implementation NSColor (CGColor)

+ (NSColor *)colorWithCGColor:(CGColorRef)aColorRef {
	
	NSColorSpace *colorSpace = [[NSColorSpace alloc] initWithCGColorSpace:CGColorGetColorSpace(aColorRef)];	
	NSColor *color = [NSColor colorWithColorSpace:colorSpace
									   components:CGColorGetComponents(aColorRef)
											count:CGColorGetNumberOfComponents(aColorRef)];
	return color;
}

- (CGColorRef)CGColor {
    const NSInteger numberOfComponents = [self numberOfComponents];
    CGFloat components[numberOfComponents];
    CGColorSpaceRef colorSpace = [[self colorSpace] CGColorSpace];
	
    [self getComponents:(CGFloat *)&components];
	
    return CGColorCreate(colorSpace, components);
}

@end
