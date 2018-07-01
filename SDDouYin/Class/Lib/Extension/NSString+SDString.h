//
//  NSString+SDString.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SDString)
/**
 更改字符串部分字体
 
 @param str 字符串
 @param font 需要改的字体
 @param range 需要改的字体的范围
 @return 返回值
 */
+(NSMutableAttributedString *)sd_changeFontWithStr:(NSString *)str font:(UIFont *)font range:(NSRange )range;

/**
 计算字符串宽度
 
 @param fontSize 字体大小
 @param text 文字
 @return 快读
 */
+ (CGFloat)sd_getFloatForTextWithFontSize:(float)fontSize text:(NSString*)text;



/**
 计算字符串宽度
 
 @param font 字体
 @param text 文字
 @return 返回宽度
 */
+ (CGFloat)sd_getFloatForTextWithFont:(UIFont *)font text:(NSString*)text;

/**
 保留几位小数(不四舍五入)
 
 @param price 原始数
 @param position 小数点几位
 @return 返回值
 */
+(NSString *)sd_notRounding:(float)price afterPoint:(int)position;

#pragma mark - 有关计算年龄星座等日期

/**
 根据生日日期返回星座
 
 @param birthday 生日日期(1998-06-26 00:00:00)
 @return 返回星座
 */
+(NSString *)sd_gerAstroWithBirthday:(NSString *)birthday;


/**
 具体返回月或日
 
 @param dataStr 时间日期
 @param dataFormat (月或日的对应日期格式)
 @return 返回值
 */
+ (NSInteger )sd_dataTransform:(NSString *)dataStr dataFormat:(NSString *)dataFormat;


/**
 根据日期返回对应星座
 
 @param month 月
 @param day 日
 @return 星座
 */
+(NSString *)sd_getAstroWithMonth:(NSInteger)month day:(NSInteger)day;

/**
 生日返回年龄
 
 @param birthdayStr 生日
 */
+ (NSString *)sd_getAgeWithBirthday:(NSString *)birthdayStr;

/**
 判断字符转是否为空
 
 @param string 字符串
 @return yes 空 no 不空
 */
+ (BOOL)sd_isBlankString:(NSString *)string;
@end
