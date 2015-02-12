//
//  ClockView_Discreet.m
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "ClockView_Discreet.h"
#import "NSColor+CGColor.h"
#import "RegexKitLite.h"
#import "NSBundle+ImageResource.h"

@implementation ClockView_Discreet

- (void)drawRect:(NSRect)dirtyRect {
	
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.sympnosis.DockTime-ClockBundle-Discreet"];
	
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
		[image drawAtPoint:CGPointMake(16, 51) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
	
	imageName = [strings objectAtIndex:2];
	image = [bundle imageNamed:imageName];
	[image drawAtPoint:CGPointMake(38, 51) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];

	image = [bundle imageNamed:@"Separator"];
	[image drawAtPoint:CGPointMake(63, 55) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	imageName = [strings objectAtIndex:3];
	image = [bundle imageNamed:imageName];
	[image drawAtPoint:CGPointMake(71, 51) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	imageName = [strings objectAtIndex:4];
	image = [bundle imageNamed:imageName];
	[image drawAtPoint:CGPointMake(93, 51) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	CGContextRestoreGState(context);
}

@end
