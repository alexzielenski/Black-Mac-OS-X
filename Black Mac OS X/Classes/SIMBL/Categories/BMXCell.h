//
//  BMXCell.h
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/6/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMXController.h"

@interface NSCell (BMXCell)
- (NSBackgroundStyle)new_backgroundStyle;

- (NSGradient*)titleGradient;
+ (NSGradient*)selectedGradient;
@end

@interface NSSegmentedCell (BMXSegmentedCell)
@end

@interface NSButtonCell (BMXButtonCell)
- (void)new_drawBezelWithFrame:(NSRect)arg1 inView:(id)arg2;
- (NSBackgroundStyle)new_interiorBackgroundStyle;
- (BOOL)shouldHack;
@end