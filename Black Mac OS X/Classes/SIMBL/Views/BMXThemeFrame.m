//
//  BMXThemeFrame.m
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/5/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//
#import "BMXController.h"
#import "BMXThemeFrame.h"
#import "NSBezierPath+PXRoundedRectangleAdditions.h"

@implementation NSThemeFrame (BMXThemeFrame)
- (void)new_drawTitleBar:(struct CGRect)arg1 {	// IMP=0x001023e0
	[NSGraphicsContext saveGraphicsState];
	
	CGFloat fw = self.frame.size.width;
	
//	
	[[NSColor clearColor] set];
	NSEraseRect(NSRectFromCGRect(arg1));
	NSRectFill(NSRectFromCGRect(arg1));


    NSRect frame = [self frame];
    NSRect titleRect = NSMakeRect(0, NSMaxY(frame) - [self _titlebarHeight], NSWidth(frame), [self _titlebarHeight]-1);
	if ([self _toolbarIsShown]) {
		CGFloat size = [(NSView*)[self _toolbarView] frame].size.height;
		titleRect.size.height+=size;
		titleRect.origin.y-=size;
	}
    
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:titleRect
                                         cornerRadius:[self roundedCornerRadius]-1
                                            inCorners:OSTopLeftCorner | OSTopRightCorner];
	[[NSColor blackColor] set];
	[path fill];

	path = [NSBezierPath bezierPathWithRoundedRect:titleRect
									  cornerRadius:[self roundedCornerRadius]
										 inCorners:OSTopLeftCorner | OSTopRightCorner];
	NSGradient *gr = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceWhite:0.279 alpha:1.000]
												   endingColor:[NSColor colorWithDeviceWhite:0.000 alpha:1.000]];
	[gr drawInBezierPath:path angle:-90];
	[gr release];
	[path addClip];
	// Draw highlights
	NSBundle *bundle = [NSBundle bundleForClass:[BMXController class]];
	NSImage *left = [[NSImage alloc] initWithContentsOfFile:
					 [bundle pathForResource:@"left" ofType:@"png"]];

	NSImage *right = [[NSImage alloc] initWithContentsOfFile:
					  [bundle pathForResource:@"right" ofType:@"png"]];
	NSImage *middle = [[NSImage alloc] initWithContentsOfFile:
					   [bundle pathForResource:@"middle" ofType:@"png"]];
	NSRect highlightRect = NSMakeRect(1, NSMaxY(frame)-left.size.height-1, left.size.width, left.size.height);
	[left drawInRect:highlightRect
			 fromRect:NSZeroRect
			operation:NSCompositeSourceOver
			 fraction:0.7];
	highlightRect.origin.x+=left.size.width;
	highlightRect.size.width=fw-right.size.width-left.size.width-2;
	[middle drawInRect:highlightRect
			fromRect:NSZeroRect
		   operation:NSCompositeSourceOver
			fraction:0.7];
	highlightRect.origin.x=fw-right.size.width-1;
	highlightRect.size.width=right.size.width;
	[right drawInRect:highlightRect
			  fromRect:NSZeroRect
			 operation:NSCompositeSourceOver
			  fraction:0.7];
	
	[left release];
	[middle release];
	[right release];
	[NSGraphicsContext restoreGraphicsState];

	   
	[self _drawTitleStringIn:self.bounds withColor:[NSColor whiteColor]];
}
@end
