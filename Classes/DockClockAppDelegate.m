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

- (void)setTheme:(NSMenuItem *)menuItem {
	NSLog(@"set theme main: %ld", menuItem.tag);
}

- (void)openPrefPane:(NSMenuItem *)menuItem {
	NSLog(@"Open prefs main");
    [[NSWorkspace sharedWorkspace] openFile:@"/System/Library/PreferencePanes/DateAndTime.prefPane"];
}


@end
