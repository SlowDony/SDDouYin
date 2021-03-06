//
//  MJExtensionConfig.m
//  slowdony
//
//  Created by slowdony on 16/8/22.
//  Copyright © 2016年 slowdony. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "MJExtension.h"
#import "SDObject.h"
#import "SDBaseModel.h"
@implementation MJExtensionConfig

+ (void)load {
    
//    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"ID" : @"id"
//                 };
//    }];
    
    //下滑线转驼峰
    [SDObject mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    [SDBaseModel mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [SDExtra mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    
    
    
}

@end
