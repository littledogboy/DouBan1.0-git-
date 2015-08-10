//
//  ActivityCountView.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/9.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "ActivityCountView.h"
#import "UILabel+Additions.h"

@implementation ActivityCountView
- (void)dealloc
{
    [_typeLabel release];
    [_countLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame type:(NSString *)type count:(NSString *)count
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat totalWidth = frame.size.width;
        CGFloat totalHeight = frame.size.height;
        
        _typeLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, totalWidth * 0.5, totalHeight)) text:type alignment:(NSTextAlignmentRight) textColor:[UIColor blackColor] textFont:[UIFont systemFontOfSize:14]];
        [self addSubview:_typeLabel];
        
        _countLabel = [[UILabel alloc] initWithFrame:(CGRectMake(totalWidth * 0.5, 0, totalWidth * 0.5, totalHeight)) text:count alignment:(NSTextAlignmentLeft) textColor:[UIColor redColor] textFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [self addSubview:_countLabel]; // 一定要记得添加啊大哥。
         
    }
    return self;
}

- (void)setCount:(NSString *)count
{
    if (_count != count) {
        [_count release];
        _count = [count retain];

        _countLabel.text = count;
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
