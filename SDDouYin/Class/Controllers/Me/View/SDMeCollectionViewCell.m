//
//  SDMeCollectionViewCell.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDMeCollectionViewCell.h"

@implementation SDNumView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    self.iconImageView = imageView;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.equalTo(@(15));
    }];
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.textColor = UIColorFromRGB0X(0xFFFFFF);
    numLabel.text = @"222";
    numLabel.textAlignment = NSTextAlignmentLeft;
    numLabel.font = SDFont(11);
    numLabel.numberOfLines = 1;
    self.numLabel = numLabel;
    [self addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(2);
        make.centerY.equalTo(imageView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(5);
        make.height.equalTo(self.mas_height);
    }];
    
}

@end
@implementation SDMeCollectionViewCell

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
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [self addSubview:bgImageView];
    self.bgImageView = bgImageView;
    self.bgImageView.backgroundColor = UIColorFormRandom;
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
    }];
    ///点赞数
    SDNumView *likeNumView = [[SDNumView alloc]init];
    likeNumView.iconImageView.image = [UIImage imageNamed:@"shortVideo_likeIcon"];
    [self addSubview:likeNumView];
    self.likeNumView = likeNumView;
    [likeNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).offset(kWidth(10));
        make.bottom.equalTo(bgImageView.mas_bottom).offset(kWidth(-10));
        make.width.equalTo(@(SCREEN_WIDTH/6));
        make.height.equalTo(@(30));
    }];
 
}

//
//- (void)setPersonalDataCellValue:(YomoShortVideoModel *)shortViedo{
//
//    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString appendImageServiceDomain:shortViedo.picOsskeys.firstObject imageType:nil]] placeholderImage:[UIImage imageNamed:@""]];
//    self.likeNumView.numLabel.text =[NSString stringWithFormat:@"%ld",shortViedo.videoPariseNum];
//
//
//}

- (void)setValueWithModel:(SDAweme *)aweme{
  [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:aweme.video.originCover.urlList.firstObject]];
  self.likeNumView.numLabel.text =[NSString stringWithFormat:@"%ld",aweme.statistics.diggCount];
}
@end
