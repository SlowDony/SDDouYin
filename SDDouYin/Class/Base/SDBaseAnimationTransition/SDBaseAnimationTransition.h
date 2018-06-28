//
//  SDBaseAnimationTransition.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/28.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>

/** UIViewControllerAnimatedTransitioning 转场时间和其他操作 */
NS_ASSUME_NONNULL_BEGIN
@interface SDBaseAnimationTransition : NSObject<UIViewControllerAnimatedTransitioning>
/**
 转场时间
 */
@property (nonatomic,readonly,assign) NSTimeInterval transitionDuration;
/**
 到这个控制器
 */
@property (nonatomic,readonly,weak)  UIViewController * toViewController;
/**
 从这个控制器
 */
@property (nonatomic,readonly,weak)  UIViewController *fromViewController;

/**
 容器view
 */
@property (nonatomic,readonly,weak)  UIView  *containerView;

/**
 完成转场
 */
- (void)transitionComplete;

/**
 过度动画
 */
- (void)animationTransition;

/**
 获取tabbar
 */
- (UITabBar * _Nullable)fetchTabbar;
NS_ASSUME_NONNULL_END
@end
