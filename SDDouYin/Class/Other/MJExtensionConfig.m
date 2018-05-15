//
//  MJExtensionConfig.m
//  slowdony
//
//  Created by slowdony on 16/8/22.
//  Copyright © 2016年 slowdony. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "MJExtension.h"



@implementation MJExtensionConfig

+ (void)load {
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
    
//    [SDCreatorModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"desc" : @"desciption"
//                 };
//    }];
//
//    //下滑线
//    [SDLiveModel mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
//        return [propertyName mj_underlineFromCamel];
//    }];
//
//    [SDCreatorModel mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
//        return [propertyName mj_underlineFromCamel];
//    }];
}

@end
