//
//  NSBundle+Compatibility10_6.m
//  DockTime
//
//  Created by Werner on 13.07.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "NSBundle+ImageResource.h"

@implementation NSBundle (ImageResource)

- (NSImage *)imageNamed:(NSString *)name
{
	static NSMutableDictionary *images;

	if ( !images )
		images = [NSMutableDictionary dictionaryWithCapacity:5];
	
	NSMutableDictionary *bundleImages = [images objectForKey:self.bundlePath];
	if ( !bundleImages ) {
		bundleImages = [NSMutableDictionary dictionaryWithCapacity:10];
		[images setObject:bundleImages forKey:self.bundlePath];
	}
	
	NSImage *image = [bundleImages objectForKey:name];
	
	if ( !image ) {
		if ( [self respondsToSelector:@selector(imageForResource:)])
			image = [self imageForResource:name];
		else
			image = [[NSImage alloc] initByReferencingURL:[self URLForImageResource:name]];
		
		[bundleImages setObject:image forKey:name];
	}
	
	return image;
}

@end
