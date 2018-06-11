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

#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewControllerPlugin_TabViewBar.h"
#import "HJDefaultTabViewBar.h"

#define headViewHeight (300+44+kNavBarHeight)
@interface SDMeViewController ()
<
SDMeHeadViewDelegate,
UIScrollViewDelegate,
HJTabViewControllerDataSource,
HJTabViewControllerDelagate,
HJDefaultTabViewBarDelegate
>
@property (nonatomic,strong)  SDMeHeadView *headView;
//@property (nonatomic,strong)  SDMeHeadTitleView *titleView;
//@property (nonatomic,strong)  UIScrollView *mainScrollView;
//@property (nonatomic,strong)  UIScrollView *childVCScrollView;
@property (nonatomic,strong)  SDBaseNavigationView *navigationView;
//@property (nonatomic,strong)  SDMeWorksViewController * worksVC;
@end

@implementation SDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI{
    self.tabDataSource = self;
    self.tabDelegate = self;
    self.view.backgroundColor = KMainBackgroundColor;
    HJDefaultTabViewBar *tabViewBar = [HJDefaultTabViewBar new];
    tabViewBar.delegate = self;
    HJTabViewControllerPlugin_TabViewBar *tabViewBarPlugin = [[HJTabViewControllerPlugin_TabViewBar alloc] initWithTabViewBar:tabViewBar delegate:nil];
    [self enablePlugin:tabViewBarPlugin];
    
    [self enablePlugin:[HJTabViewControllerPlugin_HeaderScroll new]];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.navigationView];
}



#pragma mark - HJDefaultTabViewBarDelegate

- (NSInteger)numberOfTabForTabViewBar:(HJDefaultTabViewBar *)tabViewBar {
    return [self numberOfViewControllerForTabViewController:self];
}

///返回按钮标题
- (id)tabViewBar:(HJDefaultTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    if (index == 0) {
       return @"作品";
    }else {
       return @"喜欢";
    }
    
}

- (void)tabViewBar:(HJDefaultTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    BOOL anim = labs(index - self.curIndex) > 1 ? NO: YES;
    [self scrollToIndex:index animated:anim];
}

#pragma mark - HJTabViewControllerDelagate

- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewVerticalScroll:(CGFloat)contentPercentY {
    // 博主很傻，用此方法渐变导航栏是偷懒表现，只是为了demo演示。正确科学方法请自行百度 iOS导航栏透明
//    self.navigationController.navigationBar.alpha = contentPercentY;
    self.navigationView.alpha =contentPercentY;
}
///返回控制器两个
- (NSInteger)numberOfViewControllerForTabViewController:(HJTabViewController *)tabViewController {
    return 2;
}

///返回当前显示控制器
- (UIViewController *)tabViewController:(HJTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {
    if(index==0){
      SDMeWorksViewController *vc = [[SDMeWorksViewController alloc]init];
      return vc;
    }else {
       SDMeLikeViewController *vc = [[SDMeLikeViewController alloc]init];
       return vc;
    }
}
///返回头部
- (UIView *)tabHeaderViewForTabViewController:(HJTabViewController *)tabViewController {
    
    return self.headView;
}

- (CGFloat)tabHeaderBottomInsetForTabViewController:(HJTabViewController *)tabViewController {
    return HJTabViewBarDefaultHeight+kNavBarHeight;
}

- (UIEdgeInsets)containerInsetsForTabViewController:(HJTabViewController *)tabViewController {
    return UIEdgeInsetsMake(0, 0, 0, 0);
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
    [self.navigationController pushViewController:editMeVC animated:YES];
}




/*
- (void)setupUI{
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headView];
    [self.mainScrollView addSubview:self.titleView];
   
    [self.mainScrollView addSubview:self.childVCScrollView];
    [self.childVCScrollView addSubview:self.worksVC.view];

}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView ==self.mainScrollView)
    {
        CGFloat scrollOffSetY = scrollView.contentOffset.y;
//        DLog(@"scrollViewOffY:%f",scrollOffSetY);
        if (scrollOffSetY<headViewHeight){
            self.worksVC.collectionView.scrollEnabled = NO;
            self.mainScrollView.scrollEnabled = YES;
        }else {
            self.worksVC.collectionView.scrollEnabled = YES;
            self.mainScrollView.scrollEnabled = NO;
        }
        if (scrollOffSetY>headViewHeight){
            self.mainScrollView.contentOffset = CGPointMake(0, headViewHeight);
        }
    }
    
}




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


- (void)childScrollViewDidScrollView:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    
    CGFloat scrollViewOffY = [userInfo[SDScrollViewOffSetKey] floatValue];
   
    
    if (scrollViewOffY<=0){
        self.worksVC.collectionView.scrollEnabled = NO;
        self.mainScrollView.scrollEnabled = YES;
    }else {
        self.worksVC.collectionView.scrollEnabled = YES;
        self.mainScrollView.scrollEnabled = NO;
    }
    
}
*/


#pragma mark - lazy
/*
-(UIScrollView *)mainScrollView{
    if(!_mainScrollView){
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _mainScrollView.delegate = self;
        _mainScrollView.contentSize = CGSizeMake(0,SCREEN_HEIGHT+400);
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = NO;
        _mainScrollView.bounces = YES;
        if (@available(iOS 11.0, *)) {
            _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _mainScrollView;
}

-(UIScrollView *)childVCScrollView{
    if (!_childVCScrollView) {
        _childVCScrollView = [[UIScrollView alloc] init];
        _childVCScrollView.frame = CGRectMake(0, 300+40+kNavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(300+40+kNavBarHeight));
        _childVCScrollView.contentSize = CGSizeMake(0,SCREEN_HEIGHT);
        _childVCScrollView.backgroundColor = [UIColor clearColor];
        _childVCScrollView.showsHorizontalScrollIndicator = NO;
        _childVCScrollView.showsVerticalScrollIndicator = NO;
        _childVCScrollView.pagingEnabled = NO;
        _childVCScrollView.bounces = YES;
        _childVCScrollView.scrollEnabled = NO;
    }
    return _childVCScrollView;
}

-(SDMeHeadTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[SDMeHeadTitleView alloc]initWithFrame:CGRectMake(0,kNavBarHeight+CGRectGetHeight(self.headView.frame), SCREEN_WIDTH, 40)];
    }
    return _titleView;
}
*/
///头部view
-(SDMeHeadView *)headView{
    if(!_headView){
        _headView = [[SDMeHeadView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, headViewHeight)];
        _headView.headViewDelegate = self;
        _headView.backgroundColor = KMainBackgroundColor;
    }
    return _headView;
}
///导航栏
- (SDBaseNavigationView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[SDBaseNavigationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNavBarHeight)];
        _navigationView.titleLabel.text = @"昵称";
        _navigationView.backgroundColor = KNavigationBarBackgroundColor;
        _navigationView.alpha = 0;
    }
    return _navigationView;
}

///**
// 作品
// */
//-(SDMeWorksViewController *)worksVC{
//    if (!_worksVC) {
//        _worksVC = [[SDMeWorksViewController alloc]init];
//        [self addChildViewController:_worksVC];
//        _worksVC.view.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        self.worksVC.collectionView.scrollEnabled = NO;
//    }
//    return _worksVC;
//}

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
