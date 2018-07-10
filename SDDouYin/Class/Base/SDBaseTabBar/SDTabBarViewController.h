//
//  SDTabBarViewController.h
//  SDInKe
//
//  Created by slowdony on 2018/1/24.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDTabBarViewController : UITabBarController
+ (instancetype )shareTabBarVC;

/**
 设置tabbar是否透明
 */
- (void)setTabbarAlpha:(BOOL )isAlpha;
@end
