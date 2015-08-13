//
//  UserInfo.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "UserInfo.h"

static UserInfo *userInfo = nil;

@implementation UserInfo

+ (UserInfo *)sharedUserInfo
{
    @synchronized(self)
    {
        if (userInfo == nil) {
            userInfo = [[UserInfo alloc] init];
        }
        return userInfo;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLogin = NO; // 初始状态为未登录状态
    }
    return self;
}

@end
