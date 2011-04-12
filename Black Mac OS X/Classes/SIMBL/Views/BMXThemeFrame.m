//
//  BMXThemeFrame.m
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/5/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//
#import "BMXThemeFrame.h"

static NSGradient *titleGradient = nil;
static NSGradient *inactiveGradient = nil;
static NSImage *leftHighlight;
static NSImage *rightHighlight;
static NSImage *middleHighlight;

@interface NSThemeFrame (QuietWarnings)
- (void)orig_drawRect:(NSRect)fp8;
- (void)orig_drawFrame:(CGRect)fp8;
- (id)orig_customTitleCell;
- (void)orig_drawTitleBar:(CGRect)fp8;
- (void)orig_dealloc;
@end

@implementation NSThemeFrame (BMXThemeFrame)
#pragma mark - Init
+ (void)swizzle {
	NSError *err = nil;
	[NSThemeFrame jr_aliasMethod:@selector(_drawTitleBar:) 
					withSelector:@selector(orig_drawTitleBar:) 
						   error:&err];
	NSLog(@"%@", err);
	[NSThemeFrame jr_swizzleMethod:@selector(_drawTitleBar:)
						withMethod:@selector(new_drawTitleBar:)
							 error:&err];
	NSLog(@"%@", err);
	[NSThemeFrame jr_aliasMethod:@selector(drawFrame:) 
					withSelector:@selector(orig_drawFrame:)
						   error:&err];
	NSLog(@"%@", err);
	[NSThemeFrame jr_swizzleMethod:@selector(drawFrame:)
						withMethod:@selector(new_drawFrame:)
							 error:&err];
	NSLog(@"%@", err);
	[NSThemeFrame jr_aliasMethod:@selector(_customTitleCell) 
					withSelector:@selector(orig_customTitleCell) 
						   error:&err];
	NSLog(@"%@", err);
	[NSThemeFrame jr_swizzleMethod:@selector(_customTitleCell)
						withMethod:@selector(new_customTitleCell)
							 error:&err];
	NSLog(@"%@", err);
	[NSThemeFrame jr_aliasMethod:@selector(dealloc) 
					withSelector:@selector(orig_dealloc)
						   error:&err];
	NSLog(@"%@", err);
	[NSThemeFrame jr_swizzleMethod:@selector(dealloc)
						withMethod:@selector(new_dealloc)
							 error:&err];
	NSLog(@"%@", err);
	[NSThemeFrame jr_aliasMethod:@selector(drawRect:) 
					withSelector:@selector(orig_drawRect:)
						   error:&err];
	NSLog(@"%@", err);
	[NSThemeFrame jr_swizzleMethod:@selector(drawRect:)
						withMethod:@selector(new_drawRect:)
							 error:&err];
	NSLog(@"%@", err);
}
- (BOOL)isBMXCustomized {
	Method origMethod = class_getInstanceMethod([self class], @selector(new_drawTitleBar:));
	if (!origMethod)
		return NO;
	NSLog(@"customized");
	return YES;
}

#pragma mark - Drawing
- (void)new_drawTitleBar:(struct CGRect)arg1 {	// IMP=0x001023e0	
	if ((self.styleMask & NSTitledWindowMask)!=NSTitledWindowMask) {
		[self orig_drawTitleBar:arg1];
		return;
	}
	[self drawTitleBar];
}
- (void)new_drawFrame:(struct CGRect)arg1 {	
	if ((self.styleMask & NSTitledWindowMask)!=NSTitledWindowMask) {
		[self orig_drawFrame:arg1];
		return;
	}
	
	// If it isn't textured , draw the titlebar;
	if ((self.styleMask&NSTexturedBackgroundWindowMask)==NSTexturedBackgroundWindowMask) {
		[self drawBottomBar]; // for some reason textured window values can only be found in here…
 	}
	[self drawTitleBar];
	[self _drawTitleStringIn:self.bounds withColor:[NSColor whiteColor]];

}
- (void)drawHighlightsWithCorners:(BOOL)useCorners {

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
	if (useCorners) {
		[leftHighlight drawInRect:highlightRect
						 fromRect:NSZeroRect
						operation:NSCompositeSourceOver
			fraction:0.6];
		highlightRect.origin.x=fw-rightHighlight.size.width;
		highlightRect.size.width=rightHighlight.size.width;
		[rightHighlight drawInRect:highlightRect
						  fromRect:NSZeroRect
						 operation:NSCompositeSourceOver
						  fraction:0.6]; // The shine is too opaque for a black window
		
		highlightRect.origin.x=leftHighlight.size.width;
		highlightRect.size.width=fw-rightHighlight.size.width-leftHighlight.size.width;
	} else {
		// make the middle on go all the way across
		highlightRect.origin.x = 0;
		highlightRect.size.width=fw;
	}
	[middleHighlight drawInRect:highlightRect
			  fromRect:NSZeroRect
			 operation:NSCompositeSourceOver
			  fraction:0.6];
	
}
- (void)new_drawRect:(NSRect)fp8 {
//	// I don't know what the original drawRect: does, nor do i want to mess with it so lets just draw the bottom bar over it.
//	[self orig_drawRect:fp8];
	if ((self.styleMask & NSTitledWindowMask)!=NSTitledWindowMask) {
		[self orig_drawRect:fp8];
		return;
	}
		
	NSEraseRect(self.bounds);
	[[NSColor clearColor] set];
	NSRectFillUsingOperation(self.bounds, NSCompositeClear);
	[(NSColor*)self.contentFill set];
	NSRectFillUsingOperation(NSRectFromCGRect(self.contentRect), NSCompositeSourceOver); // This broke HUD windows
	
	[self drawBottomBar]; // bottom bar before the titlebar

	[self _drawTitleBar:NSRectToCGRect(fp8)];
	[self _drawToolbarTransitionIfNecessary];
	
//	[(NSCell*)self._customTitleCell drawWithFrame:NSRectFromCGRect([self _titlebarTitleRect]) 
//										   inView:self];
	[self _drawTitleStringIn:self.bounds withColor:[NSColor whiteColor]];
}
#pragma mark - Title
- (id)new_customTitleCell {
	id cell = [self orig_customTitleCell];
	if ((self.styleMask & NSTitledWindowMask)!=NSTitledWindowMask)
		return cell;
	if (cell)
		[(NSTextFieldCell*)cell setBackgroundStyle:NSBackgroundStyleLowered];
	return cell;
}
- (void)drawBottomBar {
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
- (void)drawTitleBar {
	if ((self.styleMask & NSTitledWindowMask)!=NSTitledWindowMask)
		return;
	
	BOOL utilityWindow = ((self.styleMask&NSUtilityWindowMask)==NSUtilityWindowMask);
	
	CGFloat topBarHeight = self._topBarHeight;
	
	// Create a top titlebar rectangle to fill. If it has a toolbar, add the toolbar's actual hight
    NSRect frame = [self frame];
    NSRect titleRect = NSMakeRect(0, NSMaxY(frame) - topBarHeight, NSWidth(frame), topBarHeight);
	
	[[NSColor clearColor] set];
	NSEraseRect(titleRect);
	NSRectFillUsingOperation(titleRect, NSCompositeClear);
	
	[self drawTitleGradientInRect:titleRect 
					 cornerRadius:(utilityWindow) ? 0 : [self roundedCornerRadius] 
					 roundCorners:OSTopLeftCorner | OSTopRightCorner
							onTop:YES];
	
	// draw a black separator on the bottom
	[[NSColor blackColor] set];
	NSRectFill(NSMakeRect(NSMinX(titleRect), NSMinY(titleRect), NSWidth(titleRect), 1));
}
- (void)drawTitleGradientInRect:(NSRect)titleRect cornerRadius:(CGFloat)cornerRadius roundCorners:(OSCornerType)corner onTop:(BOOL)top {
	// Black outline around the top for perfection, -0.5 corner radius
	if ((self.styleMask & NSTitledWindowMask)!=NSTitledWindowMask)
		return;
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
		[self drawHighlightsWithCorners:(cornerRadius==0.0) ? NO : YES];	
		[NSGraphicsContext restoreGraphicsState];
	}
	[NSGraphicsContext restoreGraphicsState];
}
#pragma mark - Accessors
- (NSGradient*)titleGradient {
	if ([self.window isKeyWindow]) {
		if (!titleGradient)
			titleGradient = [[[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceWhite:0.279 alpha:1.000]
														   endingColor:[NSColor colorWithDeviceWhite:0.000 alpha:1.000]] retain];
	} else {
		if (!inactiveGradient)
			inactiveGradient = [[[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceWhite:0.310 alpha:1.000]
															  endingColor:[NSColor colorWithDeviceWhite:0.140 alpha:1.000]] retain];
		return inactiveGradient;
	}
		

	return titleGradient;

}
- (void)_windowChangedKeyState {
	[self.window display];
}
- (id)frameColor {
	return [NSColor blackColor];
}
- (id)frameShadowColor {
	return [NSColor blueColor];
}
#pragma mark - Other
- (void)new_dealloc {
	[titleGradient release], titleGradient=nil;
	[leftHighlight release], leftHighlight=nil;
	[rightHighlight release], rightHighlight=nil;
	[middleHighlight release], middleHighlight=nil;
	[inactiveGradient release], inactiveGradient=nil;
	
	[self orig_dealloc]; // equivalent to calling [super dealloc]?
}
@end
