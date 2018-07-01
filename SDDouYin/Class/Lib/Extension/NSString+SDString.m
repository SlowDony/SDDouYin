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


/**
 保留几位小数(不四舍五入)

 @param price 原始数
 @param position 小数点几位
 @return 返回值
 */
+(NSString *)sd_notRounding:(float)price afterPoint:(int)position{
    /**
     NSRoundPlain,   // 四舍五入 Round up on a tie
     NSRoundDown,    // 只舍不入 Always down == truncate
     NSRoundUp,      // 只入不舍 Always up
     NSRoundBankers  //  四舍六入, 中间值时, 取最近的,保持保留最后一位为偶数
     */
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];

    NSDecimalNumber * ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}



#pragma mark - 有关计算年龄星座等日期

/**
 根据生日日期返回星座
 
 @param birthday 生日日期(1998-06-26)
 @return 返回星座
 */
+(NSString *)sd_gerAstroWithBirthday:(NSString *)birthday{
    NSString *astroString =  [NSString sd_getAstroWithMonth:[NSString sd_dataTransform:birthday dataFormat:@"M"] day:[NSString sd_dataTransform:birthday dataFormat:@"d"]];
    return astroString;
}

/**
 具体返回月或日
 
 @param dataStr 时间日期(2018-06-26)
 @param dataFormat (月或日的对应日期格式)
 @return 返回值
 */
+ (NSInteger )sd_dataTransform:(NSString *)dataStr dataFormat:(NSString *)dataFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    ///dataStr需要此日期格式对应
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *mydate=[dateFormatter dateFromString:dataStr];
    [dateFormatter setDateFormat:dataFormat];
    NSString * comfromTimeStr = [dateFormatter stringFromDate:mydate];
    return [comfromTimeStr integerValue];
}

/**
 根据日期返回对应星座
 
 @param month 月
 @param day 日
 @return 星座
 */
+(NSString *)sd_getAstroWithMonth:(NSInteger)month day:(NSInteger)day{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (month<1||month>12||day<1||day>31){
        return @"错误日期格式!";
    }
    if(month==2 && day>29)
    {
        return @"错误日期格式!!";
    }else if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return @"错误日期格式!!!";
        }
    }
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    return [result stringByAppendingString:@"座"];
}

/**
 生日返回年龄
 
 @param birthdayStr 生日 (2018-06-26)
 */
+ (NSString *)sd_getAgeWithBirthday:(NSString *)birthdayStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *birthday = [dateFormatter dateFromString:birthdayStr];
    
    //日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger unitFlags = NSCalendarUnitYear;
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:birthday toDate:[NSDate  date] options:0];
    
    return [NSString stringWithFormat:@"%ld岁",[components year]];
}


/**
 判断字符转是否为空

 @param string 字符串
 @return yes 空 no 不空
 */
+ (BOOL)sd_isBlankString:(NSString *)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end
