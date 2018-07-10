//
//  SDBaseHandler.m
//  SDInKe
//
//  Created by slowdony on 2018/4/14.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseHandler.h"

@implementation SDBaseHandler

/**
 假装请求网络数据
 
 @param jsonName json
 @return 返回json字典
 */
+ (NSDictionary *)getJsonFile:(NSString *)jsonName{
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"];
    NSData *configData = [NSData dataWithContentsOfFile:configPath];
    NSError *error;
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:configData options:NSJSONReadingMutableContainers error:&error];
    if(error){
        DLog(@"json解析失败:%@",error);
    }
    return responseObject;
}
@end
