//
//  BaseViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/15.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "BaseViewController.h"
#import "SDBaseNavigationController.h"
@interface BaseViewController ()
<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KMainBackgroundColor;
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark custom methods

- (void) didTapBackButton:(id)sender {
    if(self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) setupTitleView:(NSString*) title
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(80, 9, 160, 22)];
    [label setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:16.0f]];
    //    [label setMinimumFontSize:20.0f];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.shadowColor = [UIColor colorWithRed:0.0f
                                        green:0.0f
                                         blue:0.0f
                                        alpha:0.4f];
    label.shadowOffset = CGSizeMake(0.0f, 0.9f);
    label.text = title;
    //    label.layer.borderColor = [[UIColor greenColor] CGColor];
    //    label.layer.borderWidth = 2.0f;
    self.navigationItem.titleView = label;
}

- (void) setupSecondTitleView:(NSString*) title
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(80, 9, 160, 22)];
    [label setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:16.0f]];
    //    [label setMinimumFontSize:16.0f];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.shadowColor = [UIColor colorWithRed:0.0f
                                        green:0.0f
                                         blue:0.0f
                                        alpha:0.4f];
    label.shadowOffset = CGSizeMake(0.0f, 0.9f);
    label.text = title;
    //    label.layer.borderColor = [[UIColor greenColor] CGColor];
    //    label.layer.borderWidth = 2.0f;
    self.navigationItem.titleView = label;
    
}

-(void)setupLeftButton:(UIButton *)btn
{
    UIBarButtonItem *sendButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = sendButtonItem;
}


-(void)setupRightButton:(UIButton *)btn
{
    UIBarButtonItem *sendButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = sendButtonItem;
}

- (void )setupTitle:(NSString *)title
{
    SDBaseNavigationController *navc= (SDBaseNavigationController *)self.navigationController;
    [navc setupTitle:title];
}

- (void )setupTitle:(NSString *)title action:(SEL)selector target:(id)target
{
    SDBaseNavigationController *navc= (SDBaseNavigationController *)self.navigationController;
    [navc setupTitle:title action:selector target:target];
}

- (void )setupTitle:(NSString *)title badge:(BOOL) hasBadge
{
    SDBaseNavigationController *navc= (SDBaseNavigationController *)self.navigationController;
    [navc setupTitle:title badge:hasBadge];
}
- (void )rightButtonWithTitle:(NSString *)title action:(SEL) selector onTarget:(id) target
{
    SDBaseNavigationController *navc= (SDBaseNavigationController *)self.navigationController;
    [navc rightButtonWithTitle:title action:selector onTarget:target];
}



- (void )rightButtonWithImage:(UIImage *)image action:(SEL) selector onTarget:(id) target
{
    SDBaseNavigationController *navc= (SDBaseNavigationController *)self.navigationController;
    [navc rightButtonWithImage:image action:selector onTarget:target];
}



- (void )rightButtonWithImage:(UIImage *)image hlImage:(UIImage *) hlImage action:(SEL) selector onTarget:(id) target
{
    SDBaseNavigationController *navc= (SDBaseNavigationController *)self.navigationController;
    [navc rightButtonWithImage:image highlightImage:hlImage size:CGSizeMake(30, 30) action:selector target:target];
}


- (void )leftButtonWithImage:(UIImage *)image action:(SEL) selector onTarget:(id) target
{
    SDBaseNavigationController *navc= (SDBaseNavigationController *)self.navigationController;
    [navc leftButtonWithImage:image action:selector onTarget:target];
}

- (void )leftButtonWithTitle:(NSString *)title action:(SEL) selector onTarget:(id) target
{
    SDBaseNavigationController *navc= (SDBaseNavigationController *)self.navigationController;
    [navc leftButtonWithTitle:title action:selector onTarget:target];
}

- (void )leftButtonWithImage:(UIImage *)image hlImage:(UIImage *) hlImage action:(SEL) selector onTarget:(id) target{
    SDBaseNavigationController *navc= (SDBaseNavigationController *)self.navigationController;
    [navc leftButtonWithImage:image highlightImage:hlImage size:CGSizeMake(24, 24) action:selector target:target];
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
