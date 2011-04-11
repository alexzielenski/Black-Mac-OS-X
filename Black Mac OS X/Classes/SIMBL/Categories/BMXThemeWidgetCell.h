//
//  BMXThemeWidgetCell.h
//  Black Mac OS X
//
//  Created by Alex Zielenski on 4/11/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "_NSThemeWidgetCell.h"

@interface _NSThemeWidgetCell (BMXThemeWidgetCell)
- (NSDictionary*)drawOptions;
- (BOOL)hasRollover;
- (NSInteger)buttonID;

+ (NSGradient*)redGradient;
+ (NSGradient*)yellowGradient;
+ (NSGradient*)greenGradient;
+ (NSGradient*)silverGradient;
+ (NSGradient*)disabledGradient;

+ (NSBezierPath*)closePath;
+ (NSBezierPath*)minusPath;
+ (NSBezierPath*)plusPath;
@end
