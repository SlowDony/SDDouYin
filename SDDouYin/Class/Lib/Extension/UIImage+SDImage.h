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
+ (UIImage *)imageWithRoundCorner:(UIImage *)sourceImage
                     cornerRadius:(CGFloat)cornerRadius
                             size:(CGSize)size;
@end
