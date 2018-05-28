//
//  SDMeHeadTitleView.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDMeHeadTitleView.h"

@interface SDMeHeadTitleView()
@property (nonatomic,strong)  UIView *bgView;
@end
@implementation SDMeHeadTitleView

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
    
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    self.bgView = bgView;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
    }];
    
    //
    UIButton *productionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [productionBtn setTitle:@"作品" forState:UIControlStateNormal];
    [productionBtn setTitleColor:UIColorFromRGBAlpha(0xFFFFFF, 0.8) forState:UIControlStateNormal];
    [productionBtn setTitleColor:UIColorFromRGB0X(0xFFFFFF) forState:UIControlStateSelected];
    [productionBtn setBackgroundImage:[UIImage sd_imageWithColor:UIColorFromRGB0X(0x2B2841)] forState:UIControlStateNormal];
    productionBtn.selected = YES;
    productionBtn.adjustsImageWhenHighlighted = NO;
    [productionBtn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    productionBtn.tag = 10;
    productionBtn.titleLabel.font = SDBoldFont(14);
    [bgView addSubview: productionBtn];
    
    self.productionBtn = productionBtn;
    [productionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left);
        make.top.equalTo(bgView.mas_top);
        make.width.equalTo(@(SCREEN_WIDTH/2));
        make.height.equalTo(bgView.mas_height);
    }];
    
    
    
    //
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeBtn setTitle:@"喜欢" forState:UIControlStateNormal];
    [likeBtn setTitleColor:UIColorFromRGB0X(0xFFFFFF) forState:UIControlStateNormal];
    [likeBtn setBackgroundImage:[UIImage sd_imageWithColor:UIColorFromRGB0X(0x2B2841)] forState:UIControlStateNormal];
    [likeBtn setTitleColor:UIColorFromRGBAlpha(0xFFFFFF, 0.8) forState:UIControlStateNormal];
    [likeBtn setTitleColor:UIColorFromRGB0X(0xFFFFFF) forState:UIControlStateSelected];
    likeBtn.titleLabel.font = SDFont(14);
    likeBtn.tag = 11;
    likeBtn.adjustsImageWhenHighlighted = NO;
    [likeBtn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview: likeBtn];
    self.likeBtn = likeBtn;
    [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right);
        make.top.equalTo(bgView.mas_top);
        make.width.equalTo(@(SCREEN_WIDTH/2));
        make.height.equalTo(bgView.mas_height);
    }];
    
    //分割线
    UIView *spLine = [[UIView alloc] init];
    spLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:spLine];
    [spLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(productionBtn.mas_right);
        make.top.equalTo(productionBtn.mas_top).offset(10);
        make.width.equalTo(@(0.5));
        make.bottom.equalTo(productionBtn.mas_bottom).offset(-10);
    }];
    
}

- (void)btnClick:(UIButton *)sender{
    
    for (int i=0 ; i< self.bgView.subviews.count; i++) {
        UIButton * btn = self.bgView.subviews[i];
        if (btn.tag ==sender.tag) {
            btn.selected = YES;
            btn.titleLabel.font = SDBoldFont(14);
        }else{
            btn.selected = NO;
            btn.titleLabel.font = SDFont(14);
        }
    }
    if (self.titleBtnClickBlock){
        self.titleBtnClickBlock(sender);
    }
}
@end
