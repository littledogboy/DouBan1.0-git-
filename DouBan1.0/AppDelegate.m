//
//  AppDelegate.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "AppDelegate.h"
#import "ActivityListViewController.h"
#import "CinemaListViewController.h"
#import "MovieListViewController.h"
#import "MineListViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
- (void)dealloc
{
    [_window release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    // 活动列表
    ActivityListViewController *activityVC = [[ActivityListViewController alloc] init];
    activityVC.title = @"活动";
    UINavigationController *activityNC = [[UINavigationController alloc] initWithRootViewController:activityVC];
    
//    
//    [activityNC.navigationBar setBackgroundImage:@"" forBarMetrics:(UIBarMetricsDefault)];
    [activityNC.navigationBar  setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:(UIBarMetricsDefault)];
    
    // *** 自定义导航条
    // 系统默认的 导航条样式有四种，一般我们都使用自定义的导航条。
    // ***给navigationBar 设置背景图 setBackgroundImage:[UIImage imageNamed:] for
    // forBarMetrics:导航条尺寸
    // UIBarMetricsDefault  默认的， 竖屏平铺。
    // UIBarMetricsDefaultPrompt 透明的
    // UIBarMetricsCompact  透明导航条
    // UIBarMetricsCompactPrompt 透明的
    
    
    
    // 电影列表
    MovieListViewController *movieVC = [[MovieListViewController alloc] init];
    movieVC.title = @"电影";
    UINavigationController *movieNC = [[UINavigationController alloc] initWithRootViewController:movieVC];
    
    // 影院列表
    CinemaListViewController *cinemaVC = [[CinemaListViewController alloc] init];
    cinemaVC.title = @"影院";
    UINavigationController *cinemaNC = [[UINavigationController alloc] initWithRootViewController:cinemaVC];
    
    // 我的列表
    MineListViewController *mineVC = [[MineListViewController alloc] init];
    mineVC.title = @"我的";
    UINavigationController *mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    
    // tabBarController
    UITabBarController *rootBC = [[UITabBarController alloc] init];
    rootBC.viewControllers = @[activityNC, movieNC, cinemaNC, mineNC];
    
    self.window.rootViewController = rootBC;
    [rootBC release];
    
    [activityVC release];
    [activityNC release];
    
    [movieVC release];
    [movieNC release];
    
    [cinemaVC release];
    [cinemaNC release];
    
    [mineVC release];
    [mineNC release];
    
    NSLog(@"%@", NSHomeDirectory());

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
