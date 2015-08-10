//
//  ActivityInfoView.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/8.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//  此为展示活动信息的自定义视图

/*
 例如：
 活动图标   活动信息
 时间icon    07-22 09：00 -- 10-16 17：00
 
 */

#import <UIKit/UIKit.h>

@interface ActivityInfoView : UIView

@property (nonatomic,retain, readonly) UIImageView *iconView; // 图标视图
@property (nonatomic,retain, readonly) UILabel *infoLabel; // 活动信息。

@property (nonatomic,retain) NSString *text;

/**
 *  自定义icon_info view初始化方法
 *
 *  @param frame 自定义view 的 frame
 *  @param size  图标大小
 *  @param image 图标
 *  @param info  活动信息
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame sizeOfIcon:(CGSize)size icon:(UIImage *)image infoString:(NSString *)info;

@end
