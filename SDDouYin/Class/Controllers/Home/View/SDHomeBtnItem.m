//
//  SDHomeBtnItem.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/7.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDHomeBtnItem.h"
@implementation SDHomeMusicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    //
    UIButton *musicImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [musicImageBtn setBackgroundImage:[UIImage imageNamed:@"music_bg"] forState:UIControlStateNormal];
    [musicImageBtn  addTarget:self action:@selector(musicImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: musicImageBtn];
    [musicImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.height.equalTo(@(HomeHeadImageViewWidth));
    }];
    
    
}

- (void)musicImageBtnClick:(UIButton *)sender{
    
}
@end
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
        if(itemType ==HomeBtnItemHead){
            [self setupHeadView];
        }else if (itemType == HomeBtnItemBtns) {
            [self setupBtnsView];
        }
    }
    return self;
}

- (void)setupHeadView{
    //头像
    UIImageView *headImageView = [[UIImageView alloc] init];

    headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headImageView.layer.borderWidth = 1.f;
    headImageView.layer.cornerRadius =HomeHeadImageViewWidth/2;
    headImageView.layer.masksToBounds = YES;
    [self addSubview:headImageView];
    headImageView.userInteractionEnabled = YES;
    self.headImageView = headImageView;
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.width.height.equalTo(@(HomeHeadImageViewWidth));
    }];
    //关注按钮
    UIButton *focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [focusBtn setImage:[UIImage imageNamed:@"iconPersonalAddLittle"] forState:UIControlStateNormal];
//    [focusBtn  addTarget:self action:@selector(focusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)setupBtnsView{
    //
    UIButton *handleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [handleBtn  addTarget:self action:@selector(handleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: handleBtn];
    self.handleBtn = handleBtn;
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
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = SDFont(14);
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
