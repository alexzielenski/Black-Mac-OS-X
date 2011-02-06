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
	
	for (NSWindow *window in [[NSApplication sharedApplication] windows]) {
		[window display];
	}
}
- (void)swizzle {
	// Swizzle all of our methods in here.
//	Class class =  [NSThemeFrame class];
	/*Method m0 = class_getInstanceMethod([self class], @selector(drawRect:));
	class_addMethod(class, @selector(drawRectOriginal:), method_getImplementation(m0), method_getTypeEncoding(m0));
	
	Method m1 = class_getInstanceMethod(class, @selector(drawRect:));
	Method m2 = class_getInstanceMethod(class, @selector(drawRectOriginal:));
	
	method_exchangeImplementations(m1, m2);*/
	
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
}
@end
