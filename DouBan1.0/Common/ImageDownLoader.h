//
//  ImageDownLoader.h
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/10.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//  此为异步加载 图片链接url数据 类。

// 采用了 代理回调 以及 block 回调的方式 把 通过 实例变量url ，获取到的 data 传递出去。


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ImageDownLoader;
// 指定协议
@protocol ImageDownLoaderDelegate <NSObject>
// 再次强调命名规则   。  协议里的方法 命名规则： 返回值类型  本身类名：（本身类型参数） 什么时候执行描述：（需要回调回去的参数）

// 数据接受完成之后执行，把 image 传递给 delegate。
- (void)imageDownLoader:(ImageDownLoader *)imageDownLoade disFinshLoadImage:(UIImage *)image;
// 数据请求失败后， 把error 传递给 delegate
- (void)imageDownLoader:(ImageDownLoader *)imageDownLoade failWithError:(NSError *)error;



@end



// 让下载类遵守 url连接协议。其实我们是把 网络请求封装到了内部。
@interface ImageDownLoader : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic,retain) NSString *urlString; // url地址
@property (nonatomic,retain) NSMutableData *recevieData;

@property (nonatomic,assign) id<ImageDownLoaderDelegate> delegate; // delegate 代理。
@property (nonatomic,assign) NSUInteger tag; // tag值。 标识。

// 遍历构造器
+ (ImageDownLoader *)imageDownLoaderWithURLString:(NSString *)urlString delegate:(id<ImageDownLoaderDelegate>)delegate tag:(NSUInteger)tag;

// 初始化fangfa
- (instancetype)initWithURLString:(NSString *)urlString delegate:(id<ImageDownLoaderDelegate>)delegate tag:(NSUInteger)tag;

@end
