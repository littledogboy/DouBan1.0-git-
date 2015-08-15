//
//  DatabaseHandler.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/14.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//



#import "DatabaseHandler.h"
#import "Activity.h"

#define kDatabaseName @"DouBan.sqlite" // 数据库名
#define kActivityArchiverKey @"activity_"

static sqlite3 *db = nil;

@implementation DatabaseHandler


// 打开数据库, 如果没有数据库 创建数据库
+ (sqlite3 *)open
{
    if (db != nil) {
        return db;
    } else{
        
#pragma mark- 以sqlite3动态连接库创建数据库

        // sqlte3 可以使用 动态链接库 编写 sql 语句创建数据库表。如果数据库文件已经存在，则直接打开。否则创建 (或者拷贝后，把包里面db拷贝到 沙盒中 ) 再打开。
        // 数据库存储在 Documents 里。路径为~Documents/DouBan.sqlite
        NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kDatabaseName];
        // 打开shujuku
        int result = sqlite3_open(dbPath.UTF8String, &db);
        if (result == SQLITE_OK) {
            NSLog(@"数据库打开成功");
            
#pragma mark---- 创建数据库表

            // ActivityInfo ,  MovieInfo
            
            //| ID      | title     | imageUrl     |  data     |
            // text   text         text            blob
            // primary key
            // not null
            
            // 创建数据库表sql语句， 若已经创建过则不会再创建  数据库自己会判断。table studentInfo already exists
            // AUTOINCREMENT
            NSString *createTableSql = @"CREATE TABLE ActivityInfo (ID TEXT PRIMARY KEY  NOT NULL, title TEXT, imageUrl TEXT,data BLOB); CREATE TABLE MovieInfo(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, imageUrl TEXT, data BLOB)";
            // 敲出来之后 ：  sqliteManager 用数据库软件验证一下
            
            // 执行非查询 ，sql 语句 , 可以使用比较便捷的方式 sqlite_exec(); // execute
            sqlite3_exec(db, createTableSql.UTF8String, NULL, NULL, NULL); // c 中是NULL
            
#pragma mark---- sqlite3_exec() 执行函数
            /*sqlite3_exec(
             <#sqlite3 *#>,  数据库指针
             <#const char *sql#>,  要执行的sql 语句
             <#int (*callback)(void *, int, char **, char **)#>, 执行 查询 回调函数
             <#void *#>, 传递给回调函数的 参数
             <#char **errmsg#>) 错误信息
             */
            // 执行exec（）函数 包含了 语句对象sqlit3_stmt， 欲执行 sqlite3_prepare_v2(stmt), 执行 sqlite3_prepare(stmt), 释放 sqlite3_finalize(stmt)。
        }
        
        return  db;
        
    }
}

// 关闭数据库
- (void)close
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭数据库成功");
    }
    db = nil;
}


#pragma mark--- Activity 数据库操作
// 添加 某个活动
+ (BOOL)insertNewActivity:(Activity *)activity
{
    BOOL isSuccess = NO;
    // 1   2 3 4
    // 1.
    sqlite3 *db =  [self open];
    // 2. stmt
    sqlite3_stmt *stmt = nil;
    // 3. sql
    NSString *sqlString = [NSString stringWithFormat:@"insert into ActivityInfo values('%@','%@','%@',?)", activity.ID, activity.title, activity.imageUrl];
    NSLog(@"活动的ID为 %@", activity.ID);
    NSLog(@"%@", sqlString);
    // 4. prepare
    int result = sqlite3_prepare_v2(db, sqlString.UTF8String, -1, &stmt, nil);
    // judge
    if (result == SQLITE_OK) {
        // .bind
        
        // 5. 归档key 标识
        NSString *achiverKey = [NSString stringWithFormat:@"%@%@", kActivityArchiverKey,activity.ID];
        NSLog(@"+++%@",achiverKey);
        // 对对象进行归档 转化为data
        
        NSMutableData * data = [NSMutableData data];
        
        NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        
        [archiver encodeObject:activity forKey:achiverKey];
        [archiver finishEncoding];
        [archiver release];
        
        // 6. bind
        // 赋值的？对象为 blob 二进制 byte类型。
        sqlite3_bind_blob(stmt, 1, [data bytes], (int)[data length], nil);
        
        // 7. step
        sqlite3_step(stmt);
        isSuccess = YES;
    }
    // 8.
    sqlite3_finalize(stmt);
    
    return isSuccess;
}

// 删除 某个活动
//+ (BOOL)deleteActivityWithID:(NSInteger)ID;
+ (BOOL)deleteActivity:(Activity *)activity
{
    return YES;
}


// 查询 某个活动
+ (Activity *)selectActivityWithID:(NSString *)ID
{
    
    Activity *activity = nil;
    // 1. db
    sqlite3 *db = [self open];
    // 2. stmt
    sqlite3_stmt *stmt  = nil;
    
    NSString *sqlString = [NSString stringWithFormat:@"select data from ActivityInfo where ID = '%@'", ID];
    // 3. prepare
    int result = sqlite3_prepare_v2(db, sqlString.UTF8String, -1, &stmt, nil);
    
    // 4.
    if (result == SQLITE_OK) {
        // 5.
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            // 6. dataWithBytes:blob   legth:bytes
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            
            // 7. 反归档
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            NSString *key = [NSString stringWithFormat:@"%@%@", kActivityArchiverKey,ID];
            NSLog(@"---%@", key);
            activity =  [unarchiver decodeObjectForKey:key];
            [unarchiver finishDecoding];
            [unarchiver release];
        }
    }
    // 8 .shifang
    sqlite3_finalize(stmt);
    
    if (activity != nil) {
        NSLog(@"从数据库中取数据反归档成功");
        NSLog(@"%@", activity);
        return activity;
    }  else{
        NSLog(@"取数据出错");
        NSLog(@"%@", activity);
        return nil;
    }
}
//
//// 查询 所有活动
//+ (NSArray *)selectAllActivitys
//{
//    
//}

// 判断活动是否被收藏
+ (BOOL)isFavoriteActivityWithID:(NSString *)ID
{
    NSLog(@"%@",ID);
    Activity *activity = [self selectActivityWithID:ID];
    if (activity != nil) {
        return YES;
    }
    return NO;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
