//
//  LoginViewController.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LoginBlock) (NSString *str);


@interface LoginViewController : UIViewController
// block 属性，接受外界传递的方法。
@property (nonatomic,copy) LoginBlock block;


@end
