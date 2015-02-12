//
//  ClockView_FlipClock.m
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "ClockView_FlipClock.h"
#import "NSColor+CGColor.h"
#import "RegexKitLite.h"
#import "NSBundle+ImageResource.h"

@implementation ClockView_FlipClock

- (NSString *)title {
	return NSLocalizedString(@"FlipClock", @"Title of the clock view");
}

- (void)drawRect:(NSRect)dirtyRect {
	
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.sympnosis.DockTime-ClockBundle-FlipClock"];
	
	NSString *imageName;
	NSImage *image;
	
	CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
	CGContextSaveGState(context);
		
	image = [bundle imageNamed:@"Background"];
	[image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
	
	NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
	[timeFormatter setDateStyle:NSDateFormatterNoStyle];
	[timeFormatter setTimeStyle:NSDateFormatterShortStyle];
	
	NSString *dateString = [timeFormatter stringFromDate:[NSDate date]];
	
	NSArray *result = [dateString arrayOfCaptureComponentsMatchedByRegex:@"([0-9])?([0-9])[^0-9]+([0-9]+)([0-9]+)"];
	NSArray *strings = [result objectAtIndex:0];
	
	if ( [[strings objectAtIndex:1] length] > 0 ) {
		imageName = [strings objectAtIndex:1];
		image = [bundle imageNamed:imageName];
		[image drawAtPoint:CGPointMake(17, 44) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];

		imageName = [strings objectAtIndex:2];
		image = [bundle imageNamed:imageName];
		[image drawAtPoint:CGPointMake(38, 44) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
	else {
		imageName = [strings objectAtIndex:2];
		image = [bundle imageNamed:imageName];
		[image drawAtPoint:CGPointMake(29, 44) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
	
	imageName = [strings objectAtIndex:3];
	image = [bundle imageNamed:imageName];
	[image drawAtPoint:CGPointMake(72, 44) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	imageName = [strings objectAtIndex:4];
	image = [bundle imageNamed:imageName];
	[image drawAtPoint:CGPointMake(92, 44) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];

	image = [bundle imageNamed:@"Foreground"];
	[image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	CGContextRestoreGState(context);
}

@end
