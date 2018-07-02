//
//  SDMusic.h
//  SDDouYin
//
//  Created by slowdony on 2018/7/2.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDObject.h"
#import "SDAvatarLarger.h"
@interface SDMusic : SDObject

@property (nonatomic, strong) SDAvatarLarger * audioTrack;
@property (nonatomic, strong) NSString * author;
@property (nonatomic, assign) BOOL authorDeleted;
@property (nonatomic, strong) SDAvatarLarger * coverHd;
@property (nonatomic, strong) SDAvatarLarger * coverLarge;
@property (nonatomic, strong) SDAvatarLarger * coverMedium;
@property (nonatomic, strong) SDAvatarLarger * coverThumb;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) SDAvatarLarger * effectsData;
@property (nonatomic, strong) NSString * extra;
@property (nonatomic, assign) double idField;
@property (nonatomic, strong) NSString * idStr;
@property (nonatomic, assign) BOOL isDelVideo;
@property (nonatomic, assign) BOOL isOriginal;
@property (nonatomic, assign) BOOL isRestricted;
@property (nonatomic, assign) BOOL isVideoSelfSee;
@property (nonatomic, strong) NSString * mid;
@property (nonatomic, strong) NSString * offlineDesc;
@property (nonatomic, strong) NSString * ownerHandle;
@property (nonatomic, strong) NSString * ownerId;
@property (nonatomic, strong) NSString * ownerNickname;
@property (nonatomic, strong) SDAvatarLarger * playUrl;
@property (nonatomic, assign) BOOL redirect;
@property (nonatomic, strong) NSString * schemaUrl;
@property (nonatomic, assign) NSInteger sourcePlatform;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger userCount;
@end
