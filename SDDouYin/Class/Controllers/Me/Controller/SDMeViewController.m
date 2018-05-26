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
@interface SDMeViewController ()
<SDMeHeadViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)  SDMeHeadView *headView;
@property (nonatomic,strong)  SDMeHeadTitleView *titleView;
@property (nonatomic,strong)  UIScrollView *mainScrollView;
@property (nonatomic,strong)  UIScrollView *childVCScrollView;

@end

@implementation SDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}
- (void)setupUI{
    [self.view addSubview:self.headView];
    [self.view addSubview:self.titleView];

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



#pragma mark - lazy

-(UIScrollView *)mainScrollView{
    if(!_mainScrollView){
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _mainScrollView.delegate = self;
        _mainScrollView.contentSize = CGSizeMake(0,SCREEN_HEIGHT);
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = NO;
        _mainScrollView.bounces = YES;
    }
    return _mainScrollView;
}

-(UIScrollView *)childVCScrollView{
    if (!_childVCScrollView) {
        _childVCScrollView = [[UIScrollView alloc] init];
        _childVCScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _childVCScrollView.contentSize = CGSizeMake(0,SCREEN_HEIGHT);
        _childVCScrollView.backgroundColor = [UIColor clearColor];
        _childVCScrollView.showsHorizontalScrollIndicator = NO;
        _childVCScrollView.showsVerticalScrollIndicator = NO;
        _childVCScrollView.pagingEnabled = YES;
        _childVCScrollView.bounces = YES;
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
        _headView = [[SDMeHeadView alloc]initWithFrame:CGRectMake(0, kNavigationStatusBarHeight, SCREEN_WIDTH, 300)];
        _headView.headViewDelegate = self;
//        _headView.backgroundColor = UIColorFormRandom;
        //        _headView.headViewType = self.personalDataType==PersonalDataTypeMe?HeadViewTypeMe:HeadViewTypeOther;
    }
    return _headView;
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
