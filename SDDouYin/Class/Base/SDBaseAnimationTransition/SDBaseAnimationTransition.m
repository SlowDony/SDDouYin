//
//  SDBaseAnimationTransition.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/28.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseAnimationTransition.h"

@interface SDBaseAnimationTransition()

@property (nonatomic,weak) id<UIViewControllerContextTransitioning>transitionContext;

@end
@implementation SDBaseAnimationTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        _transitionDuration = 0.35;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    _toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _containerView = [transitionContext containerView];
    _transitionContext = transitionContext;
    [self animationTransition];
}


#pragma mark - Method
/**
 完成转场
 */
- (void)transitionComplete{
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

/**
 过度动画(子类实现)
 */
- (void)animationTransition{}

/**
 获取tabbar
 */
- (UITabBar * _Nullable)fetchTabbar{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UITabBarController *tabBarVC = [self fetchTabbarVCFormRootViewController:rootVC];
    if (tabBarVC){
        return tabBarVC.tabBar;
    }
    return nil;

}

- (UITabBarController *)fetchTabbarVCFormRootViewController:(UIViewController *)rootVC{
    if ([rootVC isKindOfClass:[UITabBarController class]]){
        return (UITabBarController *)rootVC;
    }else {
        return [self fetchTabbarVCFormRootViewController:rootVC.childViewControllers.firstObject];
    }
}

@end
