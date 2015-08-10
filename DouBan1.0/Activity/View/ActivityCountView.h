//
//  ActivityCountView.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/9.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 此为 活动列表视图 count count 视图
 例如： 
 感兴趣： 531  参加： 532
 */
@interface ActivityCountView : UIView

@property (nonatomic,retain,readonly) UILabel *typeLabel;
@property (nonatomic,retain,readonly) UILabel *countLabel;

@property (nonatomic,retain) NSString *count;

- (instancetype)initWithFrame:(CGRect)frame type:(NSString *)type count:(NSString *)count;

@end
