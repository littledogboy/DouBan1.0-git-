//
//  ActivityDetailViewController.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "UserInfo.h"
#import "LoginViewController.h"

@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
    self.view.backgroundColor = [UIColor magentaColor];
    // **左返回按钮
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]  style:(UIBarButtonItemStylePlain) target:self action:@selector(backBarButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    // 在iOS8 系统下，UITabbar UINavigationBar 上的item自定义背景色和图片，
    // 初始值 红色无效果 系统默认颜色-蓝色,如果不设置图片的渲染模式会调用自动渲染。
    // 声明这张图片用原图(别渲染),
    // UIImage的渲染模式 为iOS7 新增的，默认为 UIImageRenderingModeAutomatic
    // imageWithRenderingMode:
    
    /*
     UIImageRenderingModeAutomatic  // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
     UIImageRenderingModeAlwaysOriginal   // 始终绘制图片原始状态，不使用Tint Color。
     UIImageRenderingModeAlwaysTemplate   // 始终根据Tint Color绘制图片，忽略图片的颜色信息。
     */
    
    
    
    //
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(collectActivity:)] autorelease];
    
    // Do any additional setup after loading the view.
}
#pragma mark----- 返回按钮执行方法
- (void)backBarButtonAction:(UIBarButtonItem *)buttonItem
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark----- 收藏按钮执行方法
- (void)collectActivity:(UIBarButtonItem *)buttonItem
{
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    if (NO == userInfo.isLogin) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.block = ^(NSString *str){
            NSLog(@"%@", str);
        };
        
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:navC animated:YES completion:nil];
        
        [loginVC release];
        [navC release];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
