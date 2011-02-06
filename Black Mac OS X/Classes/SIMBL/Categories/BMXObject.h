//
//  BMXObject.h
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/6/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (BMXObject)
+ (void)swizzle;
- (BOOL)isBMXCustomized;
@end
