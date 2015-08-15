//
//  LTView.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/15.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LTView : UIView

@property (nonatomic,retain,readonly) UILabel * descriptionLabel;
@property (nonatomic,retain,readonly) UITextField *inputField;

//初始化方法，指定label上显示的文字
- (instancetype)initWithFrame:(CGRect)frame description:(NSString *)labelText placeholder:(NSString *)placeholderText;


//设置label显示的文字
- (void)setDecription:(NSString *)description;
//获取输入框里的内容
- (NSString *)descriptionText;

//获取输入框的内容
- (NSString *)inputFieldText;

//输入框是否 密码格式
- (void)setSecureTextEnabled:(BOOL)isSecureText;

//设置textField代理
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)fieldDelegate;

//textfield回收键盘
- (void)recyleKeyboard;

@end
