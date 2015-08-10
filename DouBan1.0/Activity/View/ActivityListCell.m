//
//  ActivityListCell.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/8.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "ActivityListCell.h"
#import "ActivityInfoView.h"
#import "ActivityCountView.h"
#import "Activity.h"
#import "UILabel+Additions.h"

#define kLeftPadding 10
#define kTopPadding 10
#define kVerticalSpacing 10
#define kHorizonSpacing 10

@implementation ActivityListCell

// 单元格高度
+ (CGFloat)cellHeight;
{
    return 250;
}

// 自定义单元格
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // blue 304 * 140
        // white 304 * 146 + 70 = 216
        // plage  88 * 130
        CGFloat totalWidth = [[UIScreen mainScreen] bounds].size.width;
        
        
        // blueImage
        CGFloat blueWidth = totalWidth - 2 * kLeftPadding;
        CGFloat blueHeight = 216;
        _blueImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(kLeftPadding, kTopPadding, blueWidth, blueHeight))];
        UIImage *blueImage = [UIImage imageNamed:@"bg_eventlistcell"];
        blueImage = [blueImage resizableImageWithCapInsets:(UIEdgeInsetsMake(10, 10, 10, 10)) resizingMode:(UIImageResizingModeStretch)];
        _blueImageView.image =  blueImage;
        [self.contentView addSubview:_blueImageView];
        
        // title
        CGFloat titleX = 1.5 * kLeftPadding;
        CGFloat titltY = 1.5 * kTopPadding;
        CGFloat titltWidth = totalWidth - 3 * kLeftPadding;
        CGFloat titleHeight = 30;
        _titleLabel = [[UILabel alloc] initWithFrame:(CGRectMake(titleX, titltY, titltWidth, titleHeight)) text:nil alignment:(NSTextAlignmentLeft) textColor:nil textFont:nil];
        [self.contentView addSubview:_titleLabel];
        
        
        // white image
        CGFloat whiteX = 1.1 * kLeftPadding;
        CGFloat whiteY = titltY + titleHeight + 0.5 * kTopPadding;
        CGFloat whiteWidth = totalWidth - 2.2 * kLeftPadding;
        CGFloat whiteHeight = 0.5 * whiteWidth;
        _whiteImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(whiteX, whiteY, whiteWidth, whiteHeight))];
        _whiteImageView.image = [UIImage imageNamed:@"bg_share_large"];
        [self.contentView addSubview:_whiteImageView];
        
        // imageView
        CGFloat imageWidth = 88;
        CGFloat imageHeight = 130;
        CGFloat imageX = totalWidth - imageWidth - 1.5 *kLeftPadding;
        CGFloat imageY = whiteY + 0.5 * kVerticalSpacing;
        
        _activityImage = [[UIImageView alloc] initWithFrame:(CGRectMake(imageX, imageY, imageWidth, imageHeight))];
        _activityImage.image = [UIImage imageNamed:@"picholder"];
        [self.contentView addSubview:_activityImage];
        
        // timeLabel
        CGFloat timeX = 2 * kLeftPadding;
        CGFloat timeY = whiteY + kVerticalSpacing;
        CGFloat timeWidth = whiteWidth - kHorizonSpacing - imageWidth - kLeftPadding;
        CGFloat timeHeight = 20;
        _timeInfoView = [[ActivityInfoView alloc] initWithFrame:(CGRectMake(timeX, timeY, timeWidth, timeHeight)) sizeOfIcon:(CGSizeMake(18, 18)) icon:[UIImage imageNamed:@"icon_date"] infoString:nil];
        [self.contentView addSubview:_timeInfoView];
        
        // address
        CGFloat addressX = timeX;
        CGFloat addressY = timeY + timeHeight + kVerticalSpacing;
        CGFloat addressWidth = timeWidth;
        CGFloat addressHeight = timeHeight;
        _addressInfoView = [[ActivityInfoView alloc] initWithFrame:(CGRectMake(addressX, addressY, addressWidth, addressHeight)) sizeOfIcon:(CGSizeMake(18, 18)) icon:[UIImage imageNamed:@"icon_spot"] infoString:nil];
        [self.contentView addSubview:_addressInfoView];
        
        // categary
        CGFloat categoryX = addressX;
        CGFloat categoryY = addressY + addressHeight + kVerticalSpacing;
        CGFloat categoryWidth = addressWidth;
        CGFloat categoryHeight = addressHeight;
        _categoryInfoView = [[ActivityInfoView alloc] initWithFrame:(CGRectMake(categoryX, categoryY, categoryWidth, categoryHeight)) sizeOfIcon:(CGSizeMake(18, 18)) icon:[UIImage imageNamed:@"icon_catalog"] infoString:nil];
        [self.contentView addSubview:_categoryInfoView];
        
        // interest
        CGFloat interestX = categoryX;
        CGFloat interestY = categoryY + categoryHeight + 2 * kVerticalSpacing;
        CGFloat interestWidth = 120;
        CGFloat interestHeight = 20;
        _interestView = [[ActivityCountView alloc] initWithFrame:(CGRectMake(interestX, interestY, interestWidth, interestHeight)) type:@"感兴趣:" count:0];
        [self.contentView addSubview:_interestView];
        
        // join
        CGFloat joinX = interestX + interestWidth + 2 * kHorizonSpacing;
        CGFloat joinY = interestY;
        CGFloat joinWidth = interestWidth;
        CGFloat joinHeight = interestHeight;
        _joinView = [[ActivityCountView alloc] initWithFrame:(CGRectMake(joinX, joinY, joinWidth, joinHeight)) type:@"参加:" count:0];
        [self.contentView addSubview:_joinView];
    }
    return self;
}


#pragma mark- 数据模型赋值方法
- (void)setActivity:(Activity *)activity
{
    if (_activity != activity) {
        [_activity release];
        _activity = [activity retain];
        
        //
        _titleLabel.text = activity.title;
        
        // 时间
        NSString *string1 = [activity.begin_time substringWithRange:(NSMakeRange(5, 11))];
        NSString *string2 = [activity.end_time substringWithRange:(NSMakeRange(5, 11))];
        _timeInfoView.text = [NSString stringWithFormat:@"%@--%@", string1, string2];
        
        // 地址
        _addressInfoView.text = activity.address;
        
        // 类型
        _categoryInfoView.text = [NSString stringWithFormat:@"类型: %@",activity.category_name];
        
        // 感兴趣
        _interestView.count = activity.wisher_count;
        // 参加
        _joinView.count = activity.participant_count;
        
        
        if (activity.activityImage  == nil) {
            _activityImage.image = [UIImage imageNamed:@"picholder"];
        } else {
            _activityImage.image = activity.activityImage;
        }
        
        // 加载图片。用的block
//        NSURL *url = [NSURL URLWithString:activity.imageUrl];
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:0 timeoutInterval:10];
        
        // 加载图片。 用的delegate
        /*
        if (activity.image  == nil) {
            _activityImage.image = [UIImage imageNamed:@"picholder"];
        } else {
            
            [ImageDownLoader imageDownLoaderWithURLString:activity.imageUrl delegate:self tag:10];
        }
         */
        
        // 加载图片。用的block
        /*
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            _activityImage.image = [[UIImage alloc] initWithData:data];
        }];
         */
    }
}

#pragma mark- 代理方法。
/*
- (void)imageDownLoader:(ImageDownLoader *)imageDownLoade disFinshLoadImage:(UIImage *)image
{
    if (imageDownLoade.tag == 10) {
        
        _activityImage.image = image;
    }

}

- (void)imageDownLoader:(ImageDownLoader *)imageDownLoade failWithError:(NSError *)error
{
    NSLog(@"%@", error);
}
*/

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
