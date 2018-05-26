//
//  NSString+SDString.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "NSString+SDString.h"

@implementation NSString (SDString)


/**
 更改字符串部分字体

 @param str 字符串
 @param font 需要改的字体
 @param range 需要改的字体的范围
 @return 返回值
 */
+(NSMutableAttributedString *)sd_changeFontWithStr:(NSString *)str font:(UIFont *)font range:(NSRange )range
{
    NSMutableAttributedString *attributStr = [[NSMutableAttributedString alloc]initWithString:str];
    //选择范围改变颜色
    [attributStr addAttribute:NSFontAttributeName value:font range:range];
    return attributStr;
}


/**
 计算字符串宽度

 @param fontSize 字体大小
 @param text 文字
 @return 快读
 */
+ (CGFloat)sd_getFloatForTextWithFontSize:(float)fontSize text:(NSString*)text
{
    return [NSString sd_getFloatForTextWithFont:SDFont(fontSize) text:text];
}


/**
 计算字符串宽度

 @param font 字体
 @param text 文字
 @return 返回宽度
 */
+ (CGFloat)sd_getFloatForTextWithFont:(UIFont *)font text:(NSString*)text
{
    if (!text.length) {
        text = @"";
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    CGRect frame = [attrStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return frame.size.width;
}

@end
