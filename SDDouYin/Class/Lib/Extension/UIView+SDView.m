//
//  UIView+SDView.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "UIView+SDView.h"

@implementation UIView (SDView)

/**
 屏幕截图
 
 @return 屏幕截图
 */
- (UIImage *)sd_captureCurrentView{
   UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
