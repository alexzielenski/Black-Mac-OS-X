//
//  BMXCell.m
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/6/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//

#import "BMXCell.h"


@implementation NSCell (BMXCell)
+ (void)swizzle {
	// backgroundstyle
	NSError *err = nil;
	[NSCell jr_aliasMethod:@selector(backgroundStyle) 
					withSelector:@selector(orig_backgroundStyle)
						   error:&err];
	NSLog(@"%@", err);
	[NSCell jr_swizzleMethod:@selector(backgroundStyle)
						withMethod:@selector(new_backgroundStyle)
							 error:&err];
	NSLog(@"%@", err);
}
- (BOOL)isBMXCustomized {
	// no need
	return NO;
}
#pragma mark - Overrides
- (NSBackgroundStyle)new_backgroundStyle {
//	if (self.controlView.superview.isBMXCustomized == YES)
//		return NSBackgroundStyleLowered;
	return [self orig_backgroundStyle]; // this stuff doesn't work. any help?
}
//- (NSBackgroundStyle)interiorBackgroundStyle {
//	return NSBackgroundStyleLowered;
//}
@end
