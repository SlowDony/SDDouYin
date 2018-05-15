//
//  SDHelper.m
//  miaohu
//
//  Created by Megatron Joker on 2017/3/3.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDHelper.h"
#import <AudioToolbox/AudioToolbox.h>
#import <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreText/CoreText.h>
@implementation SDHelper
#pragma mark - 裁切textFeild的字符到指定长度
//一个汉字计算两个字符长度
+ (void)cutStrWithTextInput:(id)textInput length:(int)length
{
    NSString *text = @"";
    if ([textInput isKindOfClass:[UITextField class]] || [textInput isKindOfClass:[UITextView class]])
    {
        //如果有高亮状态 返回不计算
        UITextRange *selectedRange = [textInput markedTextRange];
        if (selectedRange) return;
        
        //赋值文字
        text = [textInput text];
    }
    else if ([textInput isKindOfClass:[UISearchBar class]])
    {
        //赋值文字
        text = [textInput text];
    }
    
    if (text.length == 0)
    {
        return;
    }
    
    //裁切
    if ([SDHelper getBoolToString:text length:length])
    {
        //[EPProgressHUD showErrorWithStatus:@"您输入的内容已超过设定值"];
        text =  [text substringWithRange:NSMakeRange(0,[SDHelper getChineseToString:text length:length])];
        if ([textInput isKindOfClass:[UITextField class]] )
        {
            ((UITextField *)textInput).text = text;
        }
        else if ([textInput isKindOfClass:[UITextView class]])
        {
            ((UITextView *)textInput).text = text;
        }
        else if ([textInput isKindOfClass:[UISearchBar class]])
        {
            //赋值文字
            ((UISearchBar *)textInput).text = text;
        }
    }
}

// 得到字符串的长度
+(int)getChineseToString:(NSString *)strtemp length:(int)length{
    int strLength = 0;
    
    for(int i=0; i< [strtemp length];i++){
        int a = [strtemp characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fff){
            length-= 2;
        }else{
            length--;
        }
        if (length < 0) {
            return  strLength;
        }
        strLength++;
    }
    return strLength;
}

// 是否超出限制
+(BOOL)getBoolToString:(NSString *)strtemp length:(int)length{
    for(int i=0; i< [strtemp length];i++){
        int a = [strtemp characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fff){
            length-= 2;
        }else{
            length--;
        }
        if (length <= 0) {
            return YES;
        }
    }
    return NO;
}

-(int)text:(NSString *)text{
    int longName = 0;
    for(int i=0; i< [text length];i++){
        int a = [text characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fff){
            
            longName+= 2;
            DLog(@"汉字");
        }else{
            longName++;
            DLog(@"字母");
        }
    }
    return longName;
}

//检查邮箱合法
+(BOOL)checkEmailFormat:(NSString *)aEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:aEmail];
}

//手机号验证
+(BOOL)checkTel:(NSString *)str

{
    //1[0-9]{10}
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    //    NSString *regex = @"[0-9]{11}";
    NSString *regex = @"^((13[0-9])|(14[0-9])|(17[0,6,7,8])|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

#pragma mark - 获取中英文混合长度
+ (int)getChineseToInt:(NSString*)strtemp {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return (int)[da length];
}

+ (NSURL *)utf8URLWithStr:(NSString *)urlStr
{
    NSString *utf8Str =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:utf8Str];
    if (url) {
        return url;
    }
    return nil;
}
#pragma mark - 获取设备静音状态
+ (BOOL)isSilenced
{
//    CFStringRef state = nil;
//    UInt32 propertySize = sizeof(CFStringRef);
//    AudioSessionInitialize(NULL, NULL, NULL, NULL);
//    OSStatus status = AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &propertySize, &state);
//    if (status == kAudioSessionNoError)
//    {
//        return (CFStringGetLength(state) == 0);   // YES = silent
//    }
    return NO;
}


#pragma mark - 弱密码验证
//顺序密码验证
+ (BOOL)isOrderPWD:(NSString *)aPWD
{
    //判断递增
    BOOL isOrder = YES;
    
    if (!aPWD || aPWD.length == 0)
    {
        return isOrder;
    }
    
    int pt = [aPWD characterAtIndex:0];
    
    for (int i = 1; i < aPWD.length; i++)
    {
        unichar tep = [aPWD characterAtIndex:i];
        //上一位+1 与本位相比 相等,为顺序
        if ( ++ pt  != (int)tep )
        {
            isOrder = NO;
            break;
        }
    }
    
    if (!isOrder)
    {
        //如果不是递增顺序 重置顺序标签
        isOrder = YES;
        int pt = [aPWD characterAtIndex:0];
        //判断递减
        //上一位-1 与本位相比 相等,为顺序
        for (int i = 1; i < aPWD.length; i++)
        {
            unichar tep = [aPWD characterAtIndex:i];
            if ( -- pt  != (int)tep  )
            {
                isOrder = NO;
                break;
            }
        }
    }
    
    return isOrder;
}


//相同字符判断
+ (BOOL)isSamePWD:(NSString *)aPWD
{
    BOOL isSame = YES;
    if (!aPWD || aPWD.length == 0)
    {
        return isSame;
    }
    
    unichar pt = [aPWD characterAtIndex:0];
    for (int i =1 ;i<(int)aPWD.length;i++)
    {
        unichar _char = [aPWD characterAtIndex:i];
        if ( pt  != _char )
        {
            isSame = NO;
            break;
        }
        //DLog(@"%c",_char);
    }
    return isSame;
}
+ (NSString *)getRandomStr
{
    //+1,result is [from to]; else is [from, to)!!!!!!!
    NSDate *date = [NSDate date];
    int from = 0;
    int to = [date timeIntervalSinceReferenceDate] ;
    NSString *str = [NSString stringWithFormat:@"iOS_%d",(int)(from + (arc4random() % (to - from + 1)))];
    return  str;
    
}
+ (UIImage *) imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


#pragma mark - 根据文件后缀返回文件类型图片
+ (NSString *)imageNameWithPostfix:(NSString *)aFileNameStr
{
    NSArray *tepArr = [aFileNameStr componentsSeparatedByString:@"."];
    NSString *tepStr = [tepArr lastObject];
    //忽略大小写
    tepStr = [tepStr lowercaseString];
    if (!tepStr||tepStr.length<1) {
        return @"unknown_ico_normal";
    }
    if ([tepStr isEqualToString:@"ipa"]) {
        return @"ipa_ico_normal";
    }else if([tepStr isEqualToString:@"jpg"]){
        return @"jpg_ico_normal";
    }else if([tepStr isEqualToString:@"apk"]){
        return @"apk_ico_normal";
    }else if([tepStr isEqualToString:@"avi"]){
        return @"avi_ico_normal";
    }else if([tepStr isEqualToString:@"html"]){
        return @"html_ico_normal";
    }else if([tepStr isEqualToString:@"mp4"]){
        return @"mp3_ico_normal";
    }else if([tepStr isEqualToString:@"mp4"]){
        return @"mp4_ico_normal";
    }else if([tepStr isEqualToString:@"doc"]||[tepStr isEqualToString:@"docx"]){
        return @"doc_ico_normal";
    }else if([tepStr isEqualToString:@"pdf"]){
        return @"pdf_ico_normal";
    }else if([tepStr isEqualToString:@"ppt"]||[tepStr isEqualToString:@"pptx"]){
        return @"ppt_ico_normal";
    }else if([tepStr isEqualToString:@"xls"]||[tepStr isEqualToString:@"xlsx"]){
        return @"xls_ico_normal";
    }else if([tepStr isEqualToString:@"png"]){
        return @"png_ico_normal";
    }else if([tepStr isEqualToString:@"cad"]){
        return @"cad_ico_normal";
    }else if([tepStr isEqualToString:@"rar"]){
        return @"rar_ico_normal";
    }else if([tepStr isEqualToString:@"zip"]){
        return @"zip_ico_normal";
    }else{
        //([tepStr isEqualToString:@"unkonwn"])
        return @"unknown_ico_normal";
    }
}
//快速返回字符串 长度
+(float)longFloatWithstring:(NSString *)aString
                  andHeight:(float)aHeigt
                    andSize:(float)aSize
{

    NSDictionary *attribute =@{NSFontAttributeName:[UIFont systemFontOfSize:aSize]};
    
    
    CGSize textSiz =[aString boundingRectWithSize:CGSizeMake(MAXFLOAT, aHeigt) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    float textHeight = textSiz.width;
    return textHeight;
}
//快速返回字符串 高度
+(float)hightFloatWithstring:(NSString *)aString
                    andWidth:(float)aWidth
                     andSize:(float)aSize
{
    NSDictionary *attribute =@{NSFontAttributeName:[UIFont systemFontOfSize:aSize]};
    
    CGSize textSiz =[aString boundingRectWithSize:CGSizeMake(aWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    float textWidth = textSiz.height;
    return textWidth;
}


//根据图片名字返回图片
+ (UIImage *)imageWithName:(NSString *)Name
{
    NSString *pathStr = [[NSBundle mainBundle]pathForResource:Name ofType:@"png"];
    UIImage *tep = [[UIImage alloc]initWithContentsOfFile:pathStr];
    return  tep;
}

//label 便利构造器
+(UILabel *)labelBulidWithText:(NSString *)aText
                   andFontSize:(float)aSize
                  andTextColor:(UIColor *)aColor
            andBackgroundColor:(UIColor *)aBColor
                       andFram:(CGRect )aCGrect
                  andAlignment:(NSTextAlignment )aAligment
{
    return [SDHelper labelBulidWithText:aText
                            andFontSize:aSize
                           andTextColor:aColor
                     andBackgroundColor:aBColor
                                andFram:aCGrect
                           andAlignment:aAligment
                        testBorderWidth:NO];
}
//label 便利构造器
+(UILabel *)labelBulidWithText:(NSString *)aText
                   andFontSize:(float)aSize
                  andTextColor:(UIColor *)aColor
            andBackgroundColor:(UIColor *)aBColor
                       andFram:(CGRect )aCGrect
                  andAlignment:(NSTextAlignment )aAligment
               testBorderWidth:(BOOL)isOpen
{
    
    UILabel* tepLabel = [[UILabel alloc]initWithFrame:aCGrect];
    
    //传值
    tepLabel.text = aText;
    tepLabel.font = [UIFont systemFontOfSize:aSize];
    tepLabel.textColor = aColor;
    tepLabel.backgroundColor =aBColor;
    
    //设置默认值
    tepLabel.textAlignment =  aAligment;
    if (aColor == nil) {
        tepLabel.textColor = [UIColor blackColor];
    }
    if (aBColor == nil) {
        tepLabel.backgroundColor = [UIColor clearColor];
    }
    tepLabel.numberOfLines = 1;
    //调试使用边框
    if (isOpen) {
        tepLabel.layer.borderColor = [UIColor redColor].CGColor;
        tepLabel.layer.borderWidth = 0.3;
    }
    return tepLabel;
}

//UIButton 便利构造器
+(UIButton *)buttonBuildWithTitle:(NSString *)aTitle textColor:(UIColor *)atColor tintColor:(UIColor *)aColor
                  backgroundColor:(UIColor *)abColor frome:(CGRect)aRect
{
    return [SDHelper buttonBuildWithTitle:aTitle
                                textColor:atColor
                                tintColor:aColor
                          backgroundColor:abColor
                                    frome:aRect
                          testBorderWidth:NO];
}
//UIButton 便利构造器
+(UIButton *)buttonBuildWithTitle:(NSString *)aTitle textColor:(UIColor *)atColor tintColor:(UIColor *)aColor
                  backgroundColor:(UIColor *)abColor frome:(CGRect)aRect testBorderWidth:(BOOL)isOpen
{
    UIButton *tepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tepButton.frame = aRect;
    if (aTitle) {
        [tepButton setTitle:aTitle forState:UIControlStateNormal];
        [tepButton setTitleColor:(atColor ?atColor:[UIColor blackColor]) forState:UIControlStateNormal];
    }
    tepButton.tintColor       = aColor  ? aColor  : [UIColor clearColor];
    tepButton.backgroundColor = abColor ? abColor : [UIColor clearColor];
    
    //调试使用边框
    if (isOpen) {
        tepButton.layer.borderColor = [UIColor greenColor].CGColor;
        tepButton.layer.borderWidth = 0.3;
    }
    return tepButton;
}






//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

+(UIImage *)rotateImage:(UIImage *)aImage
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    CGFloat scaleRatio = 1;
    
    CGFloat boundHeight;
    
    UIImageOrientation orient = aImage.imageOrientation;
    
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    
    else
    {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
    
}

+ (UIImage *)cropWithImage:(UIImage *)image Rect:(CGRect)rect
{
    CGImageRef imageref = CGImageCreateWithImageInRect(image.CGImage, rect);
    image = [UIImage imageWithCGImage:imageref];
    return image;
}

+ (UIImage *)createScaleCenterImage:(UIImage *)image widthAndHeight:(float)widthAndHeight
{
    float width = image.size.width;
    float height = image.size.height;
    
    // 缩放
    float c = 0;
    if (width > height) {
        c = (width / height) * widthAndHeight;
    } else if (height > width) {
        c = (height / width) * widthAndHeight;
    } else {
        c = widthAndHeight;
    }
    c = ceilf(c);
    
    image = [[self class] transformWithLockedRatio:image width:c height:c rotate:YES];
    
    // 截取中间部分
    width = image.size.width;
    height = image.size.height;
    CGRect rect = CGRectZero;
    if (width != height) {
        if (width > height) {
            rect = CGRectMake((width - height) / 2, 0, height, height);
        } else {
            rect = CGRectMake(0, (height - width) / 2, width, width);
        }
        
        CGImageRef imageref = CGImageCreateWithImageInRect(image.CGImage, rect);
        image = [UIImage imageWithCGImage:imageref];
    }
    
    return image;
}

+ (UIImage*)transformWithLockedRatio:(UIImage *)image width:(CGFloat)width
                              height:(CGFloat)height rotate:(BOOL)rotate
{
    float sourceWidth = image.size.width;
    float sourceHeight = image.size.height;
    
    float widthRatio = width / sourceWidth;
    float heightRatio = height / sourceHeight;
    
    if (widthRatio >= 1 && heightRatio >= 1) {
        return image;
    }
    
    float destWidth, destHeight;
    if (widthRatio > heightRatio) {
        destWidth = sourceWidth * heightRatio;
        destHeight = height;
    } else {
        destWidth = width;
        destHeight = sourceHeight * widthRatio;
    }
    
    return [SDHelper transform:image width:destWidth height:destHeight rotate:rotate];
}


+ (UIImage*)transform:(UIImage *)image width:(CGFloat)width
               height:(CGFloat)height rotate:(BOOL)rotate
{
    CGFloat destW = roundf(width);
    CGFloat destH = roundf(height);
    CGFloat sourceW = roundf(width);
    CGFloat sourceH = roundf(height);
    
    if (rotate) {
        if (image.imageOrientation == UIImageOrientationRight
            || image.imageOrientation == UIImageOrientationLeft) {
            sourceW = height;
            sourceH = width;
        }
    }
    
    CGImageRef imageRef = image.CGImage;
    
    int bytesPerRow = destW * (CGImageGetBitsPerPixel(imageRef) >> 3);
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                bytesPerRow,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    if (rotate) {
        if (image.imageOrientation == UIImageOrientationDown) {
            CGContextTranslateCTM(bitmap, sourceW, sourceH);
            CGContextRotateCTM(bitmap, 180 * (M_PI/180));
            
        } else if (image.imageOrientation == UIImageOrientationLeft) {
            CGContextTranslateCTM(bitmap, sourceH, 0);
            CGContextRotateCTM(bitmap, 90 * (M_PI/180));
            
        } else if (image.imageOrientation == UIImageOrientationRight) {
            CGContextTranslateCTM(bitmap, 0, sourceW);
            CGContextRotateCTM(bitmap, -90 * (M_PI/180));
        }
    }
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
}

+(UIImage *)colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor
{
    UIGraphicsBeginImageContext(CGSizeMake(baseImage.size.width, baseImage.size.height));
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    [theColor set];
    CGContextFillRect(ctx, area);
    CGContextRestoreGState(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    //    CGContextDrawImage(ctx, area, baseImage.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //    newImage = [SRImage transform:newImage width:baseImage.size.width height:baseImage.size.width rotate:NO];
    
    return newImage;
}


+ (UIImage *)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - md5
+ (NSString *) md5WithStr:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark - 相册，相机隐私判断
+ (BOOL) privacyImage:(UIImagePickerControllerSourceType)sourceType{
    BOOL privacy = YES;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        
            
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusDenied)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法使用相机" message:@"请在iPhone的“设置-隐私-相机”中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                privacy = NO;
            }
            
        }
    return privacy;
}

+(NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        [theScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
    return html;
}
/**
 *  行间距
 *
 *  @param spacing 间距大小
 *  @param label   设置的UILabel
 */
+ (void)setLineSpacing:(CGFloat)spacing label:(UILabel *)label
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    [label setAttributedText:attributedString];
    //    [label sizeToFit];
}

/**
 *  生成随机色
 *
 *  @return 随机色
 */
+(UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

/*
 -(NSString *)decodeUnicodeBytes:(char *)stringEncoded {
 unsigned int    unicodeValue;
 char            *p, buff[5];
 NSMutableString *theString;
 NSString        *hexString;
 NSScanner       *pScanner;
 
 theString = [[[NSMutableString alloc] init] autorelease];
 p = stringEncoded;
 
 buff[4] = 0x00;
 while (*p != 0x00) {
 
 if (*p == '\\') {
 p++;
 if (*p == 'u') {
 memmove(buff, ++p, 4);
 
 hexString = [NSString stringWithUTF8String:buff];
 pScanner = [NSScanner scannerWithString: hexString];
 [pScanner scanHexInt: &unicodeValue];
 
 [theString appendFormat:@"%C", unicodeValue];
 p += 4;
 continue;
 }
 }
 
 [theString appendFormat:@"%c", *p];
 p++;
 }
 
 return [NSString stringWithString:theString];
 }
 */


/**
 *  判断字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return yes/no
 */
+ (BOOL) isBlankString:(NSString *)string {
    
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

#pragma mark 判断字典是否为空
+(BOOL)dictIsBlankValue:(NSDictionary*)Dict{
    
    NSMutableDictionary *muDict = [[NSMutableDictionary alloc]initWithDictionary:Dict];
    
    if (muDict.count > 0) {
        return YES;
    }else if((NSNull*)muDict != [NSNull null]){
        
        return YES;
        
    }else{
        
        return NO;
    }
}

#pragma  mark  处理字典中的空值
+(NSDictionary*)DoDictBlankValue:(NSDictionary*)MutDict{
    
    NSMutableDictionary*muDict = [[NSMutableDictionary alloc]initWithDictionary:MutDict];
    
    NSArray*Keys = [muDict allKeys];
    
    for (NSString*key in Keys) {
        
        NSValue*value = muDict[key];
        
        if ((NSNull*)value == [NSNull null]) {
            
            [muDict setValue:@"" forKey:key];
        }
        //        else if(){}
        
        
    }
    
    return muDict;
}

+(int)dateChange:(NSDate *)star endDate:(NSDate *)end
{
    NSTimeInterval startTime = [star timeIntervalSince1970]*1;
    NSTimeInterval endTime = [end timeIntervalSince1970]*1;
    NSTimeInterval value = endTime - startTime;
    //    int second = (int)value %60;//秒
    //    int minute = (int)value /60%60;
    //    int house = (int)value / 3600%24;
    int day = (int)value / (24 * 3600);
    //    NSString *str;
    
    return day;
}

//根据文字和字体，计算文字的特定高度SpecificWidth内的显示高度
+ (CGFloat) initAttributedString:(NSString *)normalString withFont:(CGFloat)fontSize withSpecificWidth:(CGFloat)inWidth
{
    long stringCharacterSpacing = 1.0f;//字间距
    CGFloat stringLinesSpacing = 5 ; //行间距
    
    //    if (IS_IPHONE_4_OR_LESS)
    //    {
    //        DLog(@"4");
    //        stringLinesSpacing = 4.0f ; //行间距
    //
    //    }
    //    else if (IS_IPHONE_5)
    //    {
    //        DLog(@"5");
    //        stringLinesSpacing = 4.0f ; //行间距
    //
    //    }
    //    else if (IS_IPHONE_6)
    //    {
    //        DLog(@"6");
    //        stringLinesSpacing = 1.5f ; //行间距
    //    }
    //    else if (IS_IPHONE_6P)
    //    {
    //        DLog(@"6P");
    //        stringLinesSpacing = 4.0f ; //行间距
    //
    //    }
    //
    if(!normalString){
        return 0.0f;
    }
    
    //去掉空行
    //    NSString *myString = [normalString stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
    
    //创建AttributeString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:normalString];
    
    //设置字体及大小
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, NULL);
    [attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[attributedString length])];
    
    //设置字间距
    //        long number = 1.5f;
    //    long number = self.characterSpacing;
    long number = stringCharacterSpacing;
    
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
    CFRelease(num);
    /*
     if(self.characterSpacing)
     {
     long number = self.characterSpacing;
     CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
     [attributedString addAttribute:(id)kCTKernAttributeName value:(id)num range:NSMakeRange(0,[attributedString length])];
     CFRelease(num);
     }
     */
    
    //设置字体颜色
    //        [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)(self.textColor.CGColor) range:NSMakeRange(0,[attributedString length])];
    [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)([UIColor grayColor].CGColor) range:NSMakeRange(0,[attributedString length])];
    
    //创建文本对齐方式
    CTTextAlignment alignment = kCTLeftTextAlignment;
    /*
     if(self.textAlignment == NSTextAlignmentCenter)
     {
     alignment = kCTCenterTextAlignment;
     }
     if(self.textAlignment == NSTextAlignmentRight)
     {
     alignment = kCTRightTextAlignment;
     }
     if(self.textAlignment == NSTextAlignmentLeft)
     {
     alignment = kCTTextAlignmentLeft;
     }
     */
    //默认左对齐
    alignment = kCTTextAlignmentLeft;
    
    
    CTParagraphStyleSetting alignmentStyle;
    
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    
    alignmentStyle.valueSize = sizeof(alignment);
    
    alignmentStyle.value = &alignment;
    
    //设置文本行间距
    
    CGFloat lineSpace = stringLinesSpacing;
    
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    lineSpaceStyle.value =&lineSpace;
    
    //设置文本段间距
    CGFloat paragraphSpacing = 15.0;
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(CGFloat);
    paragraphSpaceStyle.value = &paragraphSpacing;
    
    //创建设置数组
    CTParagraphStyleSetting settings[ ] ={alignmentStyle,lineSpaceStyle,paragraphSpaceStyle};
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings ,3);
    
    //给文本添加设置
    [attributedString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)style range:NSMakeRange(0 , [attributedString length])];
    CFRelease(helveticaBold);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) attributedString);   //string 为要计算高度的
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,CFRangeMake(0, 0), NULL,CGSizeMake(inWidth, CGFLOAT_MAX), NULL);
    CFRelease(framesetter);
    return suggestedSize.height;
}

+(NSString *)weekWithInt:(int)weekInt
{
    switch (weekInt) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
        default:
            break;
    }
    
    return @"";
}
/**
 使生成二维码变清晰
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
/*
 判断字典里是否有空值null
 */
+(NSDictionary *)setDicDeleteIsNull:(NSDictionary  *)dic{
    
    NSMutableDictionary*muDict = [[NSMutableDictionary alloc]initWithDictionary:dic];
    for (NSString *strValue in [muDict allKeys]) {
        [muDict setValue:[NSString stringWithFormat:@"%@",dic[strValue]] forKey:strValue];
        if ([SDHelper isBlankString:[muDict objectForKey:strValue] ]) {
            
            [muDict setValue:@"" forKey:strValue];
        }
        
        if ([muDict[strValue] isEqualToString:@"<null>"]) {
            
            [muDict setValue:@"" forKey:strValue];
        }
    }
    return muDict;
    
}


/*
 获取本周本月的起始时间和结束时间

 @param unit 时间类型NSCalendarUnitMonth(月份第一天),NSCalendarUnitYear(当前年份第一天)
 @return 字典
 */
+ (NSMutableDictionary *)getMonthBeginAndEndWith:(NSCalendarUnit)unit{
    //结束时间为当前时间
    NSDate* newDate = [NSDate date];
    
    double interval = 0;
    NSDate *beginDate = nil;
//    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    //“某个时间点”所在的“单元”的起始时间，以及起始时间距离“某个时间点”的时差（单位秒）
    BOOL ok = [calendar rangeOfUnit:unit startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    //NSMonthCalendarUnit//NSCalendarUnitWeekOfMonth
    if (ok) {
//        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return nil;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:newDate];
    
    
    
    NSMutableDictionary *dateDic =[[NSMutableDictionary alloc]init];
    [dateDic setValue:beginString forKey:@"startdate"];
    [dateDic setValue:endString forKey:@"enddate"];
    
    return dateDic;
    
}

//另外再加上获取上一周或者下一周的时间
//
//NSDate *date =[NSDate date];
//
//_nextDate = [date dateByAddingTimeInterval:60*60*24*7];
//_preDate = [date dateByAddingTimeInterval:-60*60*24*7];
//
//[self getMonthBeginAndEndWith:_nextDate];
//NSLog(@"%@",_nextDate);
//
//[self getMonthBeginAndEndWith:_preDate];
//
//NSLog(@"%@",_preDate);
+(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
//    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    NSDate *dateB = [dateFormatter dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
//    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}
+(NSMutableAttributedString *)changeColorWithStr:(NSString *)str color:(UIColor *)color range:(NSRange )range
{
    NSMutableAttributedString *attributStr = [[NSMutableAttributedString alloc]initWithString:str];
    //选择范围改变颜色
    [attributStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return attributStr;
}
@end
