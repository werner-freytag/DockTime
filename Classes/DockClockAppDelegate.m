//
//  DockClockAppDelegate.m
//  DockClock
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "DockClockAppDelegate.h"
#import "DockMenu.h"
#import "ClockView.h"

@implementation DockClockAppDelegate

/*
 - (void)setDockTile:(NSDockTile*)dockTile {
 
 [_dockTile release];
 _dockTile = [dockTile retain];
 
 if ( dockTile ) {
 [dockTile setContentView:self];
 [NSTimer scheduledTimerWithTimeInterval:.2 target:dockTile selector:@selector(display) userInfo:Nil repeats:YES];
 }
 
 NSLog(@"set dock tile: %@", dockTile);
 }
 


- (NSMenu*)dockMenu {
	return [[DockMenu alloc] ini
			}
			
			- (void)setTheme:(NSMenuItem *)menuItem {
				NSLog(@"%ld", menuItem.tag);
			}
			@end
			
			
			
			



- (NSMenu *)applicationDockMenu:(NSApplication *)sender {
	
	return [[[DockMenu alloc] initWithTarget:self] autorelease];
}

*/

- (void)setTheme:(NSMenuItem *)menuItem {
	NSLog(@"Theme: %ld", menuItem.tag);
}

- (void)openPrefPane:(NSMenuItem *)menuItem {
	NSLog(@"Open prefs 1");
	return;
    [[NSWorkspace sharedWorkspace] openFile:@"/System/Library/PreferencePanes/DateAndTime.prefPane"];
}


@end
