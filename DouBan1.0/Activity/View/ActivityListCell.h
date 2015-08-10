//
//  ActivityListCell.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/8.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageDownLoader.h"

@class ActivityInfoView;
@class ActivityCountView;
@class Activity;

@interface ActivityListCell : UITableViewCell <ImageDownLoaderDelegate>

// 活动列表单元格一共由9个控件组成。 一蓝； 一白背景图；标题； 三个 信息视图， 两个 人数视图， 一个缩略图视图。
@property (nonatomic,retain,readonly) UIImageView *blueImageView;
@property (nonatomic,retain,readonly) UIImageView *whiteImageView;
@property (nonatomic,retain,readonly) UIImageView *activityImage;

@property (nonatomic,retain,readonly) UILabel *titleLabel;

@property (nonatomic,retain,readonly) ActivityInfoView *timeInfoView;
@property (nonatomic,retain,readonly) ActivityInfoView *addressInfoView;
@property (nonatomic,retain,readonly) ActivityInfoView *categoryInfoView;

@property (nonatomic,retain,readonly) ActivityCountView *interestView;
@property (nonatomic,retain,readonly) ActivityCountView *joinView;


@property (nonatomic,retain) Activity *activity;

// 单元格高度
+ (CGFloat)cellHeight;



@end
