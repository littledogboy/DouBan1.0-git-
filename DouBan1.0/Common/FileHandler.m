//
//  FileHandler.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/15.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#pragma mark -------用户信息 key--------

#define kUserName     @"username"
#define kPassword     @"password"
#define kLoginState   @"isLogin"
#define kIconUrl      @"iconUrl"
#define kEmailAddress @"email"
#define kPhoneNumber  @"phone"

#import "FileHandler.h"

static FileHandler * fileHandler = nil;


@implementation FileHandler


+ (FileHandler *)shareInstance
{
    if (fileHandler == nil) {
        
        fileHandler = [[FileHandler alloc] init];
        
    }
    
    return fileHandler;
}


#pragma mark ----用户信息-----

//同步
- (void)synchronize
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//设置用户信息
- (void)setloginState:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:kLoginState];
}
- (void)setUsername:(NSString *)username
{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:kUserName];
}
- (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kPassword];
    
}
- (void)setEmail:(NSString *)email
{
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:kEmailAddress];
    
}
- (void)setPhoneNumber:(NSString *)phone
{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:kPhoneNumber];
    
}


//获取用户信息
- (BOOL)loginState
{
    return     [[NSUserDefaults standardUserDefaults] boolForKey:kLoginState];
    
}
- (NSString *)username
{
    return     [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    
}
- (NSString *)password
{
    return     [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
    
}
- (NSString *)emailAddress
{
    return     [[NSUserDefaults standardUserDefaults] objectForKey:kEmailAddress];
    
}
- (NSString *)phoneNumber
{
    return     [[NSUserDefaults standardUserDefaults] objectForKey:kPhoneNumber];
    
}


- (User *)user
{
    User * user = [[User alloc] init];
    user.username = [self username];
    user.password = [self password];
    user.emailAddress = [self emailAddress];
    user.phoneNumber = [self phoneNumber];
    user.isLogin = YES;
    
    return [user autorelease];
}


@end



@implementation User

- (void)dealloc
{
    self.username = nil;
    self.password = nil;
    self.emailAddress = nil;
    self.phoneNumber = nil;
    [super dealloc];
}

@end

