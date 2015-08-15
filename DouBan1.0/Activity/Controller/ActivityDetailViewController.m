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
#import "ActivityDetailView.h" // 导入活动详情视图
#import "Activity.h"

#import "DatabaseHandler.h"

@interface ActivityDetailViewController ()

@property (nonatomic, retain) ActivityDetailView *detailView; // 活动详情视图

@end

@implementation ActivityDetailViewController
- (void)dealloc
{
    [self.activity  release];
    [self.detailView release];
    [super dealloc];
}
- (void)loadView
{
    self.detailView = [[[ActivityDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _detailView; // 指定 controller 视图view。
}

#pragma mark -----显示数据-----
- (void)p_setupData
{
    
    //根据活动内容调整滚动视图的contentSize
    [_detailView adjustSubviewsWithContent:_activity.content];
    
    //活动图片
    
    if (_activity.activityImage == nil) {
        //没有图像，下载图像
        _detailView.activityImageView.image = [UIImage imageNamed:@"picholder"];
        [_activity loadImage];
        
        [_activity addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    }else{
        _detailView.activityImageView.image = _activity.activityImage;
    }
    
    
    //标题
    _detailView.titleLabel.text = _activity.title;
    
    //时间
    NSString * startTime = [_activity.begin_time substringWithRange:NSMakeRange(5, 11)];
    NSString * endTime = [_activity.end_time substringWithRange:NSMakeRange(5, 11)];
    _detailView.timeLabel.text = [NSString stringWithFormat:@"%@ -- %@",startTime,endTime];
    
    //主办方
    _detailView.ownerLabel.text = _activity.ownerName;
    
    //类型
    _detailView.categoryLabel.text = [NSString stringWithFormat:@"类型：%@",_activity.category_name];
    
    //地址
    _detailView.addressLabel.text = _activity.address;
    [_detailView.addressLabel sizeToFit];//label适应文本高度
    
    //内容
    _detailView.contextLabel.text = _activity.content;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动详情";
//    self.view.backgroundColor = [UIColor magentaColor];
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
    
    
    
    // 右收藏按钮
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_share"]  imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(favoriteBarButtonAction:)] autorelease];
    
    // 加载数据
    [self p_setupData];
    
    // Do any additional setup after loading the view.
}
#pragma mark----- 返回按钮执行方法
- (void)backBarButtonAction:(UIBarButtonItem *)buttonItem
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark----- 收藏按钮执行方法
- (void)favoriteBarButtonAction:(UIBarButtonItem *)buttonItem
{
    //  根据单例 UserInfo  判断用户登录状态。
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    
    // 没有登录，让用户登录， 登录成功后执行回调函数
    
    // 登录完成之后，希望，block进行的操作，内部为空，外界赋值，实现了 低耦合的特性。
    // 外界给的block是什么操作， 内部就进行什么操作。
    // 我们要登录完成之后，给数据库添加数据，
    if (NO == userInfo.isLogin) { //
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        // 定义登录成功后回调的block
        __block typeof(self) blockSelf = self;
//        __block ActivityDetailViewController *detailVC = self;
        loginVC.block = ^(id userInfo){
#pragma mark- 回调block 到数据库查询 判断有没有被收藏过
            // 登录成功后，自动收藏活动
            [blockSelf favoriteActivity]; // 防止循环引用
            
        };
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:navC animated:YES completion:nil];
        
        [loginVC release];
        [navC release];
        
        
        
    } else{ // 用户已经登录过了 直接收藏。 因此我们把收藏写成一个方法封装起来
        
        [self favoriteActivity];
    }
}

// 收藏活动
- (void)favoriteActivity
{
    // 1.判断 根据该活动id查询有没有被收藏过，
    BOOL isFavorite = [DatabaseHandler isFavoriteActivityWithID:_activity.ID];
    
    if (isFavorite) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该活动已经被收藏过了" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        return ; // 方法结束
        
        
    } else {
        // 收藏标识 yes
        _activity.isFavorite = YES; // 被收藏
        
        // 插入数据库
        [DatabaseHandler insertNewActivity:_activity];
        
        // 提示
        //显示alertView提示用户
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        
        // 0.3 秒后alertView 消失，使用了 perform  afterDelay
        [self performSelector:@selector(removeAlertView:) withObject:alertView afterDelay:0.3];
    }

}

// 移除提示视图
- (void)removeAlertView:(UIAlertView *)alertView
{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
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
