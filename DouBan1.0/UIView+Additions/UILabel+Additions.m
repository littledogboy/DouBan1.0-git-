//
//  UILabel+Additions.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/8.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "UILabel+Additions.h"

@implementation UILabel (Additions)


// 指定初始化方法
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text alignment:(NSTextAlignment)alignment
{
    // 通过分类添加初始化方法， 使用 self 调用自身的其他方法
    // 通过子类添加初始化方法，使用 super 调用父类方法。
    self = [self initWithFrame:frame];
    if (self) {
        self.text = text;
        self.textAlignment = alignment;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text alignment:(NSTextAlignment)alignment  textColor:(UIColor *)color textFont:(UIFont *)font
{
    self = [self initWithFrame:frame text:text alignment:alignment];
    if (self) {
        self.textColor = color;
        self.font = font;
    }
    return self;
}





@end
