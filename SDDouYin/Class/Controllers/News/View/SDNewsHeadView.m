//
//  SDNewsHeadView.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDNewsHeadView.h"
@implementation SDNewsHeadItem 
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //图标
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.equalTo(@(40));
    }];
    
    //title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.numberOfLines = 1;
    [self addSubview:titleLabel];
    self.nameLable = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView.mas_bottom);
        make.left.equalTo (self.mas_left);
        make.width.equalTo(self.mas_width);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
@end

@interface SDNewsHeadView()
@property (nonatomic,strong) NSMutableArray * titleArr;
@end

@implementation SDNewsHeadView

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

#pragma mark - layz
-(NSMutableArray *)titleArr{
    if (!_titleArr) {
        NSArray *arr = @[
                    @{@"title":@"粉丝",@"iconImage":@"icon_notice_fans"},
                    @{@"title":@"赞",@"iconImage":@"icon_notice_like"},
                    @{@"title":@"@我的",@"iconImage":@"icon_notice_people"},
                    @{@"title":@"评论",@"iconImage":@"icNoticeComment"}];
        _titleArr = [NSMutableArray arrayWithArray:arr];
    }
    return _titleArr;
}
- (void)setupUI{
    
    for (int i=0; i<self.titleArr.count; i++) {
        SDNewsHeadItem * headItem = [[SDNewsHeadItem alloc]init];
        NSDictionary * dic = self.titleArr[i];
        headItem.iconImageView.image = [UIImage imageNamed:dic[@"iconImage"]];
        headItem.nameLable.text =dic[@"title"];
        headItem.backgroundColor = [UIColor clearColor];
        headItem.tag = 100+i;
        [headItem addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:headItem];
    }
}
- (void)itemBtnClick:(UIButton *)sender{
    if (self.headItemClickBlock){
        self.headItemClickBlock(sender);
    }
}
-(void)layoutSubviews{
    
    CGFloat btnX = 0;
    CGFloat btnH = 80;
    CGFloat btnY =(CGRectGetHeight(self.frame)-btnH)/2;
    CGFloat btnW = SCREEN_WIDTH/4;
   
    for (int i=0; i<self.subviews.count; i++) {
        SDNewsHeadItem * headItem =(SDNewsHeadItem *) self.subviews[i];
        btnX = i*btnW;
        headItem.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}
@end
