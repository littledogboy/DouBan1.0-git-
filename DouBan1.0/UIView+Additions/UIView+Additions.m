//
//  UIView+Additions.m
//  AGExtension
//
//  Created by 吴书敏 on 15/7/17.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//
#import "UIView+Additions.h"
    

@implementation UIView (Frame)

// X
- (void)setFrameOriginX:(CGFloat)frameOriginX
{
    self.frame = CGRectMake(frameOriginX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameOriginX
{
    return self.frame.origin.x;
}

// Y
- (void)setFrameOriginY:(CGFloat)frameOriginY
{
    self.frame = CGRectMake(self.frame.origin.x , frameOriginY, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameOriginY
{
    return self.frame.origin.y;
}
// width
- (void)setFrameSizeWidth:(CGFloat)frameSizeWidth
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, frameSizeWidth, self.frame.size.height);
}

- (CGFloat)frameSizeWidth
{
    return self.frame.size.width;
}

// height
- (void)setFrameSizeHeight:(CGFloat)frameSizeHeight
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, frameSizeHeight);
}

- (CGFloat)frameSizeHeight
{
    return self.frame.size.height;
}

// origin
- (void)setFrameOrigin:(CGPoint)frameOrigin
{
    self.frame = CGRectMake(frameOrigin.x, frameOrigin.y, self.frameSizeWidth, self.frameSizeHeight);
}

- (CGPoint)frameOrigin
{
    return CGPointMake(self.frameOriginX, self.frameOriginY);
}

// size
- (void)setFrameSize:(CGSize)frameSize
{
    self.frame = CGRectMake(self.frameOriginX, self.frameOriginY, frameSize.width, frameSize.height);
}

- (CGSize)frameSize
{
    return CGSizeMake(self.frameSizeWidth, self.frameSizeWidth);
}


@end
