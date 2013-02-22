//
//  DockMenu.m
//  DockTime
//
//  Created by Werner Freytag on 04.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "DockMenu.h"
#import "DockTilePlugIn.h"

#define TAG_BASE			100000
#define NOTIFICATION_NAME	@"de.pecora.iClock.BundleIDChanged"
#define APPLICATION_ID		CFSTR("de.pecora.iClock")

@implementation DockMenu

- (id)init {
	
	if ( ( self = [super initWithTitle:NSLocalizedString(@"Model", Nil)] ) ) {
		
		NSMenuItem *item;
				
		NSUInteger tag = TAG_BASE;
		
		_bundles = [NSArray arrayWithArray:[DockTilePlugIn allClockBundles]];
		
		for ( NSBundle *bundle in _bundles ) {
						
            item = [[NSMenuItem alloc] initWithTitle:[bundle objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey] action:@selector(setTheme:) keyEquivalent:@""];
            item.target = self;
			item.tag = tag;
            [self addItem:item];
			
            tag++;
		}
		
		NSDistributedNotificationCenter *notificationCenter = [NSDistributedNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(updateSelectedMenuItem) name:NOTIFICATION_NAME object:Nil];
		
		[self updateSelectedMenuItem];
	}
	
	return self;
}

- (void)updateSelectedMenuItem {

	CFPreferencesAppSynchronize(APPLICATION_ID);
	
	CFPropertyListRef value = CFPreferencesCopyAppValue(CFSTR("BundleID"), APPLICATION_ID);
	
	NSString *selectedBundleID = (__bridge_transfer NSString *)(CFStringRef)value;
	
	NSUInteger tag = TAG_BASE;
	
	for ( NSBundle *bundle in _bundles ) {
		
		BOOL isOn = [bundle.bundleIdentifier isEqualToString:selectedBundleID];
		
		[[self itemWithTag:tag] setState:isOn];
		
		tag++;
	}
}

- (void)setTheme:(NSMenuItem *)menuItem {

	NSUInteger index = menuItem.tag - TAG_BASE;
	NSBundle *bundle = [_bundles objectAtIndex:index];
	
	CFPreferencesSetAppValue(CFSTR("BundleID"), (__bridge CFStringRef)(bundle.bundleIdentifier), APPLICATION_ID);
    CFPreferencesAppSynchronize(APPLICATION_ID);
	
	[self updateSelectedMenuItem];
	
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME object:nil];
}

- (void)openPrefPane:(NSMenuItem *)menuItem {
    [[NSWorkspace sharedWorkspace] openFile:@"/System/Library/PreferencePanes/DateAndTime.prefPane"];
}

@end
