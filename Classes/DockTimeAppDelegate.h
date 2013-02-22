//
//  DockTimeAppDelegate.h
//  DockTime
//
//  Created by Werner Freytag on 03.03.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DockTilePlugIn;

@interface DockTimeAppDelegate : NSObject <NSApplicationDelegate> {
	
	NSMenu *_dockMenu;
	DockTilePlugIn *_dockTilePlugin;
}

@end
