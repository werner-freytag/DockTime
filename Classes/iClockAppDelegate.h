//
//  iClockAppDelegate.h
//  iClock
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DockTilePlugIn;

@interface iClockAppDelegate : NSObject <NSApplicationDelegate> {
	
	NSMenu *_dockMenu;
	DockTilePlugIn *_dockTilePlugin;
}

@end
