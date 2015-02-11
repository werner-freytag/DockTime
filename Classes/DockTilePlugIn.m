//
//  DockTilePlugIn.m
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import "DockTilePlugIn.h"
#import "DockMenu.h"

#define NOTIFICATION_NAME	@"de.pecora.iClock.BundleIDChanged"
#define APPLICATION_ID		CFSTR("de.pecora.iClock")
#define DEFAULT_BUNDLE_ID	CFSTR("de.pecora.iClock-ClockBundle-xxx")

@implementation DockTilePlugIn

- (void)setDockTile:(NSDockTile*)dockTile {
	
	if ( dockTile ) {
		
		_dockTile = dockTile;
		
		NSDistributedNotificationCenter *notificationCenter = [NSDistributedNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(updateCurrentClockBundle) name:NOTIFICATION_NAME object:Nil];
		
		[self updateCurrentClockBundle];
		
		_refreshTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(refreshDockTile) userInfo:Nil repeats:YES];
		
	}
	else {
		[dockTile setContentView:nil];
	}
}

- (void)refreshDockTile {
	
	if ( _lastRefreshTime && floor(_lastRefreshTime) == floor( [NSDate timeIntervalSinceReferenceDate] ) )
		return;
	
	_lastRefreshTime = [NSDate timeIntervalSinceReferenceDate];
	[_dockTile display];
}

// setzt das docktile anhand des Wertes aus dem Preferences file

- (void)updateCurrentClockBundle {
	
	CFPreferencesAppSynchronize(APPLICATION_ID);
	
	CFPropertyListRef value = CFPreferencesCopyAppValue(CFSTR("BundleID"), APPLICATION_ID);
	NSString *selectedBundleID = (__bridge_transfer NSString *)(CFStringRef)value;
	
	NSBundle *foundBundle = NULL;
	
	if ( selectedBundleID ) {
			
		NSArray *bundles = [DockTilePlugIn allClockBundles];
		
		for ( NSBundle *bundle in bundles ) {
			
			if ( [bundle.bundleIdentifier isEqualToString:selectedBundleID] ) {
				foundBundle = bundle;
				break;
			}
		}
	}
	
	if ( !foundBundle ) {
		
		CFPreferencesSetAppValue(CFSTR("BundleID"), DEFAULT_BUNDLE_ID, APPLICATION_ID);
		CFPreferencesAppSynchronize(APPLICATION_ID);
		
		[[NSDistributedNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME object:nil];
		
		return;
	}
	
	Class clockViewClass;
	
	if ( (clockViewClass = [foundBundle principalClass]) )
	{
		NSView *clockView = [[clockViewClass alloc] initWithFrame:NSMakeRect(0, 0, 128, 128)];
		[_dockTile setContentView:clockView];
	}
	
}

- (NSMenu*)dockMenu {
	if ( !_dockMenu )
		_dockMenu = [[DockMenu alloc] init];
	
	return _dockMenu;
}

+ (NSArray *)allClockBundles {
	
	NSBundle *mainBundle = [NSBundle bundleWithIdentifier:@"de.pecora.iClock-DockTilePlugin"];
	
	if ( !mainBundle ) {
		
		NSString *path = [NSBundle pathForResource:@"DockTilePlugin" ofType:@"docktileplugin" inDirectory:[[NSBundle mainBundle] builtInPlugInsPath]];
		mainBundle = [NSBundle bundleWithPath:path];
	}
	
	NSMutableArray *bundles = [NSMutableArray arrayWithCapacity:5];
	
	for (NSString *path in [NSBundle pathsForResourcesOfType:@"clockbundle" inDirectory:[mainBundle builtInPlugInsPath]] ) {
		
		NSBundle *bundle;
		
		if ( ( bundle = [NSBundle bundleWithPath:path] ) )
			[bundles addObject:bundle];
	}
	
	return bundles;
}


@end
