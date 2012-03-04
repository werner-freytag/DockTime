//
//  WindowContentView.m
//  DockClock
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "NSColor+CGColor.h"
#import "ClockView.h"


@implementation ClockView

- (id)init {
	
	if ( ( self = [super initWithFrame:NSMakeRect(0, 0, 256, 256)] ) ) {
	}
	
	return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"de.pecora.Dock-Tile-Plug-in"];
	
	NSImage *image;
	
	[[NSColor greenColor] setFill];
	NSRectFill(NSMakeRect(0, 0, 128, 128));
	
	CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
	CGContextSaveGState(context);
	
	CGContextScaleCTM( context, self.bounds.size.width/256.0, self.bounds.size.height/256.0);
	
	image = [bundle imageForResource:@"Background.png"];
	[image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];

	NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date]];
	
	CGContextSaveGState(context);
	
	CGContextTranslateCTM( context, 128, 128 );
	CGContextConcatCTM(context, CGAffineTransformMakeScale(1,-1));
	CGContextRotateCTM(context, M_PI);
	CGContextSetShadowWithColor( context, CGSizeMake(0.0, -2.0), 3, [[NSColor colorWithDeviceRed:.25 green:.28 blue:.32 alpha:.5] CGColor]);
	
	CGContextSaveGState(context);
	CGContextRotateCTM(context, 2 * M_PI * ( ( [components hour] % 12 + (float)[components minute] / 60 ) / 12 ) );
	image = [bundle imageForResource:@"HourHand.png"];
	[image drawAtPoint:CGPointMake(-image.size.width/2,0) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	CGContextRestoreGState(context);
	
	CGContextSaveGState(context);
	CGContextRotateCTM(context, 2 * M_PI * ( [components minute] + (float)[components second] / 60 ) / 60);
	image = [bundle imageForResource:@"MinuteHand.png"];
	[image drawAtPoint:CGPointMake(-image.size.width/2,0) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	CGContextRestoreGState(context);
	
	CGContextSaveGState(context);
	CGContextRotateCTM(context, 2 * M_PI * [components second] / 60);
	image = [bundle imageForResource:@"SecondHand.png"];
	[image drawAtPoint:CGPointMake(-image.size.width/2,0) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	CGContextRestoreGState(context);
	
	CGContextSetShadowWithColor( context, CGSizeMake(0.0, -2.0), 4, [[NSColor colorWithDeviceRed:.25 green:.28 blue:.32 alpha:.4] CGColor]);
	image = [bundle imageForResource:@"HandsMiddle.png"];
	[image drawAtPoint:CGPointMake(-image.size.width/2,-image.size.width/2) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	CGContextRestoreGState(context);
	
	image = [bundle imageForResource:@"Foreground.png"];
	[image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	CGContextRestoreGState(context);
}

@end
