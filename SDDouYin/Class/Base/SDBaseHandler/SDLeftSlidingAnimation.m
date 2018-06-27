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

/**
 转场时间
 */
@property (nonatomic,assign) NSTimeInterval transitionDuration;
/**
 toViewController
 */
@property (nonatomic,weak)  UIViewController *toViewController;
/**
 fromViewController
 */
@property (nonatomic,weak)  UIViewController *fromViewController;

/**
 容器view
 */
@property (nonatomic,weak)  UIView  *containerView;

@property (nonatomic,strong)  UIImageView  *fromAnimationImageView;

@property (nonatomic,strong)  UIImageView  *toAnimationImageView;

@property (nonatomic,weak) id<UIViewControllerContextTransitioning>transitionContext;

@end
@implementation SDLeftSlidingAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitionDuration = 0.5;
    }
    return self;
}


#pragma mark -
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView = transitionContext.containerView;
    self.transitionContext = transitionContext;
    [self animateTransition];
}

- (void)transitionComplete{
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

- (void)animateTransition{
    UIImage *fromImage = [self.fromViewController.view.window sd_captureCurrentView];
    self.fromAnimationImageView.image = fromImage;
    
    self.fromAnimationImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.containerView addSubview:self.fromAnimationImageView];
    
    CGRect toViewFrame = CGRectMake(SCREEN_WIDTH-21, 0, SCREEN_WIDTH+21, SCREEN_HEIGHT);
    self.toAnimationImageView.frame = toViewFrame;
    self.toViewController.view.frame = CGRectMake(21, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.toAnimationImageView addSubview:self.toViewController.view];
    [self.containerView addSubview:self.toAnimationImageView];
    
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
