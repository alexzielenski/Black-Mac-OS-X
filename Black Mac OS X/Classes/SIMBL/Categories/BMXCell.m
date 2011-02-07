//
//  BMXCell.m
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/6/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//

#import "BMXCell.h"
#import "NSThemeFrame.h"

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
	/*if (self.controlView.superview.isBMXCustomized == YES)
		return NSBackgroundStyleLowered;
	return NSBackgroundStyleLight; // this stuff doesn't work. any help?*/
	if (self.controlView) {
		NSThemeFrame *themeFrame = (NSThemeFrame*)[[[self.controlView window] contentView] superview];
		NSRect topBar = NSMakeRect(0, NSMaxY(themeFrame.frame)-themeFrame._topBarHeight, themeFrame.frame.size.width, themeFrame._topBarHeight);
		NSRect bottomBar = NSMakeRect(0, 0, themeFrame.frame.size.width, themeFrame._bottomBarHeight);
		NSRect frame = self.controlView.frame;
		frame = [self.controlView convertRect:frame toView:nil];

		if (NSEqualRects(NSIntersectionRect(topBar, frame), frame)||NSEqualRects(NSIntersectionRect(bottomBar, frame), frame))
			return NSBackgroundStyleLowered; // If the controlVIew's entire frame is inside the top bar or the bottom bar, make the cell text/images white. Coincidentally works for toolbars as well
	}
	return [self orig_backgroundStyle];
}
//- (NSBackgroundStyle)interiorBackgroundStyle {
//	return NSBackgroundStyleLowered;
//}
@end
