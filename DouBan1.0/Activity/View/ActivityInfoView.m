//
//  ActivityInfoView.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/8.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "ActivityInfoView.h"
#import "UILabel+Additions.h"

@implementation ActivityInfoView
- (void)dealloc
{
    [_iconView release];
    [_infoLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame sizeOfIcon:(CGSize)size icon:(UIImage *)image infoString:(NSString *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat totalWidth = frame.size.width;
        CGFloat totalHeight = frame.size.height;
        _iconView = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, size.width, size.height))];
        _iconView.image = image;
        [self addSubview:_iconView];
        
        CGRect textRect = CGRectMake(size.width, 0, totalWidth - size.width , totalHeight);
        // label的分类初始化方法。
        _infoLabel = [[UILabel alloc] initWithFrame:textRect text:info alignment:(NSTextAlignmentLeft)];
        [self addSubview:_infoLabel];
        
    }
    return self;
}


// 设置 text值
- (void)setText:(NSString *)text
{
    if (_text != text ) {
        [_text release];
        _text = [text retain];
        
        _infoLabel.text = _text;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
