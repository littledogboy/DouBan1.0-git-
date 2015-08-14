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

@interface DatabaseHandler : UIView

// 打开数据库
+ (sqlite3 *)open;

// 关闭数据库
- (void)close;

@end
