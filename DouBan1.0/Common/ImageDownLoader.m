//
//  ImageDownLoader.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/10.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//  此为异步加载 图片链接url数据 类。

#import "ImageDownLoader.h"

@implementation ImageDownLoader

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.recevieData = [NSMutableData data];
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"图片下载接收到网络回应");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.recevieData appendData:data];
//    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}


#pragma mark------- 得到dataImage给delegate ------
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [UIImage imageWithData:self.recevieData]; // 注意这里是遍历走构造器，外界不用释放。
    if ([_delegate respondsToSelector:@selector(imageDownLoader:disFinshLoadImage:)]) {
        [_delegate imageDownLoader:self disFinshLoadImage:image];
    }
}



// 遍历构造器
+ (ImageDownLoader *)imageDownLoaderWithURLString:(NSString *)urlString delegate:(id<ImageDownLoaderDelegate>)delegate tag:(NSUInteger)tag
{
    return [[[ImageDownLoader alloc] initWithURLString:urlString delegate:delegate tag:tag] autorelease];
}

// 初始化fangfa
- (instancetype)initWithURLString:(NSString *)urlString delegate:(id<ImageDownLoaderDelegate>)delegate tag:(NSUInteger)tag
{
    self = [super init];
    if (self) {
        self.urlString = urlString;
        self.delegate = delegate;
        self.tag = tag;
        
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        // 1. 内部连接方式 代理
        // 2. block
        // 1. 代理 代理代理能够实现 滑动停止才更新数据。
//        [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
        [self startDownload];
        
        // 2. block 而用block 则可以边滑动边更新数据。
        
        
    }
    return self;
}

- (void)startDownload
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        UIImage *image = [UIImage imageWithData:data];
        
        if ([_delegate respondsToSelector:@selector(imageDownLoader:disFinshLoadImage:)]) {
            [_delegate imageDownLoader:self disFinshLoadImage:image];
        }
        
    }];
}


@end
