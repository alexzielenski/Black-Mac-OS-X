//
//  NSFrameView.h
//  Frames
//
//  Created by Joe on 1/14/09.
//  Copyright 2009 Xsilva Systems Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSFrameView : NSView
{
    unsigned int styleMask;
    NSString *_title;
    NSCell *titleCell;
    NSButton *closeButton;
    NSButton *zoomButton;
    NSButton *minimizeButton;
    BOOL resizeByIncrement;
    BOOL unused;
    unsigned char tabViewCount;
    NSSize resizeParameter;
    int shadowState;
}

+ (void)initialize;
+ (void)initTitleCell:(id)fp8 styleMask:(unsigned int)fp12;
+ (NSRect)frameRectForContentRect:(NSRect)fp8 styleMask:(unsigned int)fp24;
+ (NSRect)contentRectForFrameRect:(NSRect)fp8 styleMask:(unsigned int)fp24;
+ (NSSize)minFrameSizeForMinContentSize:(NSSize)fp8 styleMask:(unsigned int)fp16;
+ (NSSize)minContentSizeForMinFrameSize:(NSSize)fp8 styleMask:(unsigned int)fp16;
+ (float)minFrameWidthWithTitle:(id)fp8 styleMask:(unsigned int)fp12;
+ (unsigned int)_validateStyleMask:(unsigned int)fp8;
- (id)initWithFrame:(NSRect)fp8 styleMask:(unsigned int)fp24 owner:(id)fp28;
- (id)initWithFrame:(NSRect)fp8;
- (void)dealloc;
- (void)shapeWindow;
- (void)tileAndSetWindowShape:(BOOL)fp8;
- (void)tile;
- (void)drawRect:(NSRect)fp8;
- (void)_drawFrameRects:(NSRect)fp8;
- (void)drawFrame:(NSRect)fp8;
- (void)drawThemeContentFill:(NSRect)fp8 inView:(id)fp24;
- (void)drawWindowBackgroundRect:(NSRect)fp8;
- (void)drawWindowBackgroundRegion:(void *)fp8;
- (float)contentAlpha;
- (void)_windowChangedKeyState;
- (void)_updateButtonState;
- (BOOL)_isSheet;
- (BOOL)_isUtility;
- (void)setShadowState:(int)fp8;
- (int)shadowState;
- (BOOL)_canHaveToolbar;
- (BOOL)_toolbarIsInTransition;
- (BOOL)_toolbarIsShown;
- (BOOL)_toolbarIsHidden;
- (void)_showToolbarWithAnimation:(BOOL)fp8;
- (void)_hideToolbarWithAnimation:(BOOL)fp8;
- (float)_distanceFromToolbarBaseToTitlebar;
- (int)_shadowType;
- (unsigned int)_shadowFlags;
- (void)_setShadowParameters;
- (void)_drawFrameShadowAndFlushContext:(id)fp8;
- (void)setUpGState;
- (void)adjustHalftonePhase;
- (void)systemColorsDidChange:(id)fp8;
- (id)frameColor;
- (id)contentFill;
- (void)tabViewAdded;
- (void)tabViewRemoved;
- (id)title;
- (void)setTitle:(id)fp8;
- (id)titleCell;
- (void)initTitleCell:(id)fp8;
- (void)setResizeIncrements:(NSSize)fp8;
- (NSSize)resizeIncrements;
- (void)setAspectRatio:(NSSize)fp8;
- (NSSize)aspectRatio;
- (unsigned int)styleMask;
- (id)representedFilename;
- (void)setRepresentedFilename:(id)fp8;
- (void)setDocumentEdited:(BOOL)fp8;
- (void)_setFrameNeedsDisplay:(BOOL)fp8;
- (BOOL)frameNeedsDisplay;
- (id)defaultTitleFont;
- (id)titleFont;
- (NSRect)_maxTitlebarTitleRect;
- (NSRect)titlebarRect;
- (void)_setUtilityWindow:(BOOL)fp8;
- (void)_setNonactivatingPanel:(BOOL)fp8;
- (void)setIsClosable:(BOOL)fp8;
- (void)setIsResizable:(BOOL)fp8;
- (id)closeButton;
- (id)minimizeButton;
- (id)zoomButton;
- (NSSize)miniaturizedSize;
- (void)_clearDragMargins;
- (NSRect)_draggableFrame;
- (void)_resetDragMargins;
- (void)addSubview:(id)fp8;
- (void)setTitle:(id)fp8 andDefeatWrap:(BOOL)fp12;
- (NSRect)frameRectForContentRect:(NSRect)fp8 styleMask:(unsigned int)fp24;
- (NSRect)contentRectForFrameRect:(NSRect)fp8 styleMask:(unsigned int)fp24;
- (NSSize)minFrameSizeForMinContentSize:(NSSize)fp8 styleMask:(unsigned int)fp16;
- (NSRect)dragRectForFrameRect:(NSRect)fp8;
- (NSRect)contentRect;
- (NSSize)minFrameSize;

@end
