//
//  SDBaseViewController.m
//  yimaoNetWork
//
//  Created by Megatron Joker on 2017/3/2.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDBaseViewController.h"


@interface SDBaseViewController () 

@end

@implementation SDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

@end
