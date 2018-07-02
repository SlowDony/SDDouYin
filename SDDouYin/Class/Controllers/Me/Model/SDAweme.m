//
//  SDAweme.m
//  SDDouYin
//
//  Created by slowdony on 2018/7/2.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDAweme.h"

@implementation SDVideoLabels

@end
@implementation SDTextExtra

@end

@implementation SDChaList

@end
@implementation SDStatu

@end

@implementation SDStatistic

@end


@implementation ShareInfo

@end
@implementation SDDescendant
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"platforms":[NSString class]};
}
@end

@implementation SDRiskInfo

@end

@implementation SDAweme

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"chaList":[SDChaList class],
             @"textExtra":[SDTextExtra class],
             @"videoLabels":[SDVideoLabels class]
             };
}
@end
