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
@end

@interface NSSegmentedCell (BMXSegmentedCell)
- (NSGradient*)titleGradient;
+ (NSGradient*)selectedGradient;

- (struct CGRect)_rectForSegment:(long long)arg1 inFrame:(struct CGRect)arg2;	// IMP=0x00127768
@end