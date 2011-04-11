//
//  BMXObject.m
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/6/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//

#import "BMXObject.h"


@implementation NSObject (BMXObject)
+ (void)swizzle {
	return; // override this
}
- (BOOL)isBMXCustomized {
	return NO;
}
@end
