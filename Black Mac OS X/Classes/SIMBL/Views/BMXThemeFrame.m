//
//  BMXThemeFrame.m
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/5/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//
#import "BMXController.h"
#import "BMXThemeFrame.h"
#pragma mark - Title Bar Drawing

static NSGradient *titleGradient = nil;
static NSImage *leftHighlight;
static NSImage *rightHighlight;
static NSImage *middleHighlight;

@implementation NSThemeFrame (BMXThemeFrame)
- (void)new_drawTitleBar:(struct CGRect)arg1 {	// IMP=0x001023e0
	if ((self.styleMask&NSUtilityWindowMask)==NSUtilityWindowMask) {
		// We'll get back to this…
		[self orig_drawTitleBar:arg1];
		return;
	}
	CGFloat topBarHeight = self._topBarHeight;
		
	[[NSColor clearColor] set];
	NSEraseRect(self.bounds);
	NSRectFillUsingOperation(self.frame, NSCompositeClear);

	// Create a top titlebar rectangle to fill. If it has a toolbar, add the toolbar's actual hight
    NSRect frame = [self frame];
    NSRect titleRect = NSMakeRect(0, NSMaxY(frame) - topBarHeight, NSWidth(frame), topBarHeight);
	if ([self _toolbarIsShown]||[self _toolbarIsInTransition]) {
		CGFloat size = [(NSView*)[self _toolbarView] frame].size.height;
		titleRect.size.height+=size;
		titleRect.origin.y-=size;
	}
	
	[self drawTitleGradientInRect:titleRect 
					 cornerRadius:[self roundedCornerRadius] 
					 roundCorners:OSTopLeftCorner | OSTopRightCorner
							onTop:YES];


	
}
- (void)new_drawFrame:(struct CGRect)arg1 {
	BOOL textured;
	
	
	if (!self._isHUDWindow) {
	// Fill the background color
		[(NSColor*)self.contentFill set];
		NSRectFillUsingOperation(self.contentRect, NSCompositeSourceOver); // This broke HUD windows
	}
	// If it isn't textured , draw the titlebar;
	if ((self.styleMask&NSTexturedBackgroundWindowMask)==NSTexturedBackgroundWindowMask)
		textured=YES;
	else
		[self _drawTitleBar:arg1];
	
	[self _drawTitleStringIn:self.bounds withColor:[NSColor whiteColor]];
	
	
}
- (void)drawHighlights {
	if (!leftHighlight||!rightHighlight||!middleHighlight) {
	NSBundle *bundle = [NSBundle bundleForClass:[BMXController class]];
	leftHighlight = [[[NSImage alloc] initWithContentsOfFile:
					 [bundle pathForResource:@"left" ofType:@"png"]] retain];
	
	rightHighlight = [[[NSImage alloc] initWithContentsOfFile:
					  [bundle pathForResource:@"right" ofType:@"png"]] retain];
	middleHighlight = [[[NSImage alloc] initWithContentsOfFile:
					   [bundle pathForResource:@"middle" ofType:@"png"]] retain];
	}
	
	NSRect frame = self.frame;
	CGFloat fw = frame.size.width;
	NSRect highlightRect = NSMakeRect(0, NSMaxY(frame)-leftHighlight.size.height-1, leftHighlight.size.width, leftHighlight.size.height);
	[leftHighlight drawInRect:highlightRect
			fromRect:NSZeroRect
		   operation:NSCompositeSourceOver
			fraction:0.6];
	highlightRect.origin.x+=leftHighlight.size.width;
	highlightRect.size.width=fw-rightHighlight.size.width-leftHighlight.size.width;
	[middleHighlight drawInRect:highlightRect
			  fromRect:NSZeroRect
			 operation:NSCompositeSourceOver
			  fraction:0.6];
	highlightRect.origin.x=fw-rightHighlight.size.width;
	highlightRect.size.width=rightHighlight.size.width;
	[rightHighlight drawInRect:highlightRect
			 fromRect:NSZeroRect
			operation:NSCompositeSourceOver
			 fraction:0.6]; // The shine is too opaque for a black window
}
- (void)new_drawRect:(NSRect)fp8 {
	// I don't know what the original drawRect: does, nor do i want to mess with it so lets just draw the bottom bar over it.
	[self orig_drawRect:fp8];
	
	// Draw Bottom bar using the title gradient
	CGFloat bottomBarHeight=self._bottomBarHeight;
	NSRect bottomBarRect = NSMakeRect(0, 0, self.frame.size.width, bottomBarHeight);

	// TODO: Draw a black stroke or border across the top of the bottom bar or around the bottom bar if the window is not textured
	// Clear out the previous bottom bar
	NSEraseRect(bottomBarRect);
	[[NSColor clearColor] set];
	NSRectFillUsingOperation(bottomBarRect, NSCompositeClear);
	[self drawTitleGradientInRect:bottomBarRect 
					 cornerRadius:(self.bottomCornerRounded) ? [self roundedCornerRadius] : 0 
					 roundCorners:OSBottomLeftCorner | OSBottomRightCorner 
							onTop:NO];
}
#pragma mark - Title
- (id)new_customTitleCell {
	id cell = [self orig_customTitleCell];
	if (cell)
		[(NSTextFieldCell*)cell setBackgroundStyle:NSBackgroundStyleLowered];
	return cell;
}
- (void)drawTitleGradientInRect:(NSRect)titleRect cornerRadius:(CGFloat)cornerRadius roundCorners:(OSCornerType)corner onTop:(BOOL)top {
	// Black outline around the top for perfection, -0.5 corner radius
	[NSGraphicsContext saveGraphicsState];
	NSRect rect = titleRect;
	NSBezierPath *path = nil;
	if (top) {
		path = [NSBezierPath bezierPathWithRoundedRect:rect
										  cornerRadius:cornerRadius-0.5
											 inCorners:corner];
		[[NSColor blackColor] set];
		[path fill];
		// Lower the actual fill 1pt
		rect.size.height-=1;
	}
	path = [NSBezierPath bezierPathWithRoundedRect:rect
									  cornerRadius:cornerRadius
										 inCorners:corner];
	
	// Draw static gradient
	[self.titleGradient drawInBezierPath:path angle:-90];
	
	if (top) {
		// Draw highlights, we need to save the graphics state so the addClip only applies to the highlights
		[NSGraphicsContext saveGraphicsState];
		[path addClip];
		[self drawHighlights];	
		[NSGraphicsContext restoreGraphicsState];
	}
	[NSGraphicsContext restoreGraphicsState];
}
#pragma mark - Accessors
- (NSGradient*)titleGradient {
	if (!titleGradient)
		titleGradient = [[[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceWhite:0.279 alpha:1.000]
													   endingColor:[NSColor colorWithDeviceWhite:0.000 alpha:1.000]] retain];

	return titleGradient;

}

#pragma mark - Other
- (void)new_dealloc {
	[titleGradient release], titleGradient=nil;
	[leftHighlight release], leftHighlight=nil;
	[rightHighlight release], rightHighlight=nil;
	[middleHighlight release], middleHighlight=nil;
	
	[self orig_dealloc]; // equivalent to calling [super dealloc]?
}
@end
