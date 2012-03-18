//
//  iClockAppDelegate.m
//  iClock
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "iClockAppDelegate.h"
#import "DockMenu.h"
#import "DockTilePlugIn.h"

@implementation iClockAppDelegate

- (id)init {
	
	if ( !(self = [super init]) )
		return Nil;
	
	_dockMenu = [[DockMenu alloc] init];
	
	return self;
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
	
	NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:@"" action:Nil keyEquivalent:@""];
	menuItem.submenu = _dockMenu;
	
	[[NSApp mainMenu] addItem:menuItem];
	
	if ( [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSDockTilePlugIn"] == Nil ) {
		
		_dockTilePlugin = [[DockTilePlugIn alloc] init];
		
		[_dockTilePlugin setDockTile:[NSApp dockTile]];
	}	
}

- (NSMenu *)applicationDockMenu:(NSApplication *)sender {
	
	return _dockMenu;
}

@end
