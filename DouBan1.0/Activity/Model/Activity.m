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
    [_ID release];
    [_title release];
    [_begin_time release];
    [_end_time release];
    [_address release];
    [_category_name release];
    [_wisher_count release];
    [_participant_count release];
    [_imageUrl release];
    [_activityImage release];
    [_imageFilePath release];
    
    [super dealloc];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    // 调用的是父类传递过来的方法，给本model 的属性赋值。
    
    if ([key isEqualToString:@"image"]) {
        
        // 容易出现的错误：实例变量 活动图片名为： UIImage *image。被kvc 赋上字符串值。
        // 解决方法： 1.  改变 活动图片名。 2.  每次被附上值都都 至空。
        // self.image = nil; // 先至空 string -》nil，后网络请求赋值 -》image
        self.imageUrl = value;
        
#pragma 图片 代理方法 下载
        // 我们来分析一下什么时候下载？ 只有在KVC的时候才下载。什么时候KVC ？ 网络解析后赋值。 什么时候网络解析？ 网络请求完成后。———— 也就是说如果网络请求不成功，就不会执行KVC方法，因此根据沙盒创建图像也就不会跑了。问题1.
        // 我们现在要做的是 关掉手机清除上次内存中数据后，断开网络连接，会 由沙盒路径创建对象。
        // 问题2.
        // **如果把图片下载写在KVC 里面，会把所有图片都下载下来，但是我们的目的是给用户节省流量。因此当一个单元格显示的时候我们才让图片下载。那么控制图片下载的方法，就不能写在model里面。写在cell里面，或者写在 controller，更好。
//        [ImageDownLoader imageDownLoaderWithURLString:value delegate:self tag:10];
        
        // 根据沙盒路径创建图像,如果沙盒中没有就不创建。
        NSString *imageSandboxPath = [self imageSandboxPath:self.imageUrl];
        self.activityImage = [UIImage imageNamed:imageSandboxPath];
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

// 图片沙盒路径
- (NSString *)imageSandboxPath:(NSString *)imageUrl
{
    // 图像url把/ 替换为 _
    NSString * imageName = [imageUrl stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    // 文件夹 沙盒路径
    NSString * imageManagerPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"DownloadImages"];
    // 判断文件夹是否存在， 不存在创建文件夹， 存在返回 图片沙盒路径
    if (NO == [fileManager fileExistsAtPath:imageManagerPath]) {
        
        // 如果没有文件夹，创建文件夹
        [fileManager createDirectoryAtPath:imageManagerPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    // 图片 沙盒路径
    NSString *imagePath = [imageManagerPath stringByAppendingPathComponent:imageName];
    
    // ***给model 赋值
    self.imageFilePath = imagePath;
    
    return imagePath;
}

#pragma mark- 开始下载图像
//开始下载图像
- (void)loadImage
{
    self.isDownloading = YES;
    [ImageDownLoader imageDownLoaderWithURLString:self.imageUrl delegate:self tag:10];
}


#pragma mark- 图片下载代理
- (void)imageDownLoader:(ImageDownLoader *)imageDownLoade disFinshLoadImage:(UIImage *)image
{
    self.isDownloading = NO; // 下载完毕后才触发kvo方法。
    if (imageDownLoade.tag == 10) {
        self.activityImage = image;
        
        // 图片下载下来后保存在沙盒里面
        // 沙盒路径
        NSString *imageSanboxPath = [self imageSandboxPath:self.imageUrl];
        // 写入
        [UIImagePNGRepresentation(image) writeToFile:imageSanboxPath atomically:YES];
    }
}

- (void)imageDownLoader:(ImageDownLoader *)imageDownLoade failWithError:(NSError *)error
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"图片代理下载出错");
}


@end
