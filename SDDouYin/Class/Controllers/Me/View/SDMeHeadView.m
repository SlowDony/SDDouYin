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

@property (nonatomic,strong) NSMutableArray *colorArr; //渐变颜色数组

@end
@implementation SDMeHeadTagsView

-(NSMutableArray *)colorArr{
    if(!_colorArr){
        NSArray *colors  = @[@[UIColorFromRGB0X(0x5D7BE9),UIColorFromRGB0X(0x43A6E3)],@[UIColorFromRGB0X(0xBC67ED),UIColorFromRGB0X(0x8575FE)],@[UIColorFromRGB0X(0xED67A9),UIColorFromRGB0X(0xFE7579)]];
        _colorArr = [NSMutableArray arrayWithArray:colors];
    }
    return _colorArr;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *topline = [[UIView alloc] init];
        topline.backgroundColor = UIColorFromRGB0X(0x35324E);
        [self addSubview:topline];
        [topline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(kWidth(15));
            make.top.equalTo(self.mas_top).offset(-1);
            make.right.equalTo(self.mas_right).offset(kWidth(-15));
            make.height.equalTo(@(0.5));
        }];
        
        UIView *bottomline = [[UIView alloc] init];
        bottomline.backgroundColor = UIColorFromRGB0X(0x35324E);
        [self addSubview:bottomline];
        [bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(kWidth(15));
            make.bottom.equalTo(self.mas_bottom).offset(-1);
            make.right.equalTo(self.mas_right).offset(kWidth(-15));
            make.height.equalTo(@(0.5));
        }];
        
    }
    return self;
}

///设置数组
-(void)setTitleArr:(NSMutableArray *)titleArr{
    
    _titleArr = titleArr;
    CGFloat margin = kWidth(15);
    CGFloat btnW = 0 ;
    CGFloat btnH = 25;
    CGFloat btnX = 0;
    
    for (int i=0;i<titleArr.count;i++){
        
        CGFloat width = [NSString sd_getFloatForTextWithFontSize:12 text:self.titleArr[i]]+20;
        btnW = width;
        btnX = kWidth(10)*i+margin;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = SDFont(12);
        [btn setTitleColor:UIColorFromRGB0X(0xFFFFFF) forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage sd_createImageWithSize:CGSizeMake(btnW, btnH) gradientColors:self.colorArr[i] percentage:@[@(0),@(1)] gradientType:GradientFromLeftToRight] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [self addSubview:btn];
        ///布局
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(btnX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@(btnW));
            make.height.equalTo(@(btnH));
        }];
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
    headImageView.image = [UIImage imageNamed:@"logo"];
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
        make.top.equalTo(@(kWidth(5)+kNavBarHeight));
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
        make.top.equalTo(numLabel.mas_bottom).offset(kWidth(15));
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
    /*
    self.nameLabel.text = model.userName;
    self.numLabel.text = [NSString stringWithFormat:@"%@号:%@",kYomoTitle,model.yomoNumber];
    self.signatureLabel.text = [NSString stringWithFormat:@"%@",[NSString isBlankString:model.phrases]?@"该用户很高冷什么都不想说":model.phrases];
    ///获赞
    [self.bottomView setBtnValue:model.totalPraiseNum withTag:100];
    ///粉丝
    [self.bottomView setBtnValue:model.totalFansNum withTag:101];
    ///关注
    [self.bottomView setBtnValue:model.totalAttentionNum withTag:102];
    
    ///头像
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString appendImageServiceDomain:model.avatarOssUrl imageType:nil]] placeholderImage:kGainUserDefaultAvatar(kCurrentUser.gender)];
    
    ///地址
    NSString *address = @"地址未填写";
    
    ///星座
    NSString *constellation = @"星座未填写";
    
    ///年龄
    NSString *age = @"年龄未填写";
    if (![NSString isBlankString:model.userProfile.birthday]){
        constellation = [NSString getAstroWithMonth:[self dataTransform:model.userProfile.birthday dataFormat:@"M"] day:[self dataTransform:model.userProfile.birthday dataFormat:@"d"]];
        NSString *birthdayStr = model.userProfile.birthday;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
        NSDate *birthdayDate = [dateFormatter dateFromString:birthdayStr];
        age = [NSString stringWithFormat:@"%@%@",model.gender==0?@"♀":@"♂",[NSString getAgeWith:birthdayDate]] ;
    }
    self.tagsView.titleArr = [NSMutableArray arrayWithArray:@[age,address,constellation]] ;
    */
}


///返回具体月份或日
- (NSInteger )dataTransform:(NSString *)dataStr dataFormat:(NSString *)dataFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dataFormat];
    NSDate *date = [dateFormatter dateFromString:dataStr];
    NSString * comfromTimeStr = [dateFormatter stringFromDate:date];
    return [comfromTimeStr intValue];
}

@end
