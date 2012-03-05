//
//  DockTilePlugIn.m
//  DockClock
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "DockTilePlugIn.h"
#import "ClockView.h"
#import "DockMenu.h"

@implementation DockTilePlugIn

- (void)finalize {
	NSLog(@"dealloc");
	[super finalize];
}

- (void)setDockTile:(NSDockTile*)dockTile {
	
	NSLog(@"set dock tile: %@", dockTile);
	
	_dockTile = dockTile;
	
	if ( dockTile ) {
		
		[dockTile setContentView:[[ClockView alloc] init]];
		[NSTimer scheduledTimerWithTimeInterval:.2 target:dockTile selector:@selector(display) userInfo:Nil repeats:YES];
	}
	else {
		[dockTile setContentView:nil];
		[NSApp terminate:nil];
	}
	
}

- (NSMenu*)dockMenu {
	return [[DockMenu alloc] initWithTarget:self];
}

- (void)setTheme:(NSMenuItem *)menuItem {
	NSLog(@"set theme plugin: %ld", menuItem.tag);
}

- (void)openPrefPane:(NSMenuItem *)menuItem {
	NSLog(@"Open prefs plugin");
    [[NSWorkspace sharedWorkspace] openFile:@"/System/Library/PreferencePanes/DateAndTime.prefPane"];
}

@end
