//
//  UIView+SDView.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SDView)

/**
 屏幕截图

 @return 屏幕截图
 */
- (UIImage *)sd_captureCurrentView;
@end
