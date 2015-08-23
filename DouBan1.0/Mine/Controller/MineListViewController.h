//
//  MineListViewController.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 此为我的界面，基本布局为表视图， 
 包含  “我的活动” “我的电影” 等等 单元格
 
 单击我的 “我的活动” 活动收藏页面 进入到活动收藏页面，显示所有 数据库中 收藏的活动。
 单击 活动收藏页面  里面的某一个活动， 进入活动详情页面， 显示详情信息。
 
 小技巧，单独再封装一个收藏数据库，源数据库中读取信息。
 
 */
// 我的界面。
@interface MineListViewController : UITableViewController<UIAlertViewDelegate>

@end
