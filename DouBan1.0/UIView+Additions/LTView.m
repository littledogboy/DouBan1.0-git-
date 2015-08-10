//
//  LTView.m
//  UI03_customView\controller
//
//  Created by 吴书敏 on 15/7/21.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "LTView.h"

@implementation LTView
- (void)dealloc
{
    [_label release];
    [_textField release];
    [super dealloc];
}

+ (LTView *)ltViewWithFrame:(CGRect)frame labelWidth:(CGFloat)labelWidth horizonSpacing:(CGFloat)HSpacing text:(NSString *)text placeholder:(NSString *)placeholder
{
    return [[[LTView alloc] initWithFrame:frame labelWidth:labelWidth horizonSpacing:HSpacing text:text placeholder:placeholder] autorelease];
}

- (instancetype)initWithFrame:(CGRect)frame labelWidth:(CGFloat)labelWidth horizonSpacing:(CGFloat)HSpacing text:(NSString *)text placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        // ltv总宽度
        CGFloat totalWidth = frame.size.width;
        // ltv总高度
        CGFloat totalHeight = frame.size.height;
        // ltv 里面有两个控件一个是 label ，一个是 textfield
        _label = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0,labelWidth, totalHeight))];
        _label.text = text; // label显示的text
        [self addSubview:_label]; // 把label添加到ltview 上面。
        //
        CGFloat tfx = labelWidth + HSpacing;
        CGFloat tfWidth = totalWidth - labelWidth - HSpacing;
        _textField = [[UITextField alloc] initWithFrame:(CGRectMake(tfx, 0, tfWidth, totalHeight))];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.placeholder = placeholder;
        [self addSubview:_textField];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
