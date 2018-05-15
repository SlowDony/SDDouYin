//
//  SDHelper.h
//  miaohu
//
//  Created by Megatron Joker on 2017/3/3.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SDHelper : NSObject
#pragma mark - 裁切textFeild的字符到指定长度
//一个汉字计算两个字符长度
+ (void)cutStrWithTextInput:(id)textInput length:(int)length;

//#pragma mark - url转码
///**
// *  转码 url连接 并 做缩略图处理 针对消息列表显示图片
// *
// *  @param urlStr 需要转码的连接地址
// *
// *  @return 图片的下载地址
// */
//+ (NSURL *)utf8URLAndCutToShowImageWithStr:(NSString *)urlStr;
//
///**
// *  转码 url连接 并 做缩略图处理 针对头像和 作业通知
// *
// *  @param urlStr 需要转码的连接地址
// *
// *  @return 图片的下载地址
// */
//+ (NSURL *)utf8URLAndCutToHeaderWithStr:(NSString *)urlStr;
//
///**
// *  转码 url连接
// *
// *  @param urlStr 需要转码的连接地址
// *
// *  @return 图片的下载地址
// */
//+ (NSURL *)utf8URLWithStr:(NSString *)urlStr;


#pragma mark - 弱密码验证
//顺序密码验证
+ (BOOL)isOrderPWD:(NSString *)aPWD;

//相同字符判断
+ (BOOL)isSamePWD:(NSString *)aPWD;
//获取随机数
+ (NSString *)getRandomStr;
+ (UIImage *) imageWithColor:(UIColor *)color;


//根据后缀返回图片
+ (NSString *)imageNameWithPostfix:(NSString *)aFileNameStr;
//快速返回字符串 长度 宽度
+(float)longFloatWithstring:(NSString *)aString andHeight:(float)aHeigt andSize:(float)aSize;


/**
 

 @param aString 快速返回字符串 高度
 @param aWidth 字符串宽度
 @param aSize  字符串字体大小
 @return 快速返回字符串 高度
 */
+(float)hightFloatWithstring:(NSString *)aString andWidth:(float)aWidth andSize:(float)aSize;


//返回图片
+ (UIImage *)imageWithName:(NSString *)Name;

#pragma mark - 遍历构造器
//label 便利构造器
+(UILabel *)labelBulidWithText:(NSString *)aText andFontSize:(float)aSize andTextColor:(UIColor *)aColor
            andBackgroundColor:(UIColor *)aBColor andFram:(CGRect )aCGrect andAlignment:(NSTextAlignment )aAligment
               testBorderWidth:(BOOL)isOpen;

//UIButton 便利构造器
+(UIButton *)buttonBuildWithTitle:(NSString *)aTitle textColor:(UIColor *)atColor tintColor:(UIColor *)aColor
                  backgroundColor:(UIColor *)abColor frome:(CGRect)aRect testBorderWidth:(BOOL)isOpen;

+(UIImage *)rotateImage:(UIImage *)aImage;

// 裁剪
+ (UIImage *)cropWithImage:(UIImage *)image Rect:(CGRect)rect;

// 锁定比例缩放
+ (UIImage*)transformWithLockedRatio:(UIImage *)image width:(CGFloat)width
                              height:(CGFloat)height rotate:(BOOL)rotate;

// 缩放
+ (UIImage*)transform:(UIImage *)image width:(CGFloat)width height:(CGFloat)height rotate:(BOOL)rotate;

// 获取中心图像的缩略图
+ (UIImage *)createScaleCenterImage:(UIImage *)image widthAndHeight:(float)widthAndHeight;

// 上色
+ (UIImage *)colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor;

+ (NSURL *)utf8URLWithStr:(NSString *)urlStr;

//
+ (UIImage *)createImageWithColor:(UIColor*) color;
#pragma mark - 获取设备静音状态
+ (BOOL)isSilenced;

#pragma mark - md5
+ (NSString *) md5WithStr:(NSString *)str;

#pragma mark - 相册，相机隐私判断
+ (BOOL) privacyImage:(UIImagePickerControllerSourceType)sourceType;

//检查邮箱合法
+(BOOL)checkEmailFormat:(NSString *)aEmail;

//手机号验证
+(BOOL)checkTel:(NSString *)str;

+(NSString *)flattenHTML:(NSString *)html;

//行间距
+(void)setLineSpacing:(CGFloat)spacing label:(UILabel *)label;

//计算2个时间戳间的天数差距
+(int)dateChange:(NSDate *)star endDate:(NSDate *)end;

//生成随机色
+(UIColor *)randomColor;

//判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;

+ (CGFloat) initAttributedString:(NSString *)normalString withFont:(CGFloat)fontSize withSpecificWidth:(CGFloat)inWidth;

+(BOOL)dictIsBlankValue:(NSDictionary*)MuDict;

+(NSDictionary*)DoDictBlankValue:(NSDictionary*)MutDict;

+(NSString *)weekWithInt:(int)weekInt;

//使生成的二维码变清晰
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;
//判断字典里是否有空值null
+(NSDictionary *)setDicDeleteIsNull:(NSDictionary  *)dic;
//
+ (NSMutableDictionary *)getMonthBeginAndEndWith:(NSCalendarUnit)unit;
+(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay;

/**
 改变字符串的部分颜色

 @param str 被改变的字符串
 @param color 改变的颜色
 @param range 改变颜色区域
 @return 已经改变的字符串
 */
+(NSMutableAttributedString *)changeColorWithStr:(NSString *)str color:(UIColor *)color range:(NSRange )range;
@end
