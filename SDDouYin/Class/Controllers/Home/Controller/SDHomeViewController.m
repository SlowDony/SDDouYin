//
//  SDHomeViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/15.
//  Copyright © 2018年 slowdony. All rights reserved.
//


#import "SDHomeViewController.h"
#import "SDShowTopView.h"
#import "SDRecommendViewController.h"
#import "SDNearbyViewController.h"
#import "AppDelegate.h"
#import "SDTabBarViewController.h"
#import "SDSearchViewController.h"
/**
 首页
 */
@interface SDHomeViewController ()
<UIScrollViewDelegate>
///顶部标题
@property (nonatomic,strong) SDShowTopView *showTopView;
///推荐
@property (nonatomic,strong) SDRecommendViewController *recommendVC;
///附近
@property (nonatomic,strong) SDNearbyViewController *nearbyVC;
@property (nonatomic,strong) UIScrollView * mainScrollView;
@end

@implementation SDHomeViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    DLog(@"viewWillAppear");
    [self.recommendVC addNotification];
    if (self.mainScrollView.contentOffset.x==0){
        [self.recommendVC videoPlay];
    }else {
        [self.recommendVC videoPause];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.recommendVC videoPause];
    [self.recommendVC removeNotification];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.showTopView];
    [self.mainScrollView addSubview:self.recommendVC.view];
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x ==SCREEN_WIDTH){
        [self.mainScrollView addSubview:self.nearbyVC.view];
    }
}
//scrollview 减速停止时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat i = self.mainScrollView.contentOffset.x/SCREEN_WIDTH;
    self.showTopView.selectIndex = i;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)rightBtnClick:(UIButton *)sender
{
    DLog(@"右按钮");
    SDSearchViewController *searchVC = [[SDSearchViewController alloc]init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}
- (void)leftBtnClick:(UIButton *)sender
{
    DLog(@"左按钮");
    SDSearchViewController *searchVC = [[SDSearchViewController alloc]init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - lazy
-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _mainScrollView.delegate = self;
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2,SCREEN_HEIGHT);
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces =NO;
        _mainScrollView.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _mainScrollView;
}
/**
 附近
 */
-(SDNearbyViewController *)nearbyVC{
    
    if (!_nearbyVC){
        _nearbyVC = [[SDNearbyViewController alloc]init];
        [self addChildViewController:_nearbyVC];
        _nearbyVC.view.frame =CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _nearbyVC;
}
/**
 推荐
 */
-(SDRecommendViewController *)recommendVC{
    
    if (!_recommendVC){
        _recommendVC = [[SDRecommendViewController alloc]init];
        [self addChildViewController:_recommendVC];
        _recommendVC.view.frame =CGRectMake(0,0 , SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _recommendVC;
}
-(SDShowTopView *)showTopView{
    if (!_showTopView) {
        NSArray *arr = @[@"推荐",@"附近"];
        CGFloat width = SCREEN_WIDTH;
        _showTopView = [[SDShowTopView alloc]initWithFrame:CGRectMake(0, 0, width, kNavBarHeight)];
        _showTopView.selectIndex = 0;
        [_showTopView setTopTitleArr:arr];
        KWeakself
        _showTopView.selectBtnBlock = ^(UIButton *selectBtn) {
            CGFloat index = (selectBtn.tag-1000)*SCREEN_WIDTH;
            if (index==0){
                [KAppDelegate.tabBarVC  setTabbarAlpha:YES];
                [weakSelf.recommendVC videoPlay];
            }else if (index ==SCREEN_WIDTH){
                [KAppDelegate.tabBarVC  setTabbarAlpha:NO];
                [weakSelf.recommendVC videoPause];
            }
            CGPoint point = CGPointMake(index, 0);
            [weakSelf.mainScrollView setContentOffset:point animated:NO];
        };
        _showTopView.searchBtnBlock = ^(UIButton *searchBtn) {
            [weakSelf rightBtnClick:searchBtn];
        };
        _showTopView.leftBtnBlock = ^(UIButton *leftBtn) {
            [weakSelf leftBtnClick:leftBtn];
        };
        
    }
    return _showTopView;
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
