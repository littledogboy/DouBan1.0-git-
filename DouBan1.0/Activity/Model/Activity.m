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

#pragma mark---- 重写init方法，注册为通知者对象， 清除缓存。
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCleanImageCacheNotification:) name:kCleanCachedNotification object:nil];
    }
    return self;
}

// 清除 model 的图片属性值。
- (void)handleCleanImageCacheNotification:(NSNotification *)notification
{
    //清除缓存时，将image 由沙盒路径  置为空。
    self.activityImage = nil;
}



#pragma mark---- NSCoding协议
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.begin_time forKey:@"begin_time"];
    [aCoder encodeObject:self.end_time forKey:@"end_time"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.category_name forKey:@"category_name"];
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.ownerName forKey:@"owerName"];
    [aCoder encodeObject:self.wisher_count forKey:@"wisher_count"];
    [aCoder encodeObject:self.participant_count forKey:@"participant_count"];
    [aCoder encodeObject:self.imageFilePath forKey:@"imageFilePath"];
    [aCoder encodeBool:self.isDownloading forKey:@"isDownloading"];
    [aCoder encodeBool:self.isFavorite forKey:@"isFavorite"];
    
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.begin_time = [aDecoder decodeObjectForKey:@"begin_time"];
        self.end_time = [aDecoder decodeObjectForKey:@"end_time"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.category_name = [aDecoder decodeObjectForKey:@"category_name"];
        self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
        
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.ownerName = [aDecoder decodeObjectForKey:@"ownerName"];
        self.wisher_count = [aDecoder decodeObjectForKey:@"wisher_count"];
        self.participant_count = [aDecoder decodeObjectForKey:@"participant_count"];
        self.imageFilePath = [aDecoder decodeObjectForKey:@"imageFilePath"];
        self.isDownloading = [aDecoder decodeBoolForKey:@"isDownloading"];
        self.isFavorite = [aDecoder decodeBoolForKey:@"isFavorite"];
    }
    
    return self;
}




#pragma mark- KVC 赋值
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
    // ID  : id
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

// 图片沙盒路径
- (NSString *)imageSandboxPath:(NSString *)imageUrl
{
    // 图像url把/ 替换为 _ stringByreplacing
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

// 图片在沙盒中的路径
- (NSString *)imageSandBoxPath:(NSString *)imageUrl
{
    
    // cache路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    // 文件夹路径
    NSString *imageDirPath = [cachePath stringByAppendingPathComponent:@"DownImage"];
    
    //
    NSFileManager *fileManger = [NSFileManager defaultManager];
    
    // 如果图片缓存文件夹不存在创建之后再存贮。
    if ([fileManger fileExistsAtPath:imageDirPath] == NO) {
        [fileManger createDirectoryAtPath:imageDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 图片沙盒路径 根据url  命名
    // 注意: 如果路径名里面有/ 替换掉
    NSString *url = [imageUrl stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *imageSandBoxPath = [imageDirPath stringByAppendingPathComponent:url];
    
    return imageSandBoxPath;
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
        
        // 沙盒路径
//        NSString *imageSanBoxPath = [self imageSandBoxPath:self.imageUrl];
        
        // 写入 data -> sandBox
        [UIImagePNGRepresentation(image) writeToFile:imageSanboxPath atomically:YES];
    }
}

- (void)imageDownLoader:(ImageDownLoader *)imageDownLoade failWithError:(NSError *)error
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"图片代理下载出错");
}


@end
