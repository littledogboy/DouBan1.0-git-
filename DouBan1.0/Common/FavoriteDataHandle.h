//
//  FavoriteDataHandle.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/15.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Activity;


@interface FavoriteDataHandle : NSObject

+ (FavoriteDataHandle *)shareInstance;

#pragma mark ------Activity活动 数据源-------
//从数据库读取“活动”的数据源
- (void)setupActivityDataSource;
//获取活动的个数
- (NSInteger)countOfActivity;
//获取某个活动对象
- (Activity *)activityForRow:(NSInteger)row;
//删除某个活动对象
- (void)deleteActivityForRow:(NSInteger)row;

@end
