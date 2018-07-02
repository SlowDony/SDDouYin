//
//  SDVideo.h
//  SDDouYin
//
//  Created by slowdony on 2018/7/2.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDObject.h"
#import "SDAvatarLarger.h"

@interface SDBitRate : SDObject

@property (nonatomic, assign) NSInteger bitRate;
@property (nonatomic, strong) NSString * gearName;
@property (nonatomic, assign) NSInteger qualityType;
@end

@interface SDVideo : SDObject

@property (nonatomic, strong) NSArray <SDBitRate *>* bitRate;
@property (nonatomic, strong) SDAvatarLarger * cover;
@property (nonatomic, strong) SDAvatarLarger * downloadAddr;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) SDAvatarLarger * dynamicCover;
@property (nonatomic, assign) BOOL hasWatermark;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) SDAvatarLarger * originCover;
@property (nonatomic, strong) SDAvatarLarger * playAddr;
@property (nonatomic, strong) SDAvatarLarger * playAddrLowbr;
@property (nonatomic, strong) NSString * ratio;
@property (nonatomic, assign) NSInteger width;
@end
