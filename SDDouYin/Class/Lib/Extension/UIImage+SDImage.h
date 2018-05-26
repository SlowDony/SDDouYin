//
//  UIImage+SDImage.h
//  DanceBox
//
//  Created by slowdony on 2018/4/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GradientType) {
    GradientFromTopToBottom = 1,            //从上到下
    GradientFromLeftToRight,                //从左到右
    GradientFromLeftTopToRightBottom,       //从左上到右下
    GradientFromLeftBottomToRightTop        //从左下到右上
};

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

/**
 创建渐变色图片
 
 @param imageSize 图片大小
 @param colors 渐变色数组
 @param percents 渐变颜色的占比数组(0-1)和渐变数组个数一致
 @param gradientType 渐变方向类型
 @return 返回图片
 */
+ (UIImage *)sd_createImageWithSize:(CGSize)imageSize gradientColors:(NSArray *)colors percentage:(NSArray *)percents gradientType:(GradientType)gradientType;

@end
