//
//  SDFollowFeedModel.m
//  SDDouYin
//
//  Created by slowdony on 2018/7/13.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDFollowFeedModel.h"
@implementation SDData

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"commentList":[SDComment class],
             @"user":[SDUser class]
             };
}

@end
@implementation SDLogPb

@end
@implementation SDFollowFeedModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"data":[SDData class]};
}
@end
