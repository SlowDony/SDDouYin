//
//  SDTabBarViewController.m
//  SDInKe
//
//  Created by slowdony on 2018/1/24.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDTabBarViewController.h"
#import "SDTabBar.h"
#import "SDBaseNavigationController.h"
#import "SDMeViewController.h"    //我
#import "SDHomeViewController.h"  //首页
#import "SDFocusViewController.h" //关注
#import "SDNewsViewController.h"  //消息
#import "SDAddViewController.h"   //上传

@interface SDTabBarViewController ()
<SDTabBarDelegate>

@property (nonatomic,strong)  SDTabBar *tabbar;

@end

@implementation SDTabBarViewController

#pragma mark - lazy
- (SDTabBar *)tabbar{
    if (!_tabbar){
        _tabbar = [[SDTabBar alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 49)];
        _tabbar.delegate = self;
    }
    return _tabbar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
    [self.tabBar  addSubview:self.tabbar];
    [[UITabBar appearance]setShadowImage:[UIImage new]];
    [[UITabBar appearance]setBackgroundImage:[UIImage new]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupViewControllers{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[@"SDHomeViewController",@"SDFocusViewController",@"SDNewsViewController",@"SDMeViewController"]];
    for (int i = 0 ; i<arr.count; i++) {
        NSString *vcName = arr[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc]init];
        SDBaseNavigationController * navc = [[SDBaseNavigationController alloc]initWithRootViewController:vc];
        [arr replaceObjectAtIndex:i withObject:navc];
    }
    self.viewControllers = arr;
}

#pragma mark - SDTabBarDelegate
- (void)tabbar:(SDTabBar *)tabbar withBtn:(TabBarType)tabbarType{
    if (tabbarType !=TabBarTypeAdd){
        self.selectedIndex = tabbarType-TabBarTypeHome;
        return;
    }
    SDAddViewController *addVC = [[SDAddViewController alloc]init];
    [self presentViewController:addVC animated:YES completion:nil];
    
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
