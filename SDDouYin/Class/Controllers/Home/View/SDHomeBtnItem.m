//
//  SDHomeBtnItem.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/7.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDHomeBtnItem.h"

@implementation SDHomeBtnItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithType:(HomeBtnItemType )itemType
{
    self = [super init];
    if (self) {
//        self.backgroundColor = UIColorFormRandom;
        if(itemType ==HomeBtnItemHead){
            [self setupHeadView];
        }else {
            [self setupOtherView];
        }
    }
    return self;
}

- (void)setupHeadView{
    //头像
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.image = [UIImage imageNamed:@"imgXiaozhushou80"];
    headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImageView.layer.borderWidth = 1.f;
    [self addSubview:headImageView];
    self.headImageView = headImageView;
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.width.height.equalTo(@(HomeHeadImageViewWidth));
    }];
    //关注按钮
    UIButton *focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [focusBtn setImage:[UIImage imageNamed:@"iconPersonalAddLittle"] forState:UIControlStateNormal];
    [focusBtn  addTarget:self action:@selector(focusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.focusBtn = focusBtn;
//    focusBtn.backgroundColor = UIColorFormRandom;
    [self addSubview: focusBtn];
    [focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(headImageView.mas_bottom).offset(-15);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
}

- (void)setupOtherView{
    //
    UIButton *handleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [handleBtn  addTarget:self action:@selector(handleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: handleBtn];
    self.handleBtn = handleBtn;
//    self.handleBtn.backgroundColor = UIColorFormRandom;
    [handleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(@(HomeHandleBtnWidth));
        make.height.equalTo(@(HomeHandleBtnWidth));
    }];
    
    //
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.textColor = [UIColor whiteColor];
    numLabel.text = @"100";
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = SDFont(15);
    numLabel.numberOfLines = 0;
    [self addSubview:numLabel];
    self.numLabel = numLabel;
//    self.numLabel.backgroundColor = UIColorFormRandom;
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(handleBtn.mas_centerX);
        make.top.equalTo(handleBtn.mas_bottom);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@(30));
    }];
    
}


#pragma mark - clicks
- (void)focusBtnClick:(UIButton *)sender{
    
}

- (void)handleBtnClick:(UIButton *)sender
{
    
}
@end
