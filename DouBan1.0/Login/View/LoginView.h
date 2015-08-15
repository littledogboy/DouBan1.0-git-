//
//  LoginView.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/15.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LTView;

@interface LoginView : UIView

@property (nonatomic,retain,readonly) LTView * usernameView;
@property (nonatomic,retain,readonly) LTView * passwordView;
@property (nonatomic,retain,readonly) UIButton * loginButton;
@property (nonatomic,retain,readonly) UIButton * registButton;


@end
