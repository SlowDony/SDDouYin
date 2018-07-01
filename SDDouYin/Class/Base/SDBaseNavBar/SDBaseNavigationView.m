//
//  SDBaseNavigationView.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseNavigationView.h"


@implementation SDBaseNavigationView

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

-(void)setupUI{
    //背景view
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
    }];
    
    //leftBtn
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"alimember_navbar_left"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:KNavigationTitleColor forState:UIControlStateNormal];
    leftBtn.titleLabel.font = SDFont(14);
    [leftBtn  addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: leftBtn];
    self.leftBtn = leftBtn;
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.bottom.equalTo(@(-(44-30)/2));
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    
    //right
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitleColor:KNavigationTitleColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = SDFont(14);
    [rightBtn  addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.hidden = YES;
    [self addSubview: rightBtn];
    self.rightBtn = rightBtn;
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.bottom.equalTo(@(-(44-30)/2));
        make.width.equalTo(@(40));
        make.height.equalTo(@(30));
    }];
    //
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = KNavigationTitleColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.numberOfLines = 1;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBtn.mas_right).offset(10);
        make.bottom.equalTo(leftBtn.mas_bottom);
        make.right.equalTo(rightBtn.mas_left);
        make.height.equalTo(leftBtn.mas_height);
    }];
    
}

- (void)leftBtnClick:(UIButton *)sender{
    if(self.leftBtnClickBlock){
        self.leftBtnClickBlock(sender);
    }
}
- (void)rightBtnClick:(UIButton *)sender{
    if(self.rightBtnClickBlock){
        self.rightBtnClickBlock(sender);
    }
}


- (void)setTitleName:(NSString *)name{
    self.titleLabel.text = name;
}


@end
