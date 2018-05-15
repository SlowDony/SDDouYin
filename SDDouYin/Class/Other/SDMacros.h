//
//  SDMacros.h
//  SDInKe
//
//  Created by slowdony on 2018/1/10.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#ifndef SDMacros_h
#define SDMacros_h
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define Navigation_HEIGHT (SCREEN_HEIGHT==)

///导航栏的高度(不包括状态栏)
#define kNavigationBarHeight 44
///导航栏的高度(包括状态栏)
#define kNavigationStatusBarHeight (SCREEN_HEIGHT == 812 ? 88 : 64)
///底部导航高度
#define kBottomTabbarHeight 49


#define KWeakself __weak typeof(self) weakSelf = self;

//log扩展
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

#endif /* SDMacros_h */
