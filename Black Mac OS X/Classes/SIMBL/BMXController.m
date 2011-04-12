//
//  BMXController.m
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/5/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//

#import "BMXController.h"


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


@implementation BMXController
SYNTHESIZE_SINGLETON_FOR_CLASS(BMXController); // Create easy singleton. Thanks http://cocoawithlove.com/2008/11/singletons-appdelegates-and-top-level.html
+ (void)load {	
	BMXController *controller = [BMXController sharedBMXController];
	[controller swizzle];
	
	//	[[NSApplication sharedApplication] makeWindowsPerform:@selector(display)
	//											  inOrder:NO];
	
	// Redraw the currently displayed windows with the black stuff on it
	for (NSWindow *window in [[NSApplication sharedApplication] windows]) {
		[window display];
	}
}
- (void)swizzle {
	NSLog(@"Swizzling…");
	[NSThemeFrame swizzle];
	[NSCell swizzle];
	[NSButtonCell swizzle];
//	[NSSegmentedCell swizzle];
}
@end
