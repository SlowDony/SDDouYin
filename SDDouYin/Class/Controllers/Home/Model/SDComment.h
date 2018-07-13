//
//  SDComment.h
//  SDDouYin
//
//  Created by slowdony on 2018/7/13.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseModel.h"
#import "SDUser.h"
@interface SDComment : SDObject
@property (nonatomic, strong) NSString * awemeId;
@property (nonatomic, strong) NSString * cid;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, assign) NSInteger diggCount;
@property (nonatomic, strong) NSArray <SDComment *>* replyComment;
@property (nonatomic, strong) NSString * replyId;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) SDUser * user;
@property (nonatomic, assign) NSInteger userDigged;
@end

