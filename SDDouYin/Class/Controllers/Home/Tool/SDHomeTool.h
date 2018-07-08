//
//  SDHomeTool.h
//  SDDouYin
//
//  Created by slowdony on 2018/7/8.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseHandler.h"
#import "SDAwemeFeedModel.h"
#import "SDAwemeNearbyFeedModel.h"

@interface SDHomeTool : SDBaseHandler


/**
 获取推荐视频

 @param success 成功
 @param failed 失败
 */
+ (void)getAwemeFeedTaskSuccess:(SuccessBlock )success failed:(FailedBlock )failed;

/**
 获取附近的人
 
 @param success 成功
 @param failed 失败
 */
+ (void)getAwemeNearbyFeedTaskSuccess:(SuccessBlock )success failed:(FailedBlock )failed;

/**
 获取当前时间
 
 @param success 成功
 @param failed 失败
 */
+ (void)getAwemeAppLogTaskSuccess:(SuccessBlock )success failed:(FailedBlock )failed;
@end
