//
//  DockMenu.m
//  DockClock
//
//  Created by Werner Freytag on 04.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "DockMenu.h"

@implementation DockMenu

- (id)initWithTarget:(id)target {
	
	if ( ( self = [super initWithTitle:@""] ) ) {
		
		NSMenuItem *item;
		
		item = [[NSMenuItem alloc] initWithTitle:@"Open Date And Time" action:@selector(openPrefPane:) keyEquivalent:@""];
		item.target = target;
		[self addItem:item];
		
		[self addItem:[NSMenuItem separatorItem]];
		
		item = [[NSMenuItem alloc] initWithTitle:@"Theme 1" action:@selector(setTheme:) keyEquivalent:@""];
		item.target = target;
		item.tag = THEME_1;
		[self addItem:item];
		
		item = [[NSMenuItem alloc] initWithTitle:@"Theme 2" action:@selector(setTheme:) keyEquivalent:@""];
		item.target = target;
		item.tag = THEME_2;
		[self addItem:item];
	}
	
	return self;
}

@end
