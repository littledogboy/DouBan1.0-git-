//
//  FavoriteDataHandle.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/15.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "FavoriteDataHandle.h"
#import "Activity.h" 

#import "DatabaseHandler.h" // 导入数据库管理类

@interface FavoriteDataHandle ()

// 用来存储数据库中收藏的活动
@property (nonatomic,retain) NSMutableArray * activityArray;


@end

static FavoriteDataHandle * handle = nil;


@implementation FavoriteDataHandle
- (void)dealloc
{
    [_activityArray release];
    [super dealloc];
}
// 单例。
+ (FavoriteDataHandle *)shareInstance
{
    if (handle == nil) {
        handle = [[FavoriteDataHandle alloc] init];
        
    }
    
    return handle;
}

#pragma mark ------Activity活动 数据源-------
//从数据库读取“活动”的数据源
- (void)setupActivityDataSource
{
    // 通过数据库连接， 查询所有 活动。把返回值拷贝为可变数据
    // 拷贝了一个可变对象
    self.activityArray = [[DatabaseHandler selectAllActivitys] mutableCopy];
}

//获取活动的个数
- (NSInteger)countOfActivity
{
    return [_activityArray count];
}

//获取某个活动对象
- (Activity *)activityForRow:(NSInteger)row
{
    return _activityArray[row];
}

//删除某个活动对象
- (void)deleteActivityForRow:(NSInteger)row
{
    //从数据库删除 某个数据
    [DatabaseHandler deleteActivity:[self activityForRow:row]];
    //从数据源删除
    [_activityArray removeObjectAtIndex:row];
    
}








@end
