//
//  BMXThemeFrame.h
//  Black Mac OS X
//
//  Created by Alex Zielenski on 2/5/11.
//  Copyright 2011 Alex Zielenski. All rights reserved.
//
#import "NSBezierPath+PXRoundedRectangleAdditions.h"
#import "BMXController.h"

#import "NSThemeFrame.h"

@interface NSThemeFrame (BMXThemeFrame)
- (void)new_drawTitleBar:(struct CGRect)arg1;	// IMP=0x001023e0
- (void)new_drawFrame:(struct CGRect)arg1;
- (id)new_customTitleCell;

- (void)drawBottomBar;
- (void)drawTitleBar;

- (void)new_drawRect:(NSRect)fp8;
- (void)drawHighlightsWithCorners:(BOOL)useCorners;

- (void)drawTitleGradientInRect:(NSRect)titleRect cornerRadius:(CGFloat)cornerRadius roundCorners:(OSCornerType)corner onTop:(BOOL)top;
- (NSGradient*)titleGradient;

- (void)new_dealloc;

- (void)_windowChangedKeyState;

@end
