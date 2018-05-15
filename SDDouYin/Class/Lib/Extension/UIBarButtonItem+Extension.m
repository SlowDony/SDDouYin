//
//  UIBarButtonItem+Extension.m
//  DemoPods
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 Dony. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个带图片的item
 *
 *  @param target      点击item后调用的哪个对象方法
 *  @param action      点击item后调用target的那个方法
 *  @param image       图片
 *  @param selectImage 高亮
 *
 *  @return 创建完的item
 */
+(UIBarButtonItem *)itemTarget:(id)target WithAction:(SEL)action andImage:(NSString *)image andSelectImage:(NSString *)selectImage{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 1, 0, 20)];
    [btn  addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

/**
 *  创建带文字的item
 *
 *  @param target 点击item后调用的哪个对象的方法
 *  @param action 点击item后调用target的哪个方法
 *  @param title  文字
 *
 *  @return 创建完的item
 */
+(UIBarButtonItem *)itemWithaddTarget:(id)target Action:(SEL)action andTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithWhite:0.7 alpha:0.7] forState:UIControlStateHighlighted];
    [btn  addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
