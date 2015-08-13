//
//  ActivityDetailView.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/13.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "ActivityDetailView.h"

#define TopHeight  236


// 要想视图能够滚动，必须把内容放在一个scrollView里面，因此声名一个 scrollView 实例变量.
@interface ActivityDetailView ()

@property (nonatomic, retain) UIScrollView *bottomScrollView;
@end

@implementation ActivityDetailView
- (void)dealloc
{
    [_bottomScrollView release];
    [_activityImageView release];
    [_timeLabel release];
    [_titleLabel release];
    [_addressLabel release];
    [_ownerLabel release];
    [_categoryLabel release];
    [_contextLabel release];
    [super dealloc];
}

- (void)p_setupSubviews
{
    //scrollView
    _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.bounds.size.height-49)];
    //    _bottomScrollView.backgroundColor = [UIColor cyanColor];
    [self addSubview:_bottomScrollView];
    
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 40)];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_bottomScrollView addSubview:_titleLabel];
    
    //图片
    _activityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 60, 88, 130)];
    _activityImageView.image = [UIImage imageNamed:@"picholder"];
    [_bottomScrollView addSubview:_activityImageView];
    
    
    //时间
    UIImageView * timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(116, 60, 16, 16)];
    timeImageView.image = [UIImage imageNamed:@"icon_date_blue"];
    [_bottomScrollView addSubview:timeImageView];
    [timeImageView release];
    
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(134, 60, 166, 16)];
    _timeLabel.font = [UIFont systemFontOfSize:12.0];
    [_bottomScrollView addSubview:_timeLabel];
    
    
    //主办方
    UIImageView * ownerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(116, 82, 16, 16)];
    ownerImageView.image = [UIImage imageNamed:@"icon_sponsor_blue"];
    [_bottomScrollView addSubview:ownerImageView];
    [ownerImageView release];
    
    _ownerLabel = [[UILabel alloc] initWithFrame:CGRectMake(134, 82, 166, 16)];
    _ownerLabel.font = [UIFont systemFontOfSize:12.0];
    [_bottomScrollView addSubview:_ownerLabel];
    
    //类型
    UIImageView * categoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(116, 104, 16, 16)];
    categoryImageView.image = [UIImage imageNamed:@"icon_catalog_blue"];
    [_bottomScrollView addSubview:categoryImageView];
    [categoryImageView release];
    
    _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(134, 104, 166, 16)];
    _categoryLabel.font = [UIFont systemFontOfSize:12.0];
    [_bottomScrollView addSubview:_categoryLabel];
    
    //地址
    UIImageView * addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(116, 126, 16, 16)];
    addressImageView.image = [UIImage imageNamed:@"icon_spot_blue"];
    [_bottomScrollView addSubview:addressImageView];
    [addressImageView release];
    
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(134, 126, 166, 65)];
    _addressLabel.font = [UIFont systemFontOfSize:12.0];
    _addressLabel.numberOfLines = 0;
    [_bottomScrollView addSubview:_addressLabel];
    
    
    //活动介绍
    UILabel * introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 206, 280, 20)];
    introduceLabel.text = @"活动介绍";
    introduceLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [_bottomScrollView addSubview:introduceLabel];
    [introduceLabel release];
    
    //活动内容
    _contextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 236, 280, 0)];
    _contextLabel.font = [UIFont systemFontOfSize:12.0];
    _contextLabel.numberOfLines = 0;
    [_bottomScrollView addSubview:_contextLabel];
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupSubviews];
        
    }
    return self;
}

- (void)adjustSubviewsWithContent:(NSString *)content
{
    //计算活动内容的高度
    CGRect contentRect = [content boundingRectWithSize:CGSizeMake(280, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    
    CGFloat height = TopHeight+contentRect.size.height+30;
    
    if (height < self.bounds.size.height) {
        
        height = self.bounds.size.height + 30;
    }
    
    // 设置 滚动视图的 内容大小。
    _bottomScrollView.contentSize = CGSizeMake(320, height);
    
    
    // 重新 调整文本标签大小
    CGRect contentViewRect = _contextLabel.frame;
    contentViewRect.size.height = contentRect.size.height;
    _contextLabel.frame = contentViewRect;
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
