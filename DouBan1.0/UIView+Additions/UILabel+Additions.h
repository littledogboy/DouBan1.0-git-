//
//  UILabel+Additions.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/8.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Additions)

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text alignment:(NSTextAlignment)alignment;

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text alignment:(NSTextAlignment)alignment  textColor:(UIColor *)color textFont:(UIFont *)font;


@end
