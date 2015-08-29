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


#pragma mark--- 清除沙盒中的图片缓存

// 下载图片文件夹
- (NSString *)downloadImageDirPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // cache 路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    // 下载图片文件夹
    NSString *imageManagerPath = [cachePath stringByAppendingPathComponent:@"DownloadImages"];
    
    // 判断文件夹是否存在，不存在创建，
    if (NO == [fileManager fileExistsAtPath:imageManagerPath]) {
    
        [fileManager createDirectoryAtPath:imageManagerPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 返回文件夹路径
    return imageManagerPath;
}

// 图片路径
- (NSString *)imageSandBoxPathWithURL:(NSString *)url
{
    // 根据图片的url，创建文件在存储时的文件名
    NSString *newUrl = [url stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    // 返回图片路径
    return [[self downloadImageDirPath] stringByAppendingPathComponent:newUrl];
}

// 清除沙盒里面缓存下来的图片。
- (void)cleanDownloadImages
{
    NSString *downloadDirPath = [self downloadImageDirPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    [fileManager removeItemAtPath:downloadDirPath error:&error];
    
    if (error != nil) {
        NSLog(@"%s %d 清除图片缓存出错!", __FUNCTION__, __LINE__);
    }
    
    // 清除之后，创建一个空的文件夹
    [self downloadImageDirPath];
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

