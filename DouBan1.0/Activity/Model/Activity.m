//
//  Activity.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "Activity.h"

@implementation Activity
- (void)dealloc
{
    [_title release];
    [_begin_time release];
    [_end_time release];
    [_address release];
    [_category_name release];
    [_wisher_count release];
    [_participant_count release];
    [_imageUrl release];
    [_activityImage release];
    [super dealloc];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    // 调用的是父类传递过来的方法，给本model 的属性赋值。
    if ([key isEqualToString:@"image"]) {
        
//        NSLog(@"%@", self.image);
         //  self.image = nil; // 先至空 string -》nil，后网络请求赋值 -》image
        self.imageUrl = value;
        // model的 image（UIimage 赋值）
#pragma 图片下载实例化
        [ImageDownLoader imageDownLoaderWithURLString:value delegate:self tag:10];
    }
    
    if ([key isEqualToString:@"wisher_count"]) {
        self.wisher_count = [value stringValue];
    }
    
    if ([key isEqualToString:@"participant_count"]) {
        self.participant_count = [value stringValue];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //
}

#pragma mark- 图片下载代理
- (void)imageDownLoader:(ImageDownLoader *)imageDownLoade disFinshLoadImage:(UIImage *)image
{
    if (imageDownLoade.tag == 10) {
        self.activityImage = image;
    }
}

- (void)imageDownLoader:(ImageDownLoader *)imageDownLoade failWithError:(NSError *)error
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"图片代理下载出错");
}


@end
