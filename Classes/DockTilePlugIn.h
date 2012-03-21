//
//  DockTilePlugIn.h
//  iClock
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DockTilePlugIn : NSObject <NSDockTilePlugIn> {
	NSDockTile		*_dockTile;
	NSMenu			*_dockMenu;
	NSTimer			*_refreshTimer;
	NSTimeInterval	_lastRefreshTime;
}

- (void)updateCurrentClockBundle;

+ (NSArray *)allClockBundles;

@end
