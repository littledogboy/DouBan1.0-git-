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
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(collectActivity:)] autorelease];
    
    // Do any additional setup after loading the view.
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
