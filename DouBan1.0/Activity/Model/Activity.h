//
//  Activity.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageDownLoader.h"

@interface Activity : NSObject <ImageDownLoaderDelegate>

@property (nonatomic,retain) NSString *title; // 标题
@property (nonatomic,retain) NSString *begin_time; // 小技巧，集体改值。
@property (nonatomic,retain) NSString *end_time;
@property (nonatomic,retain) NSString *address;
@property (nonatomic,retain) NSString *category_name; // 类型
@property (nonatomic,retain) NSString *wisher_count; // 感兴趣人数
@property (nonatomic,retain) NSString *participant_count; // 参加人数
@property (nonatomic,retain) NSString *imageUrl;
@property (nonatomic,retain)  UIImage *activityImage;

@end
