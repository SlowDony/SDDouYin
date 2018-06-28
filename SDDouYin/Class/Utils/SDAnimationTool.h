//
//  SDAnimationTool.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/28.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDAnimationTool : NSObject

+(instancetype)shareAnimationTool;


/**
 点击屏幕点赞动画

 @param touches 触摸点
 @param event 事件
 */
- (void)showLargeLikeAnimationWithTouch:(NSSet<UITouch *>*)touches withEvent:(UIEvent *)event;


/**
 点击先变大在缩回原来尺寸

 @param view view
 */
- (void)showMakeScaleAnimationWithView:(UIView *)view;

@end
