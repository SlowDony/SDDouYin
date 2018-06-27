//
//  UIViewController+SDTransitionAnimation.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SDTransitionAnimation)

- (void)sd_pushViewController:(UIViewController *)viewController withAnimation:(BOOL)animation;

- (void)sd_presentViewControler:(UIViewController *)viewController withAnimation:(BOOL)animation;


@end
