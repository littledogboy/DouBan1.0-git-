//
//  DatabaseHandler.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/14.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//



#import "DatabaseHandler.h"

#define kDatabaseName @"DouBan.sqlite" // 数据库名

static sqlite3 *db = nil;

@implementation DatabaseHandler


// 打开数据库
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
            // interger   text         text            blob
            
            // 创建数据库表sql语句， 若已经创建过则不会再创建  数据库自己会判断。table studentInfo already exists
            NSString *createTableSql = @"CREATE TABLE ActivityInfo (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, imageUrl TEXT,data BLOB); CREATE TABLE MovieInfo(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, imageUrl TEXT, data BLOB)";
            // 敲出来之后 ：  sqliteManager 用数据库软件验证一下
            
            // 执行sql 语句 , 可以使用比较便捷的方式 sqlite_exec(); // execute
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
