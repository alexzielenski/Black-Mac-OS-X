//
//  BMXCell.m
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/6/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//

#import "BMXCell.h"
#import "NSThemeFrame.h"
#import "NSBezierPath+MCAdditions.h"

static NSGradient *titleGradient = nil;
static NSGradient *inactiveGradient = nil;

@implementation NSCell (BMXCell)
+ (void)swizzle {
	// backgroundstyle
	NSError *err = nil;
	[self jr_aliasMethod:@selector(backgroundStyle) 
					withSelector:@selector(orig_backgroundStyle)
						   error:&err];
	NSLog(@"%@", err);
	[self jr_swizzleMethod:@selector(backgroundStyle)
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
		if (![themeFrame isKindOfClass:[NSThemeFrame class]])
			themeFrame=[themeFrame superview];
		if (!themeFrame)
			return (NSBackgroundStyle)[self orig_backgroundStyle];
		
		NSRect topBar = NSMakeRect(0, NSMaxY(themeFrame.frame)-themeFrame._topBarHeight, themeFrame.frame.size.width, themeFrame._topBarHeight);
		NSRect bottomBar = NSMakeRect(0, 0, themeFrame.frame.size.width, themeFrame._bottomBarHeight);
		NSRect frame = self.controlView.frame;
		frame = [self.controlView convertRect:frame toView:nil];
		if (((NSEqualRects(NSIntersectionRect(topBar, frame), frame)||NSEqualRects(NSIntersectionRect(bottomBar, frame), frame))&&!self.isBordered&&![self.controlView isKindOfClass:[NSSegmentedControl class]])&&topBar.size.width!=0&&bottomBar.size.width!=0) { // no segmented controls for now
			return NSBackgroundStyleLowered; // If the controlVIew's entire frame is inside the top bar or the bottom bar, make the cell text/images white. Coincidentally works for toolbars as well
		}
	}
	return (NSBackgroundStyle)[self orig_backgroundStyle];
}
/*- (NSBackgroundStyle)interiorBackgroundStyle {
	return NSBackgroundStyleLowered;
}*/
@end
@implementation NSSegmentedCell (BMXSegmentedCell)

- (NSBackgroundStyle)interiorBackgroundStyle {
	return NSBackgroundStyleLowered;
}
- (NSBackgroundStyle)backgroundStyle {
	return NSBackgroundStyleLowered;
}
- (long long)interiorBackgroundStyleForSegment:(long long)arg1 {
	return NSBackgroundStyleLowered;
}
- (long long)_initialBackgroundStyleCompatibilityGuess {
	return NSBackgroundStyleLowered;
}
- (BOOL)_coreUIDrawSegmentBackground:(long long)arg1 withCellFrame:(struct CGRect)arg2 inView:(id)arg3 {
	NSRect frame = NSRectFromCGRect(arg2);
	NSInteger segmentCount = [(NSSegmentedControl*)arg3 segmentCount];
	
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:frame 
													cornerRadius:4.0];
	[path setLineWidth:2.0f];
	[path addClip];

	NSBezierPath *path2 = [path copy];
	
	[self.titleGradient drawInBezierPath:path
								   angle:90];
	
	[NSGraphicsContext saveGraphicsState];
	NSAffineTransform *trans = [NSAffineTransform transform];
	[trans translateXBy:0.0f yBy:1.0f];
	[path2 transformUsingAffineTransform:trans];
	
	[[[NSColor whiteColor]colorWithAlphaComponent:0.25] set];
	[path2 stroke];
	[path setClip];
	[NSGraphicsContext restoreGraphicsState];
	
	[path setLineWidth:2.0f];
	[NSGraphicsContext saveGraphicsState];
	[[NSColor blackColor] set];
	
	[path stroke];
	[path2 setClip];
	
	[NSGraphicsContext restoreGraphicsState];
	[path2 release];
	
	NSInteger currentSeg = 0;
	while (currentSeg<segmentCount) {
		NSRect sepRect = NSRectFromCGRect([self _rectForSegment:currentSeg inFrame:arg2]);
		if (currentSeg-segmentCount+1<0) {
			[[NSColor blackColor] set];
			NSRectFill(NSMakeRect(NSMaxX(sepRect)-1, 0, 1, NSHeight(sepRect)));
		}
		if (currentSeg==[self selectedSegment]) {
			NSShadow *selectedShadow = [[NSShadow alloc] init];
			[selectedShadow setShadowColor:[NSColor whiteColor]];
			[selectedShadow setShadowBlurRadius:6.0f];
			OSCornerType corners = 0;
			if (currentSeg==0)
				corners|=OSTopLeftCorner|OSBottomLeftCorner;
			else {
				sepRect.origin.x-=1;
				sepRect.size.width+=1;
			}
			if (currentSeg==segmentCount-1) {
				corners|=OSTopRightCorner|OSBottomRightCorner;
			}
			NSBezierPath *segPath = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(sepRect, 1, 1) cornerRadius:4.0f inCorners:corners];
			[segPath fillWithInnerShadow:selectedShadow];
			[selectedShadow release];
			[path setClip];
		}
		currentSeg++;
	}
	[path setClip];
	
	return YES;
}

- (NSGradient*)titleGradient {
	if (!titleGradient)
		titleGradient = [[[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceWhite:0.319 alpha:1.000]
													   endingColor:[NSColor colorWithDeviceWhite:0.100 alpha:1.000]] retain];
	if (!inactiveGradient)
		inactiveGradient = [[[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceWhite:0.340 alpha:1.000]
														  endingColor:[NSColor colorWithDeviceWhite:0.240 alpha:1.000]] retain];
	if (![self.controlView.window isKeyWindow]) {
		return inactiveGradient;
	}
	
	
	return titleGradient;
	
}
@end