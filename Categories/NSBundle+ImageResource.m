//
//  NSBundle+Compatibility10_6.m
//  iClock
//
//  Created by Werner on 13.07.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "NSBundle+ImageResource.h"

@implementation NSBundle (ImageResource)

- (NSImage *)imageNamed:(NSString *)name
{
	if ( [self respondsToSelector:@selector(imageForResource:)])
		return [self imageForResource:name];
	
	return [[NSImage alloc] initByReferencingURL:[self URLForImageResource:name]];
}

@end
