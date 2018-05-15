//
//  SDShowTopView.m
//  SDInKe
//
//  Created by slowdony on 2018/1/31.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDShowTopView.h"
@interface SDShowTopView()
@property (nonatomic,strong) NSMutableArray *btnViewsArr;
@property (nonatomic,strong) UIView *  bottomView;//底部下滑线

@end
@implementation SDShowTopView

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
        
    }
    return self;
}
- (void)setBtnsArr:(NSMutableArray *)btnsArr{
    _btnsArr = btnsArr;
    self.btnViewsArr = [NSMutableArray array];
    
    for (int i =0;i<btnsArr.count; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btnsArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [self addSubview: btn];
        [self.btnViewsArr  addObject:btn];
    }
    CGFloat btnW = (SCREEN_WIDTH-100)/self.btnViewsArr.count;
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(12.5, 34, btnW-30, 2);
    bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView = bottomView;
    [self addSubview:bottomView];
    
}
-(void)btnClick:(UIButton *)sender{
    
    self.selectIndex = sender.tag -1000;
    if (self.selectBtnBlock){
        self.selectBtnBlock(sender);
    }
    [self setNeedsLayout];
}
- (void)setSelectIndex:(CGFloat)selectIndex{
    _selectIndex = selectIndex;
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnX =0;
    CGFloat btnY =0;
    CGFloat btnW = (SCREEN_WIDTH-100)/self.btnViewsArr.count-50;
    CGFloat btnH = 44;
    for (int i = 0; i< self.btnViewsArr.count;i++){
        UIButton *btn = self.btnViewsArr[i];
        btnY = 0;
        btnX = i*btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.frame = CGRectMake(btnW*self.selectIndex+12.5,btnH-10, btnW-30, 2);
    }];
}
@end
