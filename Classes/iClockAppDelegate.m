//
//  iClockAppDelegate.m
//  iClock
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "iClockAppDelegate.h"
#import "DockMenu.h"

@implementation iClockAppDelegate

- (id)init {
	
	if ( !(self = [super init]) )
		return Nil;
	
	_dockMenu = [[DockMenu alloc] init];
	
	return self;
}

- (NSMenu *)applicationDockMenu:(NSApplication *)sender {
	
	return _dockMenu;
}

@end
