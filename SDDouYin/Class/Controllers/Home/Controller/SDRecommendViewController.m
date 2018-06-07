//
//  SDRecommendViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/15.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDRecommendViewController.h"
#import "SDHomeBtnView.h"
/**
 推荐
 */
@interface SDRecommendViewController ()
@property (nonatomic,strong)  SDHomeBtnView *homeBtnView;
@end

@implementation SDRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.homeBtnView];
    // Do any additional setup after loading the view.
}


#pragma mark - lazy
-(SDHomeBtnView *)homeBtnView{
    if(!_homeBtnView){
        _homeBtnView = [[SDHomeBtnView alloc]initWithFrame:self.view.bounds];
        
    }
    return _homeBtnView;
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
