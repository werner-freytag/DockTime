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

- (void)setDockTile:(NSDockTile*)dockTile {
	
	_dockTile = dockTile;
	
	if ( !dockTile )
		exit(0);
	
	[dockTile setContentView:[[ClockView alloc] init]];
	[NSTimer scheduledTimerWithTimeInterval:.2 target:dockTile selector:@selector(display) userInfo:Nil repeats:YES];
	
	NSLog(@"set dock tile: %@", dockTile);
}

- (NSMenu*)dockMenu {
	return [[DockMenu alloc] initWithTarget:self];
}

- (void)setTheme:(NSMenuItem *)menuItem {
	NSLog(@"%ld", menuItem.tag);
}

- (void)openPrefPane:(NSMenuItem *)menuItem {
	NSLog(@"Open prefs plugin");
	return;
    [[NSWorkspace sharedWorkspace] openFile:@"/System/Library/PreferencePanes/DateAndTime.prefPane"];
}

@end
