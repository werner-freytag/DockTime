//
//  ClockView_Digital.m
//  iClock
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "ClockView_Digital.h"
#import "NSColor+CGColor.h"
#import "RegexKitLite.h"

@implementation ClockView_Digital

- (void)drawRect:(NSRect)dirtyRect {
	
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"de.pecora.iClock-ClockBundle-Digital"];
	
	NSString *imageName;
	NSImage *image;
	
	CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
	CGContextSaveGState(context);
	
	CGContextScaleCTM( context, self.bounds.size.width/128.0, self.bounds.size.height/128.0);
	
	image = [bundle imageForResource:@"Background"];
	[image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
	
	NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
	[timeFormatter setDateStyle:NSDateFormatterNoStyle];
	[timeFormatter setTimeStyle:NSDateFormatterShortStyle];
	
	NSString *dateString = [timeFormatter stringFromDate:[NSDate date]];
	
	NSArray *result = [dateString arrayOfCaptureComponentsMatchedByRegex:@"([0-9])?([0-9])[^0-9]+([0-9]+)([0-9]+)"];
	NSArray *strings = [result objectAtIndex:0];
	
	if ( [[strings objectAtIndex:1] length] > 0 ) {
		imageName = [strings objectAtIndex:1];
		image = [bundle imageForResource:imageName];
		[image drawAtPoint:CGPointMake(21, 33) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
	
	imageName = [strings objectAtIndex:2];
	image = [bundle imageForResource:imageName];
	[image drawAtPoint:CGPointMake(41, 33) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];

	imageName = [strings objectAtIndex:3];
	image = [bundle imageForResource:imageName];
	[image drawAtPoint:CGPointMake(68, 33) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	imageName = [strings objectAtIndex:4];
	image = [bundle imageForResource:imageName];
	[image drawAtPoint:CGPointMake(88, 33) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	image = [bundle imageForResource:@"Separator"];
	[image drawAtPoint:CGPointMake(60, 51) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
		
	CGContextRestoreGState(context);
}

@end
