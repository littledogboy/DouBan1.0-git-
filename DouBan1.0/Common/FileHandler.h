//
//  FileHandler.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/15.
//  Copyright (c) 2015年 吴书敏. All rights reserved.


//  此为文件操作类 负责一些沙盒的路径操作， NSUserDefault 也属于沙盒操作。

#import <Foundation/Foundation.h>

@class User;
@interface FileHandler : NSObject


+ (FileHandler *)shareInstance;

#pragma mark ----用户信息-----
//同步
- (void)synchronize;

//设置用户信息  setObject: Forkey:
- (void)setloginState:(BOOL)isLogin;
- (void)setUsername:(NSString *)username;
- (void)setPassword:(NSString *)password;
- (void)setEmail:(NSString *)email;
- (void)setPhoneNumber:(NSString *)phone;

//获取用户信息 objectForKey:
- (BOOL)loginState;
- (NSString *)username;
- (NSString *)password;
- (NSString *)emailAddress;
- (NSString *)phoneNumber;

- (User *)user;


@end


@interface User : NSObject

@property (nonatomic,retain) NSString * username;
@property (nonatomic,retain) NSString * password;
@property (nonatomic,retain) NSString * emailAddress;
@property (nonatomic,retain) NSString * phoneNumber;

@property (nonatomic,assign) BOOL isLogin;

@end
