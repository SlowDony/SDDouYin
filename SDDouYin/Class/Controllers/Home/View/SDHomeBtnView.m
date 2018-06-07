//
//  SDHomeBtnView.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/8.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDHomeBtnView.h"
#import "SDHomeBtnItem.h"
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
    
    SDHomeBtnItem *shareItem = [[SDHomeBtnItem alloc]initWithType:HomeBtnItemOther];
    [shareItem.handleBtn setImage:[UIImage imageNamed:@"img_share"] forState:UIControlStateNormal];
    shareItem.numLabel.text = @"100";
    [self addSubview:shareItem];
    [shareItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-100);
        make.width.equalTo(@(HomeBtnItemWidth));
        make.height.equalTo(@(HomeBtnItemHeight));
    }];
    
    SDHomeBtnItem *commentItem = [[SDHomeBtnItem alloc]initWithType:HomeBtnItemOther];
    [commentItem.handleBtn setImage:[UIImage imageNamed:@"img_comment"] forState:UIControlStateNormal];
    commentItem.numLabel.text = @"100";
    [self addSubview:commentItem];
    [commentItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(shareItem.mas_top).offset(-10);
        make.width.equalTo(@(HomeBtnItemWidth));
        make.height.equalTo(@(HomeBtnItemHeight));
    }];
    
    
    SDHomeBtnItem *likeItem = [[SDHomeBtnItem alloc]initWithType:HomeBtnItemOther];
    [likeItem.handleBtn setImage:[UIImage imageNamed:@"img_dislike"] forState:UIControlStateNormal];
    likeItem.numLabel.text = @"100";
    [self addSubview:likeItem];
    [likeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(commentItem.mas_top).offset(-10);
        make.width.equalTo(@(HomeBtnItemWidth));
        make.height.equalTo(@(HomeBtnItemHeight));
    }];
    
    SDHomeBtnItem *headItem = [[SDHomeBtnItem alloc]initWithType:HomeBtnItemHead];
    [headItem.focusBtn setImage:[UIImage imageNamed:@"iconPersonalAddLittle"] forState:UIControlStateNormal];
    [self addSubview:headItem];
    [headItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(likeItem.mas_top).offset(-5);
        make.width.equalTo(@(HomeBtnItemWidth));
        make.height.equalTo(@(HomeBtnItemWidth));
    }];
    
   
}
@end
