//
//  NSTitledFrame.h
//  Frames
//
//  Created by Joe on 1/14/09.
//  Copyright 2009 Xsilva Systems Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSFrameView.h"

@interface NSTitledFrame : NSFrameView
{
    int resizeFlags;
    //NSDocumentDragButton *fileButton;
	id fileButton;
    NSSize titleCellSize;
}

+ (void)initialize;
+ (float)_windowBorderThickness:(unsigned int)fp8;
+ (float)_minXWindowBorderWidth:(unsigned int)fp8;
+ (float)_maxXWindowBorderWidth:(unsigned int)fp8;
+ (float)_minYWindowBorderHeight:(unsigned int)fp8;
+ (BOOL)_resizeFromEdge;
+ (NSRect)frameRectForContentRect:(NSRect)fp8 styleMask:(unsigned int)fp24;
+ (NSRect)contentRectForFrameRect:(NSRect)fp8 styleMask:(unsigned int)fp24;
+ (NSSize)minFrameSizeForMinContentSize:(NSSize)fp8 styleMask:(unsigned int)fp16;
+ (NSSize)minContentSizeForMinFrameSize:(NSSize)fp8 styleMask:(unsigned int)fp16;
+ (float)minFrameWidthWithTitle:(id)fp8 styleMask:(unsigned int)fp12;
+ (NSSize)_titleCellSizeForTitle:(id)fp8 styleMask:(unsigned int)fp12;
+ (float)_titleCellHeight:(unsigned int)fp8;
+ (float)_windowTitlebarTitleMinHeight:(unsigned int)fp8;
+ (float)_titlebarHeight:(unsigned int)fp8;
+ (NSSize)sizeOfTitlebarButtons:(unsigned int)fp8;
+ (float)windowTitlebarLinesSpacingWidth:(unsigned int)fp8;
+ (float)windowTitlebarTitleLinesSpacingWidth:(unsigned int)fp8;
+ (float)_contentToFrameMinXWidth:(unsigned int)fp8;
+ (float)_contentToFrameMaxXWidth:(unsigned int)fp8;
+ (float)_contentToFrameMinYHeight:(unsigned int)fp8;
+ (float)_contentToFrameMaxYHeight:(unsigned int)fp8;
- (void)dealloc;
- (BOOL)isOpaque;
- (BOOL)worksWhenModal;
- (void)propagateFrameDirtyRects:(NSRect)fp8;
- (void)_showDrawRect:(NSRect)fp8;
- (id)frameHighlightColor;
- (id)frameShadowColor;
- (void)setFrameOrigin:(NSPoint)fp8;
- (void)tileAndSetWindowShape:(BOOL)fp8;
- (void)tile;
- (void)setTitle:(id)fp8;
- (void)_drawTitleStringIn:(NSRect)fp8 withColor:(id)fp24;
- (id)titleFont;
- (id)titleButtonOfClass:(Class)fp8;
- (id)initTitleButton:(id)fp8;
- (id)newCloseButton;
- (id)newZoomButton;
- (id)newMiniaturizeButton;
- (id)newFileButton;
- (id)fileButton;
- (BOOL)_eventInTitlebar:(id)fp8;
- (BOOL)acceptsFirstMouse:(id)fp8;
- (void)mouseDown:(id)fp8;
- (void)mouseUp:(id)fp8;
- (unsigned int)resizeEdgeForEvent:(id)fp8;
- (NSSize)_resizeDeltaFromPoint:(NSPoint)fp8 toEvent:(id)fp16;
- (NSRect)_validFrameForResizeFrame:(NSRect)fp8 fromResizeEdge:(unsigned int)fp24;
- (NSRect)frame:(NSRect)fp8 resizedFromEdge:(unsigned int)fp24 withDelta:(NSSize)fp28;
- (void)resizeWithEvent:(id)fp8;
- (int)resizeFlags;
- (void)setDocumentEdited:(BOOL)fp8;
- (NSSize)miniaturizedSize;
- (NSSize)minFrameSize;
- (float)_windowBorderThickness;
- (float)_windowTitlebarXResizeBorderThickness;
- (float)_windowTitlebarYResizeBorderThickness;
- (float)_windowResizeBorderThickness;
- (float)_minXWindowBorderWidth;
- (float)_maxXWindowBorderWidth;
- (float)_minYWindowBorderHeight;
- (id)_customTitleCell;
- (void)_invalidateTitleCellWidth;
- (float)_titleCellHeight;
- (NSSize)_titleCellSize;
- (float)_titlebarHeight;
- (NSRect)titlebarRect;
- (NSRect)_maxTitlebarTitleRect;
- (NSRect)_titlebarTitleRect;
- (float)_windowTitlebarTitleMinHeight;
- (NSRect)dragRectForFrameRect:(NSRect)fp8;
- (NSSize)sizeOfTitlebarButtons;
- (NSSize)_sizeOfTitlebarFileButton;
- (float)_windowTitlebarButtonSpacingWidth;
- (float)_minXTitlebarButtonsWidth;
- (float)_maxXTitlebarButtonsWidth;
- (float)windowTitlebarLinesSpacingWidth;
- (float)windowTitlebarTitleLinesSpacingWidth;
- (float)_minLinesWidthWithSpace;
- (NSPoint)_closeButtonOrigin;
- (NSPoint)_zoomButtonOrigin;
- (NSPoint)_collapseButtonOrigin;
- (NSPoint)_fileButtonOrigin;
- (float)_maxYTitlebarDragHeight;
- (float)_minXTitlebarDragWidth;
- (float)_maxXTitlebarDragWidth;
- (float)_contentToFrameMinXWidth;
- (float)_contentToFrameMaxXWidth;
- (float)_contentToFrameMinYHeight;
- (float)_contentToFrameMaxYHeight;
- (NSRect)contentRect;
- (float)_windowResizeCornerThickness;
- (NSRect)_minYResizeRect;
- (NSRect)_minYminXResizeRect;
- (NSRect)_minYmaxXResizeRect;
- (NSRect)_minXResizeRect;
- (NSRect)_minXminYResizeRect;
- (NSRect)_minXmaxYResizeRect;
- (NSRect)_maxYResizeRect;
- (NSRect)_maxYminXResizeRect;
- (NSRect)_maxYmaxXResizeRect;
- (NSRect)_maxXResizeRect;
- (NSRect)_maxXminYResizeRect;
- (NSRect)_maxXmaxYResizeRect;
- (NSRect)_minXTitlebarResizeRect;
- (NSRect)_maxXTitlebarResizeRect;
- (NSRect)_minXBorderRect;
- (NSRect)_maxXBorderRect;
- (NSRect)_maxYBorderRect;
- (NSRect)_minYBorderRect;

@end