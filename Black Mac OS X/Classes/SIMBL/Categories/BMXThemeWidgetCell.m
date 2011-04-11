//
//  BMXThemeWidgetCell.m
//  Black Mac OS X
//
//  Created by Alex Zielenski on 4/11/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//

#import "BMXThemeWidgetCell.h"
#import "NSBezierPath+PXRoundedRectangleAdditions.h"
#import "NSBezierPath+MCAdditions.h"
typedef enum {
	BMXTitlebarZoom = 129,
	BMXTitlebarClose = 127,
	BMXTitlebarCollapse = 128, // minimize
	BMXTitlebarToolbar = 130
} BMXTitlebarButtonStyle;

@implementation _NSThemeWidgetCell (BMXThemeWidgetCell)
- (NSInteger)buttonID {
	return _buttonID;
}
- (BOOL)hasRollover {
	return _hasRollover;
}
- (NSDictionary*)drawOptions {
	return (NSDictionary*)_coreUIDrawOptions;
}
- (void)coreUIDrawWithFrame:(struct CGRect)arg1 inView:(id)arg2 {
	BMXTitlebarButtonStyle style = self.buttonID;
	BOOL disabled = ([(NSString*)[self coreUIState] isEqualToString:@"disabled"]);
	BOOL shouldRollover = ([(NSString*)[self coreUIState] isEqualToString:@"rollover"]);
	NSLog(@"%@", (NSString*)[self coreUIState]);
	NSLog(@"%@", (NSDictionary*)_coreUIDrawOptions);

	NSRect frame = NSZeroRect;
	if (style==BMXTitlebarToolbar) {
		frame = NSMakeRect(2, 0, 16, 10);
	} else {
		frame = NSMakeRect(1, 2, 12, 12);
	}
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:frame 
														 xRadius:round(frame.size.width/2)
														 yRadius:round(frame.size.width/2)];
	NSGradient *drawGradient = nil;
	BOOL edited = NO;
	if (!disabled) {
		if (style==BMXTitlebarClose) {
			edited = [self isEdited]; // _NSThemeCloseWidgetCell
			drawGradient=self.class.redGradient;
		} else if (style==BMXTitlebarCollapse) {
			drawGradient=self.class.yellowGradient;
		} else if (style==BMXTitlebarZoom) {
			drawGradient=self.class.greenGradient;
		} else if (style==BMXTitlebarToolbar) {
			drawGradient=self.class.silverGradient;
		}
	} else {
		drawGradient=self.class.disabledGradient;
	}

	NSShadow *dropShadow = [[NSShadow alloc] init];
	[dropShadow setShadowColor:[[NSColor whiteColor]colorWithAlphaComponent:0.25f]];
	[dropShadow setShadowBlurRadius:1.0f];
	[dropShadow setShadowOffset:NSMakeSize(0, -1)];
	[dropShadow set];
	[drawGradient drawInBezierPath:path angle:90];
	
	[path setLineWidth:1.0f];
	[[NSColor colorWithCalibratedWhite:0.159 alpha:1.000] set];
	[path stroke];
	
	if (edited) { //draw a dot 
		
	}
	
	if (self.hasRollover&&(shouldRollover||self.isHighlighted)&&!edited) { // draw the sign
		if (style!=BMXTitlebarToolbar) {
			[[NSColor colorWithCalibratedWhite:0.120f alpha:0.75f] set];
			NSBezierPath *shapePath = nil;
			switch (style) {
				case BMXTitlebarClose:
					shapePath=self.class.closePath;
					break;
				case BMXTitlebarCollapse:
					shapePath=self.class.minusPath;
					break;	
				case BMXTitlebarZoom:
					shapePath=self.class.plusPath;
					break;
				default:
					break;
			}
			
			NSAffineTransform *center = [NSAffineTransform transform];
			[center translateXBy:NSWidth(frame)/2-shapePath.bounds.size.width/2+frame.origin.x 
							 yBy:NSHeight(frame)/2-shapePath.bounds.size.height/2+frame.origin.y];
			[shapePath transformUsingAffineTransform:center];
			[dropShadow set];
			[shapePath fill];
		} else {
			
		}
	}
	if (self.isHighlighted) { // NSCell method
		NSShadow *selectionShadow = [[NSShadow alloc] init];
		selectionShadow.shadowBlurRadius=frame.size.height/2;
		selectionShadow.shadowColor=[[NSColor blackColor] colorWithAlphaComponent:0.75];
		[path fillWithInnerShadow:selectionShadow];
		[selectionShadow release];
	} 
	
	[dropShadow release];

}
#pragma mark - Gradients
+ (NSGradient*)redGradient {
	static NSGradient *redGradient;
	if (!redGradient) {
		redGradient=[[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.765 green:0.306 blue:0.294 alpha:1.000] 
												  endingColor:[NSColor colorWithCalibratedRed:0.624 green:0.267 blue:0.259 alpha:1.000]];
	}
	return redGradient;
}
+ (NSGradient*)yellowGradient {
	static NSGradient *yellowGradient;
	if (!yellowGradient) {
		yellowGradient=[[NSGradient alloc]initWithStartingColor:[NSColor colorWithCalibratedRed:0.839 green:0.718 blue:0.290 alpha:1.000] 
													endingColor:[NSColor colorWithCalibratedRed:0.702 green:0.612 blue:0.247 alpha:1.000]];
	}
	return yellowGradient;
}
+ (NSGradient*)greenGradient {
	static NSGradient *greenGradient;
	if (!greenGradient) {
		greenGradient=[[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.333 green:0.725 blue:0.318 alpha:1.000] 
													endingColor:[NSColor colorWithCalibratedRed:0.275 green:0.584 blue:0.271 alpha:1.000]];
	}
	return greenGradient;
}
+ (NSGradient*)silverGradient {
	static NSGradient *silverGradient;
	if (!silverGradient) {
		silverGradient=[[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.592 green:0.663 blue:0.725 alpha:1.000] 
													 endingColor:[NSColor colorWithCalibratedRed:0.424 green:0.443 blue:0.463 alpha:1.000]];
	}
	return silverGradient;
}
+ (NSGradient*)disabledGradient {
	static NSGradient *disabledGradient;
	if (!disabledGradient) {
		disabledGradient=[[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.580 green:0.620 blue:0.680 alpha:1.000] 
													 endingColor:[NSColor colorWithCalibratedRed:0.390 green:0.413 blue:0.433 alpha:1.000]];
	}
	return disabledGradient;
}

#pragma mark - Paths
+ (NSBezierPath*)closePath {
	// X
	// 6x6 X
	NSBezierPath *path = [NSBezierPath bezierPath];
	[path moveToPoint:NSMakePoint(0, 1)];
	[path lineToPoint:NSMakePoint(2, 3)];
	[path lineToPoint:NSMakePoint(0, 5)];
	[path lineToPoint:NSMakePoint(1, 6)];
	[path lineToPoint:NSMakePoint(3, 4)];
	[path lineToPoint:NSMakePoint(5, 6)];
	[path lineToPoint:NSMakePoint(6, 5)];
	[path lineToPoint:NSMakePoint(4, 3)];
	[path lineToPoint:NSMakePoint(6, 1)];
	[path lineToPoint:NSMakePoint(5, 0)];
	[path lineToPoint:NSMakePoint(3, 2)];
	[path lineToPoint:NSMakePoint(1, 0)];
	[path lineToPoint:NSMakePoint(0, 1)];
	[path closePath];
	return path;
	/*
	NSFont *font = [NSFont fontWithName:@"Arial-Black" size:8.0f];
	NSGlyph glph = [font glyphWithName:@"x"];
	NSBezierPath *path = [NSBezierPath bezierPath];
	[path moveToPoint:NSZeroPoint];
	[path appendBezierPathWithGlyph:glph inFont:font];
	return path;*/
}
+ (NSBezierPath*)minusPath {
	NSBezierPath *path = [NSBezierPath bezierPath];
	[path moveToPoint:NSZeroPoint]; // 2x6 minus sign
	[path lineToPoint:NSMakePoint(6, 0)];
	[path lineToPoint:NSMakePoint(6, 2)];
	[path lineToPoint:NSMakePoint(0, 2)];
	[path lineToPoint:NSZeroPoint];
	[path closePath];
	return path;
}
+ (NSBezierPath*)plusPath {
	NSBezierPath *path = [NSBezierPath bezierPath];
	[path moveToPoint:NSMakePoint(0, 2)]; // 6x6 plus sign
	[path lineToPoint:NSMakePoint(2, 2)];
	[path lineToPoint:NSMakePoint(2, 0)];
	[path lineToPoint:NSMakePoint(4, 0)];
	[path lineToPoint:NSMakePoint(4, 2)];
	[path lineToPoint:NSMakePoint(6, 2)];
	[path lineToPoint:NSMakePoint(6, 4)];
	[path lineToPoint:NSMakePoint(4, 4)];
	[path lineToPoint:NSMakePoint(4, 6)];
	[path lineToPoint:NSMakePoint(2, 6)];
	[path lineToPoint:NSMakePoint(2, 4)];
	[path lineToPoint:NSMakePoint(0, 4)];
	[path lineToPoint:NSMakePoint(0, 2)];
	[path closePath];
	return path;
}
@end
