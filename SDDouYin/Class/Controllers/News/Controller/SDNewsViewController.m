//
//  SDNewsViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/15.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDNewsViewController.h"
#import "SDNewsHeadView.h"
#import "SDNewsTableView.h"
@interface SDNewsViewController ()
///头部
@property (nonatomic,strong)  SDNewsHeadView  *headView;
@property (nonatomic,strong)  SDNewsTableView *tableView;
@end

@implementation SDNewsViewController

#pragma mark - layz
-(SDNewsTableView *)tableView{
    if (!_tableView){
        //
        _tableView = [[SDNewsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationStatusBarHeight) style:UITableViewStylePlain];
        _tableView.tableHeaderView = self.headView;
        
    }
    return _tableView;
}

-(SDNewsHeadView *)headView{
    if (!_headView){
        _headView = [[SDNewsHeadView alloc]initWithFrame:CGRectMake(0, kNavigationStatusBarHeight, SCREEN_WIDTH, 100)];
        _headView.backgroundColor = KNavigationBarBackgroundColor;
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitle:@"消息"];
    [self rightButtonWithImage:[UIImage imageNamed:@"icNoticeAdd"] action:@selector(rightBtnClick:) onTarget:self];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - clicks
- (void)rightBtnClick:(UIButton *)sender
{
    DLog(@"");
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
