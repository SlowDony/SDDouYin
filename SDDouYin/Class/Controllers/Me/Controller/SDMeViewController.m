//
//  SDMeViewController.m
//  SDInKe
//
//  Created by slowdony on 2018/1/25.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDMeViewController.h"
#import "SDMeHeadView.h"
#import "SDMeEditViewController.h"
#import "SDMeHeadTitleView.h"
#import "SDBaseNavigationView.h"
#import "SDMeWorksViewController.h"
#import "SDMeLikeViewController.h"
#import "SDUser.h"
#import "SDUserTool.h"
#define headViewHeight (kWidth(130)+170)
@interface SDMeViewController ()
<
SDMeHeadViewDelegate,
UIScrollViewDelegate
>
@property (nonatomic,strong)  SDMeHeadView *headView;
@property (nonatomic,strong)  SDMeHeadTitleView *titleView;
@property (nonatomic,strong)  UIScrollView *childVCScrollView;
@property (nonatomic,strong)  SDBaseNavigationView *navigationView;
@property (nonatomic,strong)  SDMeWorksViewController * worksVC;
@end

@implementation SDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addNotification];
    [self network];
}

- (void)setupUI{
    [self.view addSubview:self.childVCScrollView];
    [self.childVCScrollView addSubview:self.worksVC.view];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.navigationView];
    
}


#pragma mark - SDMeHeadViewDelegate
- (void)sdMeHeadView:(SDMeHeadView *)headView bottomViewBtnClick:(UIButton *)sender {
    DLog(@"bottomView");
}

- (void)sdMeHeadView:(SDMeHeadView *)headView topViewBtnClick:(UIButton *)sender {
    DLog(@"topView");
}

- (void)sdMeHeadViewHeadBtnClick {
    DLog(@"头部点击");
    SDMeEditViewController *editMeVC = [[SDMeEditViewController alloc]init];
    editMeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editMeVC animated:YES];
}

#pragma mark - scrollViewDelegate






#pragma mark - addNotification
- (void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(childScrollViewDidScrollView:) name:SDScrollViewOffSetNotification object:nil];
}

- (void)removeNotification{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:SDScrollViewOffSetNotification object:nil];
}

-(void)dealloc{
    [self removeNotification];
}

#pragma mark - NSNotification

- (void)childScrollViewDidScrollView:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGFloat scrollViewOffY = [userInfo[SDScrollViewOffSetKey] floatValue];
    
    self.headView.frame = CGRectMake(0, kNavBarHeight- scrollViewOffY, SCREEN_WIDTH,headViewHeight);
    if (CGRectGetHeight(self.headView.frame)-scrollViewOffY >=0){
        self.titleView.frame = CGRectMake(0, kNavBarHeight+CGRectGetHeight(self.headView.frame)- scrollViewOffY, SCREEN_WIDTH, 44);
    }else {
        self.titleView.frame = CGRectMake(0, kNavBarHeight, SCREEN_WIDTH, 44);
    }
    self.navigationView.backgroundColor = [UIColorFromRGB0X(0x242137)colorWithAlphaComponent:scrollViewOffY/headViewHeight];
    self.navigationView.titleLabel.alpha = scrollViewOffY/headViewHeight;
    self.headView.alpha = 1-scrollViewOffY/headViewHeight;
    
}

- (void)network{
    
    [SDUserTool getUserInfoTaskSuccess:^(id obj) {
        SDUser *user = (SDUser *)obj;
        DLog(@"user:%@",user.nickname);
        [self.headView setHeadValueModel:user];
        self.navigationView.titleLabel.text = user.nickname;
    } failed:^(id obj) {
        
    }];
}



#pragma mark - lazy


-(UIScrollView *)childVCScrollView{
    if (!_childVCScrollView) {
        _childVCScrollView = [[UIScrollView alloc] init];
        _childVCScrollView.frame = CGRectMake(0, kNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kNavBarHeight);
        _childVCScrollView.contentSize = CGSizeMake(0,SCREEN_HEIGHT);
        _childVCScrollView.backgroundColor = [UIColor blueColor];
        _childVCScrollView.showsHorizontalScrollIndicator = NO;
        _childVCScrollView.showsVerticalScrollIndicator = NO;
        _childVCScrollView.pagingEnabled = NO;
        _childVCScrollView.bounces = YES;
        _childVCScrollView.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            _childVCScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _childVCScrollView;
}

-(SDMeHeadTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[SDMeHeadTitleView alloc]initWithFrame:CGRectMake(0,kNavBarHeight+headViewHeight, SCREEN_WIDTH, 44)];
    }
    return _titleView;
}

///头部view
-(SDMeHeadView *)headView{
    if(!_headView){
        _headView = [[SDMeHeadView alloc]initWithFrame:CGRectMake(0,kNavBarHeight, SCREEN_WIDTH, headViewHeight)];
        _headView.headViewDelegate = self;
        _headView.backgroundColor = KMainBackgroundColor;
    }
    return _headView;
}
///导航栏
- (SDBaseNavigationView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[SDBaseNavigationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNavBarHeight)];
        _navigationView.backgroundColor = KNavigationBarBackgroundColor;
        _navigationView.leftBtn.alpha = 1;
        _navigationView.backgroundColor = [UIColorFromRGB0X(0x242137)colorWithAlphaComponent:0.0f];
        _navigationView.titleLabel.alpha = 0;
        
    }
    return _navigationView;
}

/**
 作品
 */
-(SDMeWorksViewController *)worksVC{
    if (!_worksVC) {
        _worksVC = [[SDMeWorksViewController alloc]init];
        [self addChildViewController:_worksVC];
        _worksVC.view.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _worksVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





@end
