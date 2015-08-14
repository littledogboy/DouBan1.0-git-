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

@interface Activity : NSObject <ImageDownLoaderDelegate, NSCoding>

@property (nonatomic,retain) NSString *ID;

@property (nonatomic,retain) NSString *title; // 标题
@property (nonatomic,retain) NSString *begin_time; // 小技巧，集体改值。
@property (nonatomic,retain) NSString *end_time;
@property (nonatomic,retain) NSString *address;
@property (nonatomic,retain) NSString *category_name; // 类型
@property (nonatomic,retain) NSString *wisher_count; // 感兴趣人数
@property (nonatomic,retain) NSString *participant_count; // 参加人数
@property (nonatomic,retain) NSString *imageUrl; // 图片链接
@property (nonatomic,retain)  UIImage *activityImage; // 图片对象

@property (nonatomic,retain) NSString * content; // 活动内容
@property (nonatomic,retain) NSString * ownerName; // 主办方

@property (nonatomic,retain) NSString * imageFilePath;//图像在沙盒中的路径
@property (nonatomic,assign) BOOL       isDownloading;//图像下载状态

@property (nonatomic,assign) BOOL       isFavorite;//是否收藏

//开始下载图像
- (void)loadImage;
@end
