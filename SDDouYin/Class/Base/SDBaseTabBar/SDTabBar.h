//
//  SDTabBar.h
//  SDInKe
//
//  Created by slowdony on 2018/1/24.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,TabBarType){
    
    TabBarTypeHome = 100, //首页
    TabBarTypeFocus , //关注
    TabBarTypeNews , //消息
    TabBarTypeMe , //我的
    TabBarTypeAdd , // 上传
};
@class SDTabBar;
@protocol  SDTabBarDelegate<NSObject>

- (void) tabbar:(SDTabBar *)tabbar withBtn:(TabBarType )tabbarType;
@end
@interface SDTabBar : UIView
/**
 背景
 */
@property (nonatomic,strong)  UIImageView *tabBarBJView;
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,weak) id<SDTabBarDelegate>delegate;
@end
