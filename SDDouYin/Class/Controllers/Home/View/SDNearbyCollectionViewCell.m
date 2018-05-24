//
//  SDNearbyCollectionViewCell.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/16.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDNearbyCollectionViewCell.h"

@implementation SDNearbyCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.contentView.userInteractionEnabled = YES;
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    //背景图
    UIImageView *bgImageView = [[UIImageView alloc]init];
    //    bgImageView.image = [UIImage imageNamed:@"<#string#>"];
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    [bgImageView setBackgroundColor:[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]];
    [self addSubview:bgImageView];
    self.bgImageView = bgImageView;
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
    }];
    
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:@"https://p3.pstatp.com/large/3a2f000a606f678eefe1.jpeg"]];
    
    //头像
    UIImageView *headImageView = [[UIImageView alloc] init];
    [self addSubview:headImageView];
    self.headImageView = headImageView;
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).offset(kWidth(10));
        make.bottom.equalTo(bgImageView.mas_bottom).offset(kWidth(-10));
        make.width.equalTo(@(kWidth(20)));
        make.height.equalTo(@(kWidth(20)));
    }];
    
    
//    @xWeakify
    [headImageView sd_setImageWithURL:[NSURL URLWithString:@"https://p3.pstatp.com/aweme/100x100/3b5c0006d56892d3f78c.jpeg"] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        @xStrongify
        dispatch_async(dispatch_get_main_queue(), ^{
            headImageView.image = [UIImage sd_imageWithRoundCorner:image cornerRadius:kWidth(20)/2 size:CGSizeMake(kWidth(20), kWidth(20))];
        });
    }];
    
    
    
    //姓名
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = @"姓名";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = SDBoldFont(11);
    nameLabel.numberOfLines = 0;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView.mas_right).offset(10);
        make.centerY.equalTo(headImageView.mas_centerY);
        make.right.equalTo(bgImageView.mas_right).offset(-10);
        make.height.equalTo(headImageView.mas_height);
    }];
    
    //距离
    UILabel *distanceLabel = [[UILabel alloc] init];
    distanceLabel.backgroundColor = [UIColor clearColor];
    distanceLabel.textColor = [UIColor whiteColor];
    distanceLabel.text = @"11分钟前";
    distanceLabel.textAlignment = NSTextAlignmentLeft;
    distanceLabel.font = SDFont(11);
    distanceLabel.numberOfLines = 0;
    [self addSubview:distanceLabel];
    self.distanceLabel = distanceLabel;
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView.mas_left);
        make.bottom.equalTo(headImageView.mas_top).offset(-10);
        make.right.equalTo(bgImageView.mas_right).offset(-10);
        make.height.equalTo(@(30));
    }];
    
}
@end
