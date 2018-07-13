//
//  SDFollowFeedModel.h
//  SDDouYin
//
//  Created by slowdony on 2018/7/13.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseModel.h"
#import "SDObject.h"
#import "SDAweme.h"
#import "SDUser.h"
#import "SDComment.h"


@interface SDData : SDObject

@property (nonatomic, strong) SDAweme * aweme;
@property (nonatomic, strong) NSArray <SDComment *>* commentList;
@property (nonatomic, assign) NSInteger feedType; //1正常好友 2推荐好友
@property (nonatomic, strong) NSArray <SDUser *>* user;
@end

@interface SDLogPb : SDObject

@property (nonatomic, strong) NSString * imprId;
@end

@interface SDFollowFeedModel : SDBaseModel

@property (nonatomic, strong) NSArray <SDData *>* data;

@property (nonatomic, assign) NSInteger fetchRecommend;

@property (nonatomic, strong) SDLogPb * logPb;

@property (nonatomic, strong) NSString * rid;

@property (nonatomic, strong) NSString * statusMsg;

@end
