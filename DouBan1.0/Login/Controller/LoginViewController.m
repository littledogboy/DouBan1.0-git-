//
//  LoginViewController.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegistViewController.h"

#import "FileHandler.h"
#import "LTView.h"
#import "UserInfo.h"
#import "UserInfo.h"

@interface LoginViewController ()

@property (nonatomic,retain) LoginView *loginView;


@end

@implementation LoginViewController


- (void)dealloc
{
    [_loginView release];
    Block_release(_block);
    [super dealloc];
}


- (void)loadView
{
    self.loginView = [[[LoginView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _loginView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";

    //导航栏的返回按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
    //登陆页面的登陆按钮添加响应方法
    [_loginView.loginButton addTarget:self action:@selector(didClickLoginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //登陆页面的注册按钮添加响应方法
    [_loginView.registButton addTarget:self action:@selector(didClickRegistButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}


// 左导航事件
- (void)didClickBackButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


// 点击注册按钮
- (void)didClickRegistButtonAction:(UIButton *)button
{
    //进入注册页面
    RegistViewController * registVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
    [registVC release];
}


// 点击登录按钮， 触发block 执行回掉，添加数据到数据库
- (void)didClickLoginButtonAction:(UIBarButtonItem *)buttonItem
{
    
    //从沙盒中获取用户名和密码
    NSString * username = [[FileHandler shareInstance] username];
    NSString * password = [[FileHandler shareInstance] password];
    
    //验证登陆
    if ([[_loginView.usernameView inputFieldText] isEqualToString:username] && [[_loginView.passwordView inputFieldText] isEqualToString:password]) {
        
        //验证登陆成功，设置用户为登陆状态
        [UserInfo sharedUserInfo].isLogin = YES;
        [[FileHandler shareInstance] setloginState:YES];
        [[FileHandler shareInstance] synchronize];
        
        
        //登陆成功后回调，同时将用户信息回传
        User * user = [[FileHandler shareInstance] user];
        
        
        
        
        self.block(user);
        
        //推出登陆页面
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }else{
        
        //登陆失败，显示提示框，停留在登陆页面
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码错误！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        [alertView release];
        
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
