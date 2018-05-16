//
//  SDShowTopView.m
//  SDInKe
//
//  Created by slowdony on 2018/1/31.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDShowTopView.h"

///标题
@interface SDShowTitleView()

///存标题数组
@property (nonatomic,strong) NSMutableArray *btnViewsArr;

///存竖线
@property (nonatomic,strong) NSMutableArray *centerViewsArr;

///中间竖线
@property (nonatomic,strong) UIView *  centerView;

@end
@implementation SDShowTitleView

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
    self.centerViewsArr = [NSMutableArray array];
    for (int i =0;i<btnsArr.count; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btnsArr[i] forState:UIControlStateNormal];
        [btn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [self addSubview: btn];
        [self.btnViewsArr  addObject:btn];
        [self setBtnSelectd:0];
        UIView *centerView = [[UIView alloc] init];
        centerView.backgroundColor = UIColorFromRGB0X(0xFFACACB1);
        [self addSubview:centerView];
        if (i!=(btnsArr.count-1)) {
            [self.centerViewsArr addObject:centerView];
        }
    }
    [self setNeedsLayout];
    
}
- (void)setSelectIndex:(CGFloat)selectIndex{
    _selectIndex = selectIndex;
    [self setBtnSelectd:selectIndex];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnX = 0 ;
    CGFloat btnY = 0 ;
    CGFloat btnW = 50;
    CGFloat btnH = 44;
    CGFloat width = btnW*self.btnViewsArr.count;
    CGFloat btnViewX = (CGRectGetWidth(self.frame)-width)/2;
    for (int i = 0; i< self.btnViewsArr.count;i++){
        UIButton *btn = self.btnViewsArr[i];
        btnX = i*btnW +btnViewX;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    CGFloat centerViewW = 2;
    CGFloat centerViewH = 10;
    CGFloat centerViewX = 0 ;
    CGFloat centerViewY = (btnH-centerViewH)/2 ;
    
    for (int i = 0; i< self.centerViewsArr.count;i++){
        UIView *centerView = self.centerViewsArr[i];
        centerViewX = (i+1)*btnW +btnViewX;
        centerView.frame = CGRectMake(centerViewX, centerViewY, centerViewW, centerViewH);
    }
    
}

///标题点击
-(void)btnClick:(UIButton *)sender{
    
    self.selectIndex = sender.tag -1000;
    
    //    setBtnSelectd:(NSInteger )tag
    [self setBtnSelectd:self.selectIndex];
    
    [UIView animateWithDuration:0.2 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform = CGAffineTransformIdentity;
        }];
    }];
    if (self.selectBtnBlock){
        self.selectBtnBlock(sender);
    }
}

- (void)setBtnSelectd:(NSInteger )tag{
    
    for (int i = 0; i< self.btnViewsArr.count;i++){
        UIButton *btn = self.btnViewsArr[i];
        if ((btn.tag -1000)==tag) {
            btn.titleLabel.font = SDBoldFont(16);
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            btn.titleLabel.font = SDFont(16);
            [btn setTitleColor:UIColorFromRGB0X(0xFFD6D6D6) forState:UIControlStateNormal];
        }
    }
}

@end

///头部
@interface SDShowTopView()

@property (nonatomic,strong) SDShowTitleView *topTitleView;//标题数组

@property (nonatomic,strong) UIButton *searchBtn; //搜索
@end

@implementation SDShowTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    
    //leftBtn
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"<#string#>"] forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn  addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kWidth(20));
        make.bottom.equalTo(self.mas_bottom).offset(-7);
        make.width.height.equalTo(@(30));
    }];
    
    //搜索
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"HomeSearchIcon"] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor redColor]];
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: searchBtn];
    self.searchBtn = searchBtn;
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(kWidth(-20));
        make.centerY.equalTo(leftBtn.mas_centerY);
        make.width.height.equalTo(leftBtn.mas_width);
    }];
    
    ///标题
    SDShowTitleView * topTitleView = [[SDShowTitleView alloc]init];
    self.topTitleView = topTitleView;
    [self addSubview:topTitleView];
    topTitleView.backgroundColor = [UIColor clearColor];
    KWeakself
    topTitleView.selectBtnBlock = ^(UIButton *selectBtn) {
        [weakSelf btnClick:selectBtn];
    };
    [topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBtn.mas_right).offset(10);
        make.centerY.equalTo(leftBtn.mas_centerY);
        make.right.equalTo(searchBtn.mas_left).offset(-10);
        make.height.equalTo(@(44));
    }];
}


#pragma mark - set

///设置标题
- (void)setTopTitleArr:(NSMutableArray *)titleArr{
    [self.topTitleView setBtnsArr:titleArr];
}

- (void)setSelectIndex:(CGFloat)selectIndex{
    [self.topTitleView setSelectIndex:selectIndex];
}

#pragma mark - clicks

///标题点击
-(void)btnClick:(UIButton *)sender{
    
    if (self.selectBtnBlock){
        self.selectBtnBlock(sender);
    }
}

///搜索按钮点击
- (void)searchBtnClick:(UIButton *)sender{
    
    if (self.searchBtnBlock){
        self.searchBtnBlock(sender);
    }
}

///左按钮点击
- (void)leftBtnClick:(UIButton *)sender{
    if (self.headImageBtnBlock){
        self.headImageBtnBlock();
    }
}

@end
