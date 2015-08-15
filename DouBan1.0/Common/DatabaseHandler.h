//
//  DatabaseHandler.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/14.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

/*
 此为数据库 处理相关操作  单例类
 1. 需要导入 libsqlite3.0.dylib  框架。
 2. 需要引入头文件 libsqlite3.h
 */

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class Activity;
@class Movie;

@interface DatabaseHandler : UIView

// 打开数据库
+ (sqlite3 *)open;

// 关闭数据库
- (void)close;

#pragma mark--- Activity 数据库操作
// 添加 某个活动
+ (BOOL)insertNewActivity:(Activity *)activity;

// 删除 某个活动
//+ (BOOL)deleteActivityWithID:(NSInteger)ID;
+ (BOOL)deleteActivity:(Activity *)activity;


// 查询 某个活动
+ (Activity *)selectActivityWithID:(NSString *)ID;

// 查询 所有活动
+ (NSArray *)selectAllActivitys;

// 判断活动是否被收藏
+ (BOOL)isFavoriteActivityWithID:(NSString *)ID;


#pragma Movie--- Movie 数据库操作
// 添加 某个电影
+ (BOOL)insertNewMovie:(Movie *)movie;

// 删除 某个电影
//+ (BOOL)deleteActivityWithID:(NSInteger)ID;
+ (BOOL)deleteMovie:(Movie *)movie;


// 查询 某个电影
+ (Activity *)selectMovieWithID:(NSInteger)ID;

// 查询 所有电影
+ (NSArray *)selectAllMovies;

// 判断电影是否被收藏
+ (BOOL)isFavoriteMovieWithID:(NSInteger)ID;




@end
