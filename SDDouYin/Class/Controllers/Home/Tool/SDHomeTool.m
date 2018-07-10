//
//  SDHomeTool.m
//  SDDouYin
//
//  Created by slowdony on 2018/7/8.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDHomeTool.h"
#import "SDHttpTool.h"

@implementation SDHomeTool

+ (void)getAwemeFeedTaskSuccess:(SuccessBlock )success failed:(FailedBlock )failed{
    //模拟真实数据
    NSDictionary * json = [SDHomeTool getJsonFile:@"SDAwemeFeed"];
    if ([json[@"status_code"] integerValue]==0){
        SDAwemeFeedModel *feedmodel = [SDAwemeFeedModel mj_objectWithKeyValues:json];
        success(feedmodel);
    }else{
        failed(@"错误");
    }
    
/* 获取网络数据
    NSDictionary *params = @{
        @"iid":@(37483797410),
        @"device_id":@(35180927264),
        @"os_api":@(18),
        @"app_name":@"aweme",
        @"channel":@"App Store",
        @"idfa":@"9D2547A0-9D80-4553-93C8-458D0E3CF88D",
        @"device_platform":@"iphone",
        @"build_number":@(19007),
        @"vid":@"74B893A2-D97B-40F6-84F4-1980B36A7C74",
    @"openudid":@"a4877114c461677d0242390a046038dca154415b",
        @"device_type":@"iPhone9,1",
        @"app_version":@"1.9.0",
        @"version_code":@"1.9.0",
        @"os_version":@"11.2",
        @"screen_width":@(750),
        @"aid":@(1128),
        @"ac":@"WIFI",
        @"count":@(6),
        @"feed_style":@(0),
        @"filter_warn":@(0),
        @"max_cursor":@(0),
        @"min_cursor":@(0),
        @"pull_type":@(0),
        @"type":@(0),
        @"volume":@"0.79",
   //下面三个会变 @"mas":@"00552b44c02a03fa9dd1fdc7d6553d57019d034e1b09098b234cf8",
        @"as":@"a155aeb400cabb88012741",
        @"ts":@"1531046048",
        };
    
    [SDHttpTool getWithPath:@"aweme/v1/feed/?" params:params success:^(id json) {
        if ([json[@"status_code"] integerValue]==0){
            SDAwemeFeedModel *feedmodel = [SDAwemeFeedModel mj_objectWithKeyValues:json];
            success(feedmodel);
        }else{
            failed(@"请求错误");
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
*/
}
/**
 获取附近的人
 
 @param success 成功
 @param failed 失败
 */
+ (void)getAwemeNearbyFeedTaskSuccess:(SuccessBlock )success failed:(FailedBlock )failed{
    
    ///模拟真实数据
    NSDictionary * json = [SDHomeTool getJsonFile:@"SDAwemeNearbyFeed"];
    if ([json[@"status_code"] integerValue]==0){
        SDAwemeFeedModel *feedmodel = [SDAwemeFeedModel mj_objectWithKeyValues:json];
        success(feedmodel);
    }else{
        failed(@"错误");
    }
    /* 真实网络请求
    NSDictionary *params = @{
        @"iid":@(37483797410),
        @"device_id":@(35180927264),
        @"os_api":@(18),
        @"app_name":@"aweme",
        @"channel":@"App Store",
        @"idfa":@"9D2547A0-9D80-4553-93C8-458D0E3CF88D",
        @"device_platform":@"iphone",
        @"build_number":@(19007),
        @"vid":@"74B893A2-D97B-40F6-84F4-1980B36A7C74",
    @"openudid":@"a4877114c461677d0242390a046038dca154415b",
        @"device_type":@"iPhone9,1",
        @"app_version":@"1.9.0",
        @"version_code":@"1.9.0",
        @"os_version":@"11.2",
        @"screen_width":@(750),
        @"aid":@(1128),
        @"ac":@"WIFI",
        @"count":@(6),
        @"feed_style":@(0),
        @"filter_warn":@(0),
        @"max_cursor":@(0),
        @"min_cursor":@(0),
        @"pull_type":@(0),
        @"type":@(0),
        @"volume":@"0.79",
    @"mas":@"00552b44c02a03fa9dd1fdc7d6553d57019d034e1b09098b234cf8",
        @"as":@"a155aeb400cabb88012741",
        @"ts":@"1531046048",
        };
    
    [SDHttpTool getWithPath:@"aweme/v1/nearby/feed/?" params:params success:^(id json) {
        if ([json[@"status_code"] integerValue]==0){
            SDAwemeNearbyFeedModel *nearnyFeed = [SDAwemeNearbyFeedModel mj_objectWithKeyValues:json];
            success(nearnyFeed);
        }else{
            failed(@"请求错误");
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
     */
}

/**
 获取当前时间
 
 @param success 成功
 @param failed 失败
 */
+ (void)getAwemeAppLogTaskSuccess:(SuccessBlock )success failed:(FailedBlock )failed{
    
    NSDictionary *params = @{
     @"iid":@(37483797410),
     @"device_id":@(35180927264),
     @"os_api":@(18),
     @"app_name":@"aweme",
     @"channel":@"App Store",
     @"idfa":@"9D2547A0-9D80-4553-93C8-458D0E3CF88D",
     @"device_platform":@"iphone",
     @"build_number":@(19007),
     @"vid":@"74B893A2-D97B-40F6-84F4-1980B36A7C74",
 @"openudid":@"a4877114c461677d0242390a046038dca154415b",
     @"device_type":@"iPhone9,1",
     @"app_version":@"1.9.0",
     @"version_code":@"1.9.0",
     @"os_version":@"11.2",
     @"screen_width":@(750),
     @"aid":@(1128),
     @"ac":@"WIFI",
     @"count":@(6),
     @"feed_style":@(0),
     @"filter_warn":@(0),
     @"max_cursor":@(0),
     @"min_cursor":@(0),
     @"pull_type":@(0),
     @"type":@(0),
     @"volume":@"0.79",
     };
    [SDHttpTool postWithPath:@"service/2/app_log/?" params:params success:^(id json) {
        DLog(@"json:%@",json);
    } failure:^(NSError *error) {
        
    }];
}
@end
