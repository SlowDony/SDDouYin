//
//  SDMeHeadTopView.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDMeHeadTopView.h"


@interface SDMeHeadTopView ()

@end
@implementation SDMeHeadTopView

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
    //...
    UIButton *pointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pointBtn setTitle:@"..." forState:UIControlStateNormal];
    //    [pointBtn setImage:[UIImage imageNamed:@"<#string#>"] forState:UIControlStateNormal];
    [pointBtn setBackgroundImage:[UIImage sd_imageWithColor:UIColorFromRGBAlpha(0xFFFFFF, 0.3)] forState:UIControlStateNormal];
    pointBtn.layer.cornerRadius = 4;
    pointBtn.layer.masksToBounds = YES;
    pointBtn.titleLabel.font = SDFont(14);
    [pointBtn setTitleColor:UIColorFromRGB0X(0xFFFFFF) forState:UIControlStateNormal];
    pointBtn.tag = 1000;
    [pointBtn addTarget:self action:@selector(pointBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: pointBtn];
    self.pointBtn = pointBtn;
    [pointBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(kWidth(-15));
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(38));
        make.height.equalTo(@(34));
    }];
    
    ///add
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn setBackgroundImage:[UIImage sd_imageWithColor:UIColorFromRGBAlpha(0xFFFFFF, 0.3)] forState:UIControlStateNormal];
    addBtn.titleLabel.font = SDFont(14);
    [addBtn setTitleColor:UIColorFromRGB0X(0xFFFFFF) forState:UIControlStateNormal];
    addBtn.layer.cornerRadius = 4;
    addBtn.layer.masksToBounds = YES;
    addBtn.tag = 2000;
    [addBtn  addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: addBtn];
    self.addBtn = addBtn;
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pointBtn.mas_left).offset(kWidth(-15));
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(38));
        make.height.equalTo(@(34));
    }];
    
    ///add
    UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [followBtn setTitle:@"已关注" forState:UIControlStateNormal];
    [followBtn setBackgroundImage:[UIImage sd_imageWithColor:UIColorFromRGBAlpha(0xFFFFFF, 0.3)] forState:UIControlStateNormal];
    [followBtn setBackgroundImage:[UIImage sd_imageWithColor:UIColorFromRGB0X(0x2B2841)] forState:UIControlStateSelected];
    followBtn.titleLabel.font = SDFont(14);
    [followBtn setTitleColor:UIColorFromRGB0X(0xFFFFFF) forState:UIControlStateNormal];
    followBtn.layer.cornerRadius = 4;
    followBtn.layer.masksToBounds = YES;
    [followBtn  addTarget:self action:@selector(followBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    followBtn.tag = 3000;
    [self addSubview: followBtn];
    self.followBtn = followBtn;
    [followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addBtn.mas_left).offset(kWidth(-15));
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(80));
        make.height.equalTo(@(34));
    }];
}

- (void)setTopViewType:(TopViewType )topViewType{
    _topViewType = topViewType;
    if (topViewType==TopViewTypeMe){
        [self.followBtn setTitle:@"+邀请好友" forState:UIControlStateNormal];
        [self.addBtn setTitle:@"钱包" forState:UIControlStateNormal];
        [self.followBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(92));
        }];
    }else if (topViewType==TopViewTypeOther)
    {
        [self.followBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
        [self.followBtn setTitle:@"已关注" forState:UIControlStateSelected];
        [self.followBtn setAdjustsImageWhenHighlighted:NO];
        [self.followBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(80));
        }];
        [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    }
}



///点按钮点击
- (void)pointBtnClick:(UIButton *)sender{
    
    if (self.topViewBtnClickBlock) {
        self.topViewBtnClickBlock(sender);
    }
}

///添加好友
- (void)addBtnClick:(UIButton *)sender{
    if (self.topViewBtnClickBlock) {
        self.topViewBtnClickBlock(sender);
    }
}

///关注按钮 //邀请好友按钮
- (void)followBtnClick:(UIButton *)sender{
    if (self.topViewType == TopViewTypeMe){
        
    }else if (self.topViewType == TopViewTypeOther){
        sender.selected = !sender.selected;
    }
    
    if (self.topViewBtnClickBlock) {
        self.topViewBtnClickBlock(sender);
    }
}
@end
