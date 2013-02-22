//
//  ClockView_Subway.m
//  DockTime
//
//  Created by Werner Freytag on 10.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "ClockView_Subway.h"
#import "NSColor+CGColor.h"
#import "NSBundle+ImageResource.h"

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
	
	image = [bundle imageNamed:@"Background"];
	[image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
	
	NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date]];
	
	imageName = [NSString stringWithFormat:@"%ld", components.hour/10];
	image = [bundle imageNamed:imageName];
	[image drawAtPoint:CGPointMake(21, 50) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	imageName = [NSString stringWithFormat:@"%ld", components.hour%10];
	image = [bundle imageNamed:imageName];
	[image drawAtPoint:CGPointMake(41, 50) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];

	imageName = [NSString stringWithFormat:@"%ld", components.minute/10];
	image = [bundle imageNamed:imageName];
	[image drawAtPoint:CGPointMake(63, 50) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	imageName = [NSString stringWithFormat:@"%ld", components.minute%10];
	image = [bundle imageNamed:imageName];
	[image drawAtPoint:CGPointMake(83, 50) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	image = [bundle imageNamed:@"Dot"];
	
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
