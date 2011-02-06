//
//  BMXController.h
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/5/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SynthesizeSingleton.h"

@interface BMXController : NSObject {
    
}
+ (BMXController *)sharedBMXController;
- (void)swizzle;
@end
