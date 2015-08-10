//
//  UIView+Additions.h
//  AGExtension
//
//  Created by 吴书敏 on 15/7/17.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 UIView的分类:Frame
 作用：  转化了view.frame.origin.x = value; 直接赋值。
        view.frame.origin.x   == view.x
 */
@interface UIView (Frame)

@property (nonatomic,assign) CGFloat frameOriginX;
@property (nonatomic,assign) CGFloat frameOriginY;
@property (nonatomic,assign) CGFloat frameSizeWidth;
@property (nonatomic,assign) CGFloat frameSizeHeight;
@property (nonatomic,assign) CGPoint frameOrigin;
@property (nonatomic,assign) CGSize  frameSize;

@end

