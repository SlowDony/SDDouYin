//
//  UIImage+SDImage.m
//  DanceBox
//
//  Created by slowdony on 2018/4/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "UIImage+SDImage.h"

@implementation UIImage (SDImage)

/**
 生成圆角图片
 
 @param sourceImage 图片
 @param cornerRadius 圆角
 @param size 尺寸
 @return 图片
 */
+ (UIImage *)sd_imageWithRoundCorner:(UIImage *)sourceImage
                     cornerRadius:(CGFloat)cornerRadius
                             size:(CGSize)size{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGRect bounds = CGRectMake(0, 0, size.width, size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:cornerRadius];
    [path addClip];
    [sourceImage drawInRect:bounds];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/**
 根据颜色生成纯色图片

 @param color 颜色
 @return 图片
 */
+ (UIImage *)sd_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
