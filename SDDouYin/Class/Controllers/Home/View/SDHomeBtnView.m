//
//  SDHomeBtnView.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/8.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDHomeBtnView.h"
#import "SDShortVideoModel.h"
@implementation SDHomeBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    ///音乐背景
    SDHomeMusicView *musicView = [[SDHomeMusicView alloc]init];
    [self addSubview:musicView];
    [musicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-50);
        make.width.equalTo(@(100));
        make.height.equalTo(@(90));
    }];
    
    ///分享
    SDHomeBtnItem *shareItem = [[SDHomeBtnItem alloc]initWithType:HomeBtnItemBtns];
    [shareItem.handleBtn setImage:[UIImage imageNamed:@"img_share"] forState:UIControlStateNormal];
    [self addSubview:shareItem];
    self.shareItem = shareItem;
    [shareItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(musicView.mas_top);
        make.width.equalTo(@(HomeBtnItemWidth));
        make.height.equalTo(@(HomeBtnItemHeight));
    }];
    
    ///评论
    SDHomeBtnItem *commentItem = [[SDHomeBtnItem alloc]initWithType:HomeBtnItemBtns];
    [commentItem.handleBtn setImage:[UIImage imageNamed:@"img_comment"] forState:UIControlStateNormal];
    [self addSubview:commentItem];
    
    self.commentItem = commentItem;
    [commentItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(shareItem.mas_top);
        make.width.equalTo(@(HomeBtnItemWidth));
        make.height.equalTo(@(HomeBtnItemHeight));
    }];
    
    
    ///点赞
    SDHomeBtnItem *likeItem = [[SDHomeBtnItem alloc]initWithType:HomeBtnItemBtns];
    [likeItem.handleBtn setImage:[UIImage imageNamed:@"img_dislike"] forState:UIControlStateNormal];
    [self addSubview:likeItem];
    self.likeItem = likeItem;
    [likeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(commentItem.mas_top);
        make.width.equalTo(@(HomeBtnItemWidth));
        make.height.equalTo(@(HomeBtnItemHeight));
    }];
    
    ///头部
    SDHomeBtnItem *headItem = [[SDHomeBtnItem alloc]initWithType:HomeBtnItemHead];
    headItem.headImageView.image = [UIImage imageNamed:@"imgXiaozhushou80"];
    [headItem.focusBtn setImage:[UIImage imageNamed:@"iconPersonalAddLittle"] forState:UIControlStateNormal];
    self.headItem = headItem;
    [self addSubview:headItem];
    [headItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(likeItem.mas_top);
        make.width.equalTo(@(HomeBtnItemWidth));
        make.height.equalTo(@(HomeBtnItemWidth));
    }];
    
    ///playImageView
    UIImageView *playImageView = [[UIImageView alloc] init];
    playImageView.image = [UIImage imageNamed:@"icPlayMiddle"];
    playImageView.alpha = 0.3;
    playImageView.hidden = YES;
    [self addSubview:playImageView];
    self.playImageView = playImageView;
    [playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@(80));
        make.height.equalTo(@(80));
    }];
    
}


- (void)setValueWithAwemeModel:(SDAweme *)aweme
{
    self.shareItem.numLabel.text = [NSString stringWithFormat:@"%ld",aweme.statistics.shareCount];
    self.likeItem.numLabel.text = [NSString stringWithFormat:@"%ld",aweme.statistics.diggCount];
    self.commentItem.numLabel.text = [NSString stringWithFormat:@"%ld",aweme.statistics.commentCount];
    [self.headItem.headImageView sd_setImageWithURL:[NSURL URLWithString:[aweme.author.avatarThumb.urlList firstObject]]];
    
}

- (void)setValueWithModel:(SDShortVideoModel *)shortVideoModel
{
    self.shareItem.numLabel.text = [NSString stringWithFormat:@"%ld",shortVideoModel.shareNum];
    self.likeItem.numLabel.text = [NSString stringWithFormat:@"%ld",shortVideoModel.likeNum];
    self.commentItem.numLabel.text = [NSString stringWithFormat:@"%ld",shortVideoModel.commentNum];
}
@end
