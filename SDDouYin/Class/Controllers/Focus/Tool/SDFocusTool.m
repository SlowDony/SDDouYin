//
//  SDFocusTool.m
//  
//
//  Created by slowdony on 2018/7/13.
//

#import "SDFocusTool.h"

@implementation SDFocusTool

+ (void)getFollowFeedSuccess:(SuccessBlock)success failed:(FailedBlock )failed{
    
    NSDictionary * json = [SDFocusTool getJsonFile:@"SDFollowFeed"];
    if ([json[@"status_code"] integerValue]==0){
        SDFollowFeedModel *feedmodel = [SDFollowFeedModel mj_objectWithKeyValues:json];
        success(feedmodel.data);
    }else{
        failed(@"错误");
    }
    
}
@end
