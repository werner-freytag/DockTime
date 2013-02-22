//
//  NSBundle+Compatibility10_6.h
//  DockTime
//
//  Created by Werner on 13.07.12.
//  Copyright (c) 2012 Pecora GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (ImageResource)

- (NSImage *)imageNamed:(NSString *)name;

@end
