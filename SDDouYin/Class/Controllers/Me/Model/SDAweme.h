//
//  SDAweme.h
//  SDDouYin
//
//  Created by slowdony on 2018/7/2.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDObject.h"
#import "SDAvatarLarger.h"
#import "SDVideo.h"
#import "SDMusic.h"
#import "SDUser.h"

@interface SDStreamUrl : NSObject
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * rtmpPullUrl;
@end

@interface SDRoom : NSObject
@property (nonatomic, strong) NSString * citycode;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) NSInteger userCount;
@end


@interface ShareInfo : SDObject

@property (nonatomic, assign) NSInteger boolPersist;
@property (nonatomic, strong) NSString * goodsRecUrl;
@property (nonatomic, strong) NSString * manageGoodsUrl;
@property (nonatomic, strong) NSString * shareDesc;
@property (nonatomic, strong) NSString * shareQuote;
@property (nonatomic, strong) NSString * shareSignatureDesc;
@property (nonatomic, strong) NSString * shareSignatureUrl;
@property (nonatomic, strong) NSString * shareTitle;
@property (nonatomic, strong) NSString * shareUrl;
@property (nonatomic, strong) NSString * shareWeiboDesc;
@end

@interface SDAddressInfo : NSObject

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * district;
@property (nonatomic, strong) NSString * province;
@property (nonatomic, strong) NSString * simpleAddr;
@end

@interface SDPoiInfo : NSObject

@property (nonatomic, strong) SDAddressInfo * addressInfo;
@property (nonatomic, strong) SDAvatarLarger * coverHd;
@property (nonatomic, strong) SDAvatarLarger * coverLarge;
@property (nonatomic, strong) SDAvatarLarger * coverMedium;
@property (nonatomic, strong) SDAvatarLarger * coverThumb;
@property (nonatomic, strong) NSString * distance;
@property (nonatomic, assign) NSInteger iconType;
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, strong) NSString * poiId;
@property (nonatomic, assign) CGFloat poiLatitude;
@property (nonatomic, assign) CGFloat poiLongitude;
@property (nonatomic, strong) NSString * poiName;
@property (nonatomic, strong) ShareInfo * shareInfo;
@property (nonatomic, strong) NSString * typeCode;
@property (nonatomic, assign) NSInteger userCount;
@end


@interface SDVideoLabels :SDObject
@property (nonatomic, assign) NSInteger labelType;
@property (nonatomic, strong) SDAvatarLarger *labelUrl;
@end

@interface SDTextExtra :SDObject
@property (nonatomic, assign) NSInteger start;
@property (nonatomic, assign) NSInteger end;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * userId;
@end


@interface SDChaList : SDObject
@property (nonatomic, strong) SDUser * author;
@property (nonatomic, strong) NSString * chaName;
@property (nonatomic, strong) NSString * cid;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, assign) NSInteger isChallenge;
@property (nonatomic, assign) BOOL isPgcshow;
@property (nonatomic, strong) NSString * schema;
@property (nonatomic, assign) NSInteger subType;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger userCount;
@end


@interface SDStatu : NSObject
@property (nonatomic, assign) BOOL allowComment;
@property (nonatomic, assign) BOOL allowShare;
@property (nonatomic, assign) BOOL inReviewing;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) BOOL isPrivate;
@property (nonatomic, assign) NSInteger privateStatus;
@property (nonatomic, assign) BOOL withFusionGoods;
@property (nonatomic, assign) BOOL withGoods;
@end

@interface SDStatistic : SDObject

@property (nonatomic, strong) NSString * awemeId;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger diggCount;
@property (nonatomic, assign) NSInteger playCount;
@property (nonatomic, assign) NSInteger shareCount;
@end

@interface SDDescendant : SDObject

@property (nonatomic, strong) NSString * notifyMsg;
@property (nonatomic, strong) NSArray <NSString *>* platforms;
@end


@interface SDRiskInfo : SDObject
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) BOOL riskSink;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL warn;
@end


@interface SDAweme : SDObject
@property (nonatomic, strong) SDUser * author;
@property (nonatomic, assign) NSInteger authorUserId;
@property (nonatomic, strong) NSString * awemeId;
@property (nonatomic, assign) NSInteger awemeType;///0视频.51合拍.101直播
@property (nonatomic, assign) NSInteger bodydanceScore;
@property (nonatomic, strong) NSArray <SDChaList *>* chaList;
@property (nonatomic, assign) BOOL cmtSwt;
@property (nonatomic, assign) BOOL collectStat;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) SDDescendant * descendants;
@property (nonatomic, strong) NSArray * geofencing;
@property (nonatomic, assign) BOOL isAds;
@property (nonatomic, assign) NSInteger isHashTag;
@property (nonatomic, assign) BOOL isPgcshow;
@property (nonatomic, assign) BOOL isRelieve;
@property (nonatomic, assign) NSInteger isTop;
@property (nonatomic, assign) BOOL isVr;
@property (nonatomic, assign) NSInteger itemCommentSettings;
@property (nonatomic, strong) SDAvatarLarger * labelFriend;
@property (nonatomic, strong) SDAvatarLarger * labelPrivate;
@property (nonatomic, strong) SDAvatarLarger * labelTop;
@property (nonatomic, strong) SDMusic * music;
@property (nonatomic, strong) SDPoiInfo * poiInfo;
@property (nonatomic, assign) NSInteger rate;
@property (nonatomic, strong) NSString * region;
@property (nonatomic, strong) SDRiskInfo * riskInfos;
@property (nonatomic, strong) ShareInfo * shareInfo;
@property (nonatomic, strong) SDRoom * room;
@property (nonatomic, strong) SDStreamUrl * streamUrl;
@property (nonatomic, strong) NSString * distance;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * shareUrl;
@property (nonatomic, strong) NSString * sortLabel;
@property (nonatomic, strong) SDStatistic * statistics;
@property (nonatomic, strong) SDStatu * status;
@property (nonatomic, strong) NSArray <SDTextExtra *>* textExtra;
@property (nonatomic, assign) NSInteger userDigged;
@property (nonatomic, strong) SDVideo * video;
@property (nonatomic, strong) NSArray <SDVideoLabels *>* videoLabels;
@property (nonatomic, strong) NSArray * videoText;
@property (nonatomic, assign) NSInteger vrType;
@end
