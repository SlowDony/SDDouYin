//
//  SDUser.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDUser.h"

@implementation SDFollowersDetail

@end
@implementation SDPlatformSyncInfo

@end
@implementation SDVideoIcon

@end
@implementation SDAvatarLarger

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"urlList":[NSString class]};
}

@end
@implementation SDShareInfo

@end
@implementation SDOriginalMusician

@end
@implementation SDActivity

@end
@implementation SDUser

+(NSDictionary *)mj_objectClassInArray{
    return @{@"followersDetail"  :[SDFollowersDetail class],
             @"platformSyncInfo" :[SDPlatformSyncInfo class]
             };
}
@end
