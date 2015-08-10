//
//  UserInfo.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo;

// 单例类 ，用来获取用户登录状态。
@interface UserInfo : NSObject

@property (nonatomic,assign) BOOL isLogin; // 是否登录
+ (UserInfo *)sharedUserInfo;

@end
