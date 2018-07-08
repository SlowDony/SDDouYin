//
//  SDAwemeNearbyFeedModel.m
//  SDDouYin
//
//  Created by slowdony on 2018/7/8.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDAwemeNearbyFeedModel.h"
@implementation SDCurrentCity
@end
@implementation SDAwemeNearbyFeedModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"awemeList":[SDAweme class]};
}
@end
