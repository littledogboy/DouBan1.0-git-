//
//  LTView.h
//  UI03_customView\controller
//
//  Created by 吴书敏 on 15/7/21.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTView : UIView

@property (nonatomic,retain) UILabel *label;
@property (nonatomic,retain) UITextField *textField;
+ (LTView *)ltViewWithFrame:(CGRect)frame labelWidth:(CGFloat)labelWidth horizonSpacing:(CGFloat)HSpacing text:(NSString *)text placeholder:(NSString *)placeholder;

- (instancetype)initWithFrame:(CGRect)frame labelWidth:(CGFloat)labelWidth horizonSpacing:(CGFloat)HSpacing text:(NSString *)text placeholder:(NSString *)placeholder;


@end
