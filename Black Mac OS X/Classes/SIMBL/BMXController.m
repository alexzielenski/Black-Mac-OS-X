//
//  BMXController.m
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/5/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//

#import "BMXController.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>

#import "BMXThemeFrame.h"

/* Ideas–I will be storing some ideas here
 1.) For text that is on a black/customized background, how about i do this:
	 A.) Create a category on NSObject that has a method: - (BOOL)isCustomized;
     B.) In each of my categories on stuff i customized (i.e. BMXThemeFrame), implement 
         this method to return a result based on the existence of the swizzled methods or something similar
     C.) For each NSCell, use the controlView's superview and call - (BOOL)isCustomized inside the - (NSBackgroundStyle)backgroundStyle and 
         -(NSColor*)textColor (will test for NSTextFieldCell, of course) and change the values accordingly
 2.) Create a + (void)swizzle method in all of my categories/subclasses so it can be organized instead of swizzling everything in this file.
 3.) Create a jr_aliasAndSwizzle…error: method to create an alias first (like done below) and then swizzle. This way i can call the original
     method from within my categories without tons of code
 */

@interface BMXController (Obama)
- (float)_titlebarHeight;
- (NSRect)titlebarRect;
- (NSRect)frame;
+ (void)drawBevel:(struct CGRect)arg1 inFrame:(struct CGRect)arg2 topCornerRounded:(BOOL)arg3 bottomCornerRounded:(BOOL)arg4 isHUD:(BOOL)arg5 isDarkWindow:(BOOL)arg6;	// IMP=0x002622e3

@end

@implementation BMXController
SYNTHESIZE_SINGLETON_FOR_CLASS(BMXController); // Create easy singleton. Thanks http://cocoawithlove.com/2008/11/singletons-appdelegates-and-top-level.html
+ (void)load {
	BMXController *controller = [BMXController sharedBMXController];
	[controller swizzle];
	
	// Redraw the currently displayed windows with the black stuff on it
	for (NSWindow *window in [[NSApplication sharedApplication] windows]) {
		[window display];
	}
}
- (void)swizzle {
	NSLog(@"Swizzling…");
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
@end
