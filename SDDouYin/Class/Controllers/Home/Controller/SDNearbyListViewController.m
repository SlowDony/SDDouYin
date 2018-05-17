//
//  SDNearbyListViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDNearbyListViewController.h"

@interface SDNearbyListViewController ()

@end

@implementation SDNearbyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    
    ///返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"alimember_navbar_left"] forState:UIControlStateNormal];
    [leftBtn  addTarget:self action:@selector(popViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    
    //底部评论框
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = UIColorFromRGBAlpha(0xFFCACACA, 0.3);
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@(45));
    }];
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.backgroundColor = [UIColor clearColor];
    bottomLabel.textColor = UIColorFromRGB0X(0xFFA7A7A7);
    bottomLabel.text = @"说点什么";
    bottomLabel.textAlignment = NSTextAlignmentLeft;
    bottomLabel.font = SDFont(14);
    bottomLabel.numberOfLines = 0;
    [bottomView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(10);
        make.top.equalTo(bottomView.mas_top);
        make.width.equalTo(bottomView.mas_width);
        make.height.equalTo(bottomView.mas_height);
    }];
    
}

- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
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
