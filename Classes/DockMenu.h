//
//  DockMenu.h
//  DockTime
//
//  Created by Werner Freytag on 04.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define THEME_1 10001
#define THEME_2 10002

@interface DockMenu : NSMenu {
	NSArray *_bundles;
}

- (id)init;

- (void)setTheme:(NSMenuItem *)menuItem;
- (void)openPrefPane:(NSMenuItem *)menuItem;

@end
