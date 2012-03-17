//
//  ClockView_PinkLady.m
//  iClock
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "ClockView_PinkLady.h"
#import "NSColor+CGColor.h"
#import "RegexKitLite.h"

@implementation ClockView_PinkLady

- (NSString *)title {
	return NSLocalizedString(@"PinkLady", @"Title of the clock view");
}

- (void)drawRect:(NSRect)dirtyRect {
	
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"de.pecora.iClock-ClockBundle-PinkLady"];
	
	NSString *imageName;
	NSImage *image;
	
	CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
	CGContextSaveGState(context);
	
	CGContextScaleCTM( context, self.bounds.size.width/128.0, self.bounds.size.height/128.0);
	
	image = [bundle imageForResource:@"Background.png"];
	[image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
	
	NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
	[timeFormatter setDateStyle:NSDateFormatterNoStyle];
	[timeFormatter setTimeStyle:NSDateFormatterShortStyle];
	
	NSString *dateString = [timeFormatter stringFromDate:[NSDate date]];
	
	NSArray *result = [dateString arrayOfCaptureComponentsMatchedByRegex:@"([0-9])?([0-9])[^0-9]+([0-9]+)([0-9]+)"];
	NSArray *strings = [result objectAtIndex:0];
	
	if ( [[strings objectAtIndex:1] length] > 0 ) {
		imageName = [[strings objectAtIndex:1] stringByAppendingString:@".png"];
		image = [bundle imageForResource:imageName];
		[image drawAtPoint:CGPointMake(23, 33) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
	
	imageName = [[strings objectAtIndex:2] stringByAppendingString:@".png"];
	image = [bundle imageForResource:imageName];
	[image drawAtPoint:CGPointMake(42, 33) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];

	imageName = [[strings objectAtIndex:3] stringByAppendingString:@".png"];
	image = [bundle imageForResource:imageName];
	[image drawAtPoint:CGPointMake(67, 33) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	imageName = [[strings objectAtIndex:4] stringByAppendingString:@".png"];
	image = [bundle imageForResource:imageName];
	[image drawAtPoint:CGPointMake(86, 33) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];

	image = [bundle imageForResource:@"Foreground.png"];
	[image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	CGContextRestoreGState(context);
}

@end
