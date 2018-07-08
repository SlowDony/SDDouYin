//
//  SDAwemeNearbyFeedModel.h
//  SDDouYin
//
//  Created by slowdony on 2018/7/8.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseModel.h"
#import "SDAweme.h"

@interface SDCurrentCity : NSObject

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * en;
@property (nonatomic, strong) NSString * name;
@end


@interface SDAwemeNearbyFeedModel : SDBaseModel
@property (nonatomic, strong) NSArray <SDAweme *>* awemeList;
@property (nonatomic, strong) SDCurrentCity * currentCity;
@end

