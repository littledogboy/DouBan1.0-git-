//
//  ActivityDetailView.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/13.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//


/*
 此为活动详情页面。
 
 */
#import <UIKit/UIKit.h>
@class ActivityInfoView;
@class Activity;

// 继承自UIView 因此本身，不能滚动。如果继承自 UITableViewCell 则本身可以滚动。
@interface ActivityDetailView : UIView

// 一共七个控件。
@property (nonatomic,retain,readonly) UIImageView * activityImageView; // 图片
@property (nonatomic,retain,readonly) UILabel * titleLabel; // 标题
@property (nonatomic,retain,readonly) UILabel * timeLabel; // 时间
@property (nonatomic,retain,readonly) UILabel * addressLabel; // 地址
@property (nonatomic,retain,readonly) UILabel * ownerLabel; // 举办者
@property (nonatomic,retain,readonly) UILabel * categoryLabel; // 类型
@property (nonatomic,retain,readonly) UILabel * contextLabel; // 介绍

//根据活动内容调整scrollView和contextLabel的高度
- (void)adjustSubviewsWithContent:(NSString *)content;


// 设置model的时候调整高度。
@property (nonatomic,retain) Activity *activity;


@end
