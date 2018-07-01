//
//  SDUserTool.m
//  SDDouYin
//
//  Created by slowdony on 2018/7/1.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDUserTool.h"
#import "SDHttpTool.h"
#import "SDUserModel.h"

@implementation SDUserTool

+ (void)getUserInfoTaskSuccess:(SuccessBlock )success failed:(FailedBlock )failed{
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"SDUserData" ofType:@"json"];
    NSData *configData = [NSData dataWithContentsOfFile:configPath];
    NSError *error;
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:configData options:NSJSONReadingMutableContainers error:&error];
    if(error){
        DLog(@"json解析失败:%@",error);
    }
    
    if ([responseObject[@"status_code"] integerValue]==0){
        SDUserModel *userModel =   [SDUserModel mj_objectWithKeyValues:responseObject];
        success(userModel.user);
    }else{
        failed(@"错误");
    }
    
    
    
    /* 正常走网络请求
    [SDHttpTool getWithPath:API_HotLive params:nil success:^(id json) {
        if ([json[@"dm_error"] integerValue]!=0) {
            failed(json[@"error_msg"]);
        }else{
            SDUserModel *userModel =   [SDUserModel mj_objectWithKeyValues:json[@"lives"]];
            DLog(@"json:%@",[json mj_JSONString]);
            success(userModel);
        }
        
    } failure:^(NSError *error) {
        failed(error);
    }];
     */
}
@end
