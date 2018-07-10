//
//  SDLeftSlidingAnimation.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDLeftSlidingAnimation.h"
#import <UIKit/UIKit.h>
#import "UIView+SDView.h"
@interface SDLeftSlidingAnimation()

@property (nonatomic,strong)  UIImageView  *fromAnimationImageView;

@property (nonatomic,strong)  UIImageView  *toAnimationImageView;


@end
@implementation SDLeftSlidingAnimation


/**
 过度动画
 */
- (void)animationTransition{
    
    BOOL isHiddenTabbar =  self.toViewController.hidesBottomBarWhenPushed;
    if (isHiddenTabbar){
        [self hiddenTabbarWithAnimateTransition];
    }
    else {
        [self displayTabbarWithAnimateTransition];
    }

}


- (void)hiddenTabbarWithAnimateTransition{
    
    UIImage *fromImage = [self.fromViewController.view.window sd_captureCurrentView];
    self.fromAnimationImageView.image = fromImage;
    
    self.fromAnimationImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.containerView addSubview:self.fromAnimationImageView];
    
    CGRect toViewFrame = CGRectMake(SCREEN_WIDTH-21, 0, SCREEN_WIDTH+21, SCREEN_HEIGHT);
    self.toAnimationImageView.frame = toViewFrame;
    self.toViewController.view.frame = CGRectMake(21, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.toAnimationImageView addSubview:self.toViewController.view];
    [self.containerView addSubview:self.toAnimationImageView];
    
    UITabBar *tabbar = [self fetchTabbar];
    if(tabbar){
      tabbar.hidden = YES;
    }
    
    [UIView animateWithDuration:self.transitionDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect fromFrame = self.fromAnimationImageView.frame;
        fromFrame.origin.x = - 0.3*SCREEN_WIDTH;
        self.fromAnimationImageView.frame = fromFrame;
        
        CGRect toFrame = self.toAnimationImageView.frame;
        toFrame.origin.x = -21;
        self.toAnimationImageView.frame = toFrame;
        
        
    } completion:^(BOOL finished) {
        [self.toViewController.view removeFromSuperview];
        self.toViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.containerView addSubview:self.toViewController.view];
        [self transitionComplete];
        self.fromAnimationImageView.image = nil;
        
        [self.fromAnimationImageView removeFromSuperview];
        [self.toAnimationImageView removeFromSuperview];
        tabbar.hidden = NO;
    }];
}
- (void)displayTabbarWithAnimateTransition{
    
    self.fromViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.containerView addSubview:self.fromViewController.view];
    
    CGRect toViewFrame = CGRectMake(SCREEN_WIDTH-21, 0, SCREEN_WIDTH+21, SCREEN_HEIGHT);
    self.toAnimationImageView.frame = toViewFrame;
    self.toViewController.view.frame = CGRectMake(21, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self.toAnimationImageView addSubview:self.toViewController.view];
    [self.containerView addSubview:self.toAnimationImageView];
    
    [UIView animateWithDuration:self.transitionDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect fromFrame = self.fromViewController.view.frame;
        fromFrame.origin.x = - 0.3*SCREEN_WIDTH;
        self.fromViewController.view.frame = fromFrame;
        
        CGRect toFrame = self.toAnimationImageView.frame;
        toFrame.origin.x = -21;
        self.toAnimationImageView.frame = toFrame;
        
        
    } completion:^(BOOL finished) {
        [self.toViewController.view removeFromSuperview];
        self.toViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.containerView addSubview:self.toViewController.view];
        [self transitionComplete];
        [self.toAnimationImageView removeFromSuperview];
    }];
}

#pragma mark - lazy
- (UIImageView *)toAnimationImageView{
    if(!_toAnimationImageView){
        _toAnimationImageView = [[UIImageView alloc]init];
    }
    return _toAnimationImageView;
}

- (UIImageView *)fromAnimationImageView{
    if(!_fromAnimationImageView){
        _fromAnimationImageView = [[UIImageView alloc]init];
    }
    return _fromAnimationImageView;
}
@end
