//
//  SDMeHeadView.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDMeHeadView.h"
#import "SDMeHeadTopView.h"
///获赞,粉丝,关注view
@interface SDMeHeadBottomView()

@property (nonatomic,strong) NSMutableArray *titleArr;

@end
@implementation SDMeHeadBottomView


- (NSMutableArray *)titleArr{
    if(!_titleArr){
        NSArray *arr = @[@"获赞",@"粉丝",@"关注"];
        _titleArr = [NSMutableArray arrayWithArray:arr];
    }
    return _titleArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    for (int i = 0 ; i<self.titleArr.count; i++){
        ///获赞
        UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        likeBtn.frame = CGRectMake(i*80+kWidth(15), 0, 80, 40);
        [likeBtn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        likeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        likeBtn.titleLabel.font = SDFont(14);
        [likeBtn setTitleColor:UIColorFromRGB0X(0xFFFFFF) forState:UIControlStateNormal];
        likeBtn.tag = 100+i;
        [likeBtn  addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: likeBtn];
    }
    
}

- (NSMutableAttributedString *)setBtnText:(NSString *)title{
    NSString *titleStr = nil;
    titleStr = [NSString stringWithFormat:@"%@",title];
    NSMutableAttributedString *titleAttribut = [NSString sd_changeFontWithStr:titleStr font:SDBoldFont(14) range:NSMakeRange(0, title.length-2)];
    return titleAttribut;
}

- (void)setBtnValue:(NSInteger )count withTag:(NSInteger )tag{
    UIButton *btn = [self viewWithTag:tag];
    NSString *countStr = nil;
    
    if (count>10000){
        
        CGFloat num = (CGFloat)count/10000;
        countStr =  [NSString stringWithFormat:@"%.f万",num];
    }else {
        countStr = [NSString stringWithFormat:@"%ld",count];
    }
    
    NSInteger index = tag-100;
    [btn setAttributedTitle:[self setBtnText:[NSString stringWithFormat:@"%@%@",countStr,self.titleArr[index]]] forState:UIControlStateNormal];
    
}


- (void)likeBtnClick:(UIButton *)sender{
    DLog(@"sender:%ld",sender.tag);
    if (self.btnClickBlock) {
        self.btnClickBlock(sender);
    }
}


@end



///年龄星座地址view
@interface SDMeHeadTagsView()

@property (nonatomic,strong) NSMutableArray *titleViewArr;

@end
@implementation SDMeHeadTagsView

-(NSMutableArray *)titleViewArr{
    if(!_titleViewArr){
        _titleViewArr = [NSMutableArray array];
    }
    return _titleViewArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

///设置数组
-(void)setTitleArr:(NSMutableArray *)titleArr{
    
    _titleArr = titleArr;
    NSInteger count = titleArr.count;
    NSInteger currentBtns = self.titleViewArr.count;
    for (int i=0;i<count;i++)
    {
        UIButton *btn = nil;
        if (i>=currentBtns){
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = SDFont(12);
            [btn setTitleColor:UIColorFromRGB0X(0xFFFFFF) forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage sd_imageWithColor:UIColorFromRGBAlpha(0xFFFFFF, 0.3)] forState:UIControlStateNormal];
            btn.layer.cornerRadius = 25/2;
            btn.layer.masksToBounds = YES;
            [self addSubview:btn];
            [self.titleViewArr addObject:btn];
        }else {
            btn = self.titleViewArr[i];
        }
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.hidden = NO;
    }
    
    for (int i= (int)count ;i<self.titleViewArr.count;i++){
        UIButton *btn = self.titleViewArr[i];
        btn.hidden = YES;
    }
    //重新布局子控件
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat margin = kWidth(15);
    CGFloat btnW = 0 ;
    CGFloat btnH = 25;
    CGFloat btnX = 0;
    CGFloat btnY = (50-25)/2;
    for (int i=0;i<self.titleViewArr.count;i++){
        CGFloat width = [NSString sd_getFloatForTextWithFontSize:12 text:self.titleArr[i]]+20;
        UIButton *btn = self.titleViewArr[i];
        btnW = width;
        
        btnX = kWidth(10)*i+margin;
        btn.frame = CGRectMake(btnX,btnY, btnW, btnH);
        margin = margin+btnW;
    }
    
}


@end
@implementation SDMeHeadView

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
    
    
    
    ///头部view
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.image = [UIImage imageNamed:@"imgXiaozhushou80"];
    headImageView.layer.borderWidth = 2;
    headImageView.layer.cornerRadius = kWidth(77)/2;
    headImageView.layer.masksToBounds = YES;
    headImageView.userInteractionEnabled = YES;
    headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:headImageView];
    self.headImageView = headImageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headViewClick)];
    [headImageView addGestureRecognizer:tap];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kWidth(15)));
        make.top.equalTo(@(kWidth(5)));
        make.width.height.equalTo(@(kWidth(75)));
    }];
    
    ///name
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = UIColorFromRGB0X(0xFFFFFF);
    nameLabel.text = @"昵称加载中";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = SDBoldFont(20);
    nameLabel.numberOfLines = 1;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImageView.mas_bottom).offset(kWidth(20));
        make.left.equalTo(headImageView.mas_left);;
        make.right.equalTo(self.mas_right).offset(kWidth(-20));
        make.height.equalTo(@(30));
    }];
    
    ///num
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.textColor = UIColorFromRGB0X(0xFFFFFF);
    numLabel.text = [NSString stringWithFormat:@"%@号:",KDouYinTitle];
    numLabel.textAlignment = NSTextAlignmentLeft;
    numLabel.font = SDFont(12);
    numLabel.numberOfLines = 1;
    [self addSubview:numLabel];
    self.numLabel = numLabel;
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(kWidth(5));
        make.left.equalTo(headImageView.mas_left);;
        make.right.equalTo(self.mas_right).offset(kWidth(-20));
        make.height.equalTo(@(20));
    }];
    
    ///下划线
    UIView *topline = [[UIView alloc] init];
    topline.backgroundColor = UIColorFromRGB0X(0x35324E);
    [self addSubview:topline];
    [topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLabel.mas_left);
        make.top.equalTo(self.numLabel.mas_bottom).offset(10);
        make.right.equalTo(self.mas_right).offset(kWidth(-15));
        make.height.equalTo(@(0.5));
    }];
    
    ///个人签名
    UILabel *signatureLabel = [[UILabel alloc] init];
    signatureLabel.backgroundColor = [UIColor clearColor];
    signatureLabel.textColor = UIColorFromRGB0X(0x979698);
    signatureLabel.text = @"该用户很高冷什么都不想说";
    signatureLabel.textAlignment = NSTextAlignmentLeft;
    signatureLabel.font = SDFont(12);
    signatureLabel.numberOfLines = 1;
    [self addSubview:signatureLabel];
    self.signatureLabel = signatureLabel;
    [signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topline.mas_bottom).offset(kWidth(15));
        make.left.equalTo(headImageView.mas_left);;
        make.right.equalTo(self.mas_right).offset(kWidth(-20));
        make.height.equalTo(@(20));
    }];
    
    ///年龄星座地址
    SDMeHeadTagsView *tagsView = [[SDMeHeadTagsView alloc]init];
    [self addSubview:tagsView];
    self.tagsView = tagsView;
    ///地址
    NSString *address = @"地址未填写";
    
    ///星座
    NSString *constellation = @"星座未填写";
    
    ///年龄
    NSString *age = @"年龄未填写";
    self.tagsView.titleArr = [NSMutableArray arrayWithArray:@[age,address,constellation]] ;
    [tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(signatureLabel.mas_bottom).offset(kWidth(10));
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@(50));
    }];
    
    ///获赞,粉丝,关注
    SDMeHeadBottomView *bottomView = [[SDMeHeadBottomView alloc]init];
    
    [bottomView setBtnValue:0 withTag:100];
    [bottomView setBtnValue:0 withTag:101];
    [bottomView setBtnValue:0 withTag:102];
    
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    KWeakself
    bottomView.btnClickBlock = ^(UIButton *sender) {
        [weakSelf bottomViewBtnClick:sender];
    };
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tagsView.mas_left);
        make.top.equalTo(tagsView.mas_bottom);
        make.width.equalTo(tagsView.mas_width);
        make.height.equalTo(@(40));
    }];
    
    SDMeHeadTopView *topView = [[SDMeHeadTopView alloc]init];
    [self addSubview:topView];
    topView.topViewBtnClickBlock = ^(UIButton *sender) {
        [weakSelf topViewBtnClick:sender];
    };
    self.topView = topView;
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(headImageView.mas_centerY);
        make.left.equalTo(headImageView.mas_right).offset(10);
        make.height.equalTo(@(50));
    }];
    
}

-(void)setHeadViewType:(HeadViewType)headViewType{
    _headViewType = headViewType;
    [self.topView setTopViewType:self.headViewType ==HeadViewTypeMe? TopViewTypeMe:TopViewTypeOther];
}



///头部点击
- (void)headViewClick{
    DLog(@"头部点击");
    if ([self.headViewDelegate respondsToSelector:@selector(sdMeHeadViewHeadBtnClick)]){
        [self.headViewDelegate sdMeHeadViewHeadBtnClick];
    }
}

///粉丝.关注.点击
- (void)bottomViewBtnClick:(UIButton *)sender{
    
    if ([self.headViewDelegate respondsToSelector:@selector(sdMeHeadView:bottomViewBtnClick:)]) {
        [self.headViewDelegate sdMeHeadView:self bottomViewBtnClick:sender];
    }
}

///添加关注,发送信息,设置,等点击
- (void)topViewBtnClick:(UIButton *)sender{
    if ([self.headViewDelegate respondsToSelector:@selector(sdMeHeadView:topViewBtnClick:)]){
        [self.headViewDelegate sdMeHeadView:self topViewBtnClick:sender];
    }
}

- (void)setHeadValueModel:(SDUser *)model{
    
    self.nameLabel.text = model.nickname;
    self.numLabel.text = [NSString stringWithFormat:@"%@号:%@",KDouYinTitle,model.shortId];
    self.signatureLabel.text = [NSString stringWithFormat:@"%@",[NSString sd_isBlankString:model.signature]?@"该用户很高冷什么都不想说":model.signature];
    ///获赞
    [self.bottomView setBtnValue:model.totalFavorited withTag:100];
    ///粉丝
    [self.bottomView setBtnValue:model.followingCount withTag:101];
    ///关注
    [self.bottomView setBtnValue:model.mplatformFollowersCount withTag:102];
    
    ///头像
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[model.avatarMedium.urlList firstObject]] placeholderImage:[UIImage imageNamed:@"imgXiaozhushou80"]];
    
    ///地址
    NSString *address = model.location;
    
    ///星座
    NSString *constellation = @"星座未填写";
    
    ///年龄
    NSString *age = @"年龄未填写";
    if (![NSString sd_isBlankString:model.birthday]){
        
        constellation = [NSString sd_gerAstroWithBirthday:model.birthday];
        
        age = [NSString stringWithFormat:@"%@%@",model.gender==0?@"♂":@"♀",[NSString sd_getAgeWithBirthday:model.birthday]];
    }
    self.tagsView.titleArr = [NSMutableArray arrayWithArray:@[age,address,constellation]] ;
    
}

@end
