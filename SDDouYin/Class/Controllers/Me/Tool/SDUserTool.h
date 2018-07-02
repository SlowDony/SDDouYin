//
//  SDUserTool.h
//  SDDouYin
//
//  Created by slowdony on 2018/7/1.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDBaseHandler.h"
///网络请求
@interface SDUserTool : SDBaseHandler

/**
 获取个人信息

 @param success 成功
 @param failed 失败
 */
+ (void)getUserInfoTaskSuccess:(SuccessBlock )success failed:(FailedBlock )failed;

/**
 获取个人作品
 
 @param success 成功
 @param failed 失败
 */
+ (void)getAwemeListTaskSuccess:(SuccessBlock )success failed:(FailedBlock )failed;

@end
