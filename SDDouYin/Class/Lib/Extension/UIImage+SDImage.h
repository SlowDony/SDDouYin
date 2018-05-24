//
//  UIImage+SDImage.h
//  DanceBox
//
//  Created by slowdony on 2018/4/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SDImage)

/**
 生成圆角图片
 
 @param sourceImage 图片
 @param cornerRadius 圆角
 @param size 尺寸
 @return 图片
 */
+ (UIImage *)sd_imageWithRoundCorner:(UIImage *)sourceImage
                     cornerRadius:(CGFloat)cornerRadius
                             size:(CGSize)size;
/**
 根据颜色生成纯色图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)sd_imageWithColor:(UIColor *)color;
@end
