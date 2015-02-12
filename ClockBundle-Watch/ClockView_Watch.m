//
//  ClockView_Watch.m
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "ClockView_Watch.h"
#import "NSColor+CGColor.h"
#import "NSBundle+ImageResource.h"

@implementation ClockView_Watch

- (void)drawRect:(NSRect)dirtyRect {
	
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.sympnosis.DockTime-ClockBundle-Watch"];
	
	NSImage *image;
	
	CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
	CGContextSaveGState(context);
	
	CGContextScaleCTM( context, self.bounds.size.width/128.0, self.bounds.size.height/128.0);
	
	image = [bundle imageNamed:@"Background"];
	[image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];

	NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date]];
	
	CGContextSaveGState(context);
	
	CGContextTranslateCTM( context, 64, 64 );
	CGContextConcatCTM(context, CGAffineTransformMakeScale(1,-1));
	CGContextRotateCTM(context, M_PI);
	CGContextSetShadowWithColor( context, CGSizeMake(0.0, -2.0), 3, [[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:.6] CGColor]);
	
	CGContextSaveGState(context);
	CGContextRotateCTM(context, 2 * M_PI * ( ( [components hour] % 12 + (float)[components minute] / 60 ) / 12 ) );
	image = [bundle imageNamed:@"HourHand"];
	[image drawAtPoint:CGPointMake(-image.size.width/2, 0.0) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	CGContextRestoreGState(context);
	
	CGContextSaveGState(context);
	CGContextRotateCTM(context, 2 * M_PI * ( [components minute] + (float)[components second] / 60 ) / 60);
	image = [bundle imageNamed:@"MinuteHand"];
	[image drawAtPoint:CGPointMake(-image.size.width/2, 0.0) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	CGContextRestoreGState(context);
	
	CGContextSetShadowWithColor( context, CGSizeMake(0.0, -1.0), 4, [[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:.5] CGColor]);
	image = [bundle imageNamed:@"HandsMiddle"];
	[image drawAtPoint:CGPointMake(-image.size.width/2,-image.size.width/2) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];

	CGContextSaveGState(context);
	CGContextRotateCTM(context, 2 * M_PI * [components second] / 60);
	image = [bundle imageNamed:@"SecondHand"];
	[image drawAtPoint:CGPointMake(-image.size.width/2, -9.0) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	CGContextRestoreGState(context);
	
	CGContextRestoreGState(context);
	
	CGContextRestoreGState(context);
}

@end
