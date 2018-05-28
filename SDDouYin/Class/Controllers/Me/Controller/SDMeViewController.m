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

#define headViewHeight 300
@interface SDMeViewController ()
<SDMeHeadViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)  SDMeHeadView *headView;
@property (nonatomic,strong)  SDMeHeadTitleView *titleView;
@property (nonatomic,strong)  UIScrollView *mainScrollView;
@property (nonatomic,strong)  UIScrollView *childVCScrollView;
@property (nonatomic,strong)  SDBaseNavigationView *navigationView;
@property (nonatomic,strong)  SDMeWorksViewController * worksVC; 
@end

@implementation SDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addNotification];
    // Do any additional setup after loading the view.
}
- (void)setupUI{
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headView];
    [self.mainScrollView addSubview:self.titleView];
    [self.view addSubview:self.navigationView];
    [self.mainScrollView addSubview:self.childVCScrollView];
    [self.childVCScrollView addSubview:self.worksVC.view];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    DLog(@"scrollViewWillBeginDragging");
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    DLog(@"scrollViewDidEndDecelerating");
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    DLog(@"scrollViewDidEndScrollingAnimation");
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
     DLog(@"scrollViewDidZoom");
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
    
    
//    DLog(@"scrollViewOffY:%f",scrollViewOffY);
    
//    [self.mainScrollView setContentOffset:CGPointMake(0, scrollViewOffY) animated:NO];
    /*
    self.headView.frame = CGRectMake(0, SafeAreaTopHeight- scrollViewOffY, ScreenWidth, 300);
    if (CGRectGetHeight(self.headView.frame)-scrollViewOffY >=0){
        self.titleBtnView.frame = CGRectMake(0, SafeAreaTopHeight+CGRectGetHeight(self.headView.frame)- scrollViewOffY, ScreenWidth, 44);
    }else {
        self.titleBtnView.frame = CGRectMake(0, SafeAreaTopHeight, ScreenWidth, 44);
    }
     */
   // self.navigationView.alpha = scrollViewOffY/300;
    
}



#pragma mark - lazy

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
        _childVCScrollView.frame = CGRectMake(0, 300+40+kNavigationStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-(300+40+kNavigationStatusBarHeight));
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
        _titleView = [[SDMeHeadTitleView alloc]initWithFrame:CGRectMake(0,kNavigationStatusBarHeight+CGRectGetHeight(self.headView.frame), SCREEN_WIDTH, 40)];
    }
    return _titleView;
}

-(SDMeHeadView *)headView{
    if(!_headView){
        _headView = [[SDMeHeadView alloc]initWithFrame:CGRectMake(0, kNavigationStatusBarHeight, SCREEN_WIDTH, headViewHeight)];
        _headView.headViewDelegate = self;
//        _headView.backgroundColor = UIColorFormRandom;
        //  _headView.headViewType = self.personalDataType==PersonalDataTypeMe?HeadViewTypeMe:HeadViewTypeOther;
    }
    return _headView;
}

- (SDBaseNavigationView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[SDBaseNavigationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNavigationStatusBarHeight)];
        _navigationView.titleLabel.text = @"昵称";
        _navigationView.backgroundColor = [UIColor redColor];
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
        self.worksVC.collectionView.scrollEnabled = NO;
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
