//
//  SDMacros.h
//  SDInKe
//
//  Created by slowdony on 2018/1/10.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#ifndef SDMacros_h
#define SDMacros_h
///屏幕宽高
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

///导航栏的高度(不包括状态栏)
#define kNavigationBarHeight 44
///导航栏的高度(包括状态栏)
#define kNavigationStatusBarHeight (SCREEN_HEIGHT == 812 ? 88 : 64)
///底部导航高度
#define kBottomTabbarHeight 49
///屏幕适配
#define kWidth(x) ((x)*(SCREEN_WIDTH)/375.0)
#define kHeight(y) ((y)*(SCREEN_HEIGHT)/667.0)

#define KWeakself __weak typeof(self) weakSelf = self;

///颜色
#define UIColorFromRGB0X(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBAlpha(rgbValue,alpha) [UIColorFromRGB0X(rgbValue) colorWithAlphaComponent:alpha]

///字体
#define SDFont(size) ([UIFont systemFontOfSize:size])
#define SDBoldFont(size) ([UIFont boldSystemFontOfSize:size])
#define SDFontCustomName(name,fontSize) ([UIFont fontWithName:name  size:fontSize])

//log扩展
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

/**
 *  @author slowdony, 16-01-13 15:01:04
 *  这个宏灵感来源于ReactiveCocoa EXTScope.h
 *  使用方法如下,注意前面的@符号 :
 @xWeakify
 [obj block:^{
 @xStrongify
 [self doAnything];
 self.property = something;
 }];
 *  @since v0.1.0
 */
#ifndef    xWeakify
#if __has_feature(objc_arc)
#define xWeakify autoreleasepool{} __weak __typeof__(self) weakRef = self;
#else
#define xWeakify autoreleasepool{} __block __typeof__(self) blockRef = self;
#endif
#endif

#ifndef     xStrongify
#if __has_feature(objc_arc)
#define xStrongify try{} @finally{} __strong __typeof__(weakRef) self = weakRef;
#else
#define xStrongify try{} @finally{} __typeof__(blockRef) self = blockRef;
#endif
#endif

#endif /* SDMacros_h */
