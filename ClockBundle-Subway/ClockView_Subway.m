//
//  ClockView_Subway.m
//  iClock
//
//  Created by Werner Freytag on 10.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "ClockView_Subway.h"
#import "NSColor+CGColor.h"

@implementation ClockView_Subway

- (NSString *)title {
	return NSLocalizedString(@"Subway", @"Title of the clock view");
}

- (void)drawRect:(NSRect)dirtyRect {
	
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"de.pecora.iClock-ClockBundle-Subway"];
	
	NSString *imageName;
	NSImage *image;
	
	CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
	CGContextSaveGState(context);
	
	CGContextScaleCTM( context, self.bounds.size.width/128.0, self.bounds.size.height/128.0);
	
	image = [bundle imageForResource:@"Background.png"];
	[image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
	
	NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date]];
	
	imageName = [NSString stringWithFormat:@"%d.png", components.hour/10];
	image = [bundle imageForResource:imageName];
	[image drawAtPoint:CGPointMake(22, 50) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	imageName = [NSString stringWithFormat:@"%d.png", components.hour%10];
	image = [bundle imageForResource:imageName];
	[image drawAtPoint:CGPointMake(42, 50) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];

	imageName = [NSString stringWithFormat:@"%d.png", components.minute/10];
	image = [bundle imageForResource:imageName];
	[image drawAtPoint:CGPointMake(64, 50) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	imageName = [NSString stringWithFormat:@"%d.png", components.minute%10];
	image = [bundle imageForResource:imageName];
	[image drawAtPoint:CGPointMake(84, 50) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	image = [bundle imageForResource:@"Dot.png"];
	
	for ( int i = 0; i < 60; i+=5 ) {
		float angle = M_PI * 2 / 60 * i;
		float x = sinf(angle) * 52;
		float y = cosf(angle) * 52;
		[image drawAtPoint:CGPointMake(62.0 + x, 64.0 + y) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
	
	for ( int i = 0; i <= components.second; ++i ) {
		float angle = M_PI * 2 / 60 * i;
		float x = sinf(angle) * 48;
		float y = cosf(angle) * 48;
		[image drawAtPoint:CGPointMake(62.0 + x, 64.0 + y) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
	
	CGContextRestoreGState(context);
}

@end
