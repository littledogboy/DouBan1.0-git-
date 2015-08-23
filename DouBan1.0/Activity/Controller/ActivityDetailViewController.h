//
//  ActivityDetailViewController.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Activity; // 详情页面控制器需要接受前面传递过来的一个 model

@interface ActivityDetailViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic,retain) Activity *activity;

@end
