//
//  SDUser.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDObject.h"
#import "SDAvatarLarger.h"
#pragma mark - SDFollowersDetail
@interface SDFollowersDetail : SDObject
@property (nonatomic, copy) NSString * appName;
@property (nonatomic, copy) NSString * appleId;
@property (nonatomic, copy) NSString * downloadUrl;
@property (nonatomic, assign) NSInteger fansCount;
@property (nonatomic, copy) NSString  * icon;
@property (nonatomic, copy) NSString  * name;
@property (nonatomic, copy) NSString  * openUrl;
@property (nonatomic, copy) NSString  * packageName;
@end

#pragma mark - SDPlatformSyncInfo
@interface SDPlatformSyncInfo : SDObject
@property (nonatomic, copy) NSString  * nickname;
@property (nonatomic, copy) NSString  * platformName;
@end

#pragma mark - SDVideoIcon
@interface SDVideoIcon : SDObject
@property (nonatomic, copy) NSString  * uri;
@end

#pragma mark - SDShareInfo
@interface SDShareInfo : SDObject
@property (nonatomic, assign) NSInteger boolPersist;
@property (nonatomic, copy) NSString  * shareDesc;
@property (nonatomic, strong) SDAvatarLarger * shareImageUrl;
@property (nonatomic, strong) SDAvatarLarger * shareQrcodeUrl;
@property (nonatomic, copy) NSString  * shareTitle;
@property (nonatomic, copy) NSString  * shareUrl;
@property (nonatomic, copy) NSString  * shareWeiboDesc;
@end

#pragma mark - SDOriginalMusician
@interface SDOriginalMusician : SDObject
@property (nonatomic, assign) NSInteger diggCount;
@property (nonatomic, assign) NSInteger musicCount;
@property (nonatomic, assign) NSInteger musicUsedCount;
@end

#pragma mark - SDActivity
@interface SDActivity : SDObject
@property (nonatomic, assign) NSInteger diggCount;
@property (nonatomic, assign) NSInteger useMusicCount;
@end


#pragma mark - SDUser
@interface SDUser :SDObject

@property (nonatomic, assign) BOOL acceptPrivatePolicy;
@property (nonatomic, copy) NSString  * accountRegion;
@property (nonatomic, strong) SDActivity * activity;
@property (nonatomic, assign) NSInteger appleAccount;
@property (nonatomic, assign) NSInteger authorityStatus;
@property (nonatomic, strong) SDAvatarLarger * avatarLarger;
@property (nonatomic, strong) SDAvatarLarger * avatarMedium;
@property (nonatomic, strong) SDAvatarLarger * avatarThumb;
@property (nonatomic, assign) NSInteger awemeCount;
@property (nonatomic, copy) NSString  * bindPhone;
@property (nonatomic, copy) NSString  * birthday;
@property (nonatomic, assign) NSInteger commerceUserLevel;
@property (nonatomic, assign) NSInteger constellation;
@property (nonatomic, copy) NSString  * customVerify;
@property (nonatomic, copy) NSString  * enterpriseVerifyReason;
@property (nonatomic, assign) NSInteger favoritingCount;
@property (nonatomic, assign) NSInteger fbExpireTime;
@property (nonatomic, assign) NSInteger followStatus;
@property (nonatomic, assign) NSInteger followerCount;
@property (nonatomic, strong) NSArray <SDFollowersDetail *> * followersDetail;
@property (nonatomic, assign) NSInteger followingCount;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSString  * googleAccount;
@property (nonatomic, assign) BOOL hasActivityMedal;
@property (nonatomic, assign) BOOL hasEmail;
@property (nonatomic, assign) BOOL hasFacebookToken;
@property (nonatomic, assign) BOOL hasOrders;
@property (nonatomic, assign) BOOL hasTwitterToken;
@property (nonatomic, assign) BOOL hasYoutubeToken;
@property (nonatomic, assign) BOOL hideLocation;
@property (nonatomic, assign) BOOL hideSearch;
@property (nonatomic, copy) NSString  * insId;
@property (nonatomic, assign) BOOL isAdFake;
@property (nonatomic, assign) BOOL isBindedWeibo;
@property (nonatomic, assign) BOOL isBlock;
@property (nonatomic, assign) BOOL isDisciplineMember;
@property (nonatomic, assign) BOOL isGovMediaVip;
@property (nonatomic, assign) BOOL isPhoneBinded;
@property (nonatomic, assign) BOOL isVerified;
@property (nonatomic, assign) NSInteger liveAgreement;
@property (nonatomic, assign) NSInteger liveVerify;
@property (nonatomic, copy) NSString  * location;
@property (nonatomic, assign) NSInteger loginPlatform;
@property (nonatomic, assign) NSInteger mplatformFollowersCount;
@property (nonatomic, assign) NSInteger needRecommend;
@property (nonatomic, copy) NSString  * nickname;
@property (nonatomic, strong) SDOriginalMusician * originalMusician;
@property (nonatomic, strong) NSArray <SDPlatformSyncInfo *> * platformSyncInfo;
@property (nonatomic, assign) BOOL preventDownload;
@property (nonatomic, assign) NSInteger realnameVerifyStatus;
@property (nonatomic, copy) NSString  * region;
@property (nonatomic, assign) NSInteger roomId;
@property (nonatomic, copy) NSString  * schoolName;
@property (nonatomic, copy) NSString  * schoolPoiId;
@property (nonatomic, assign) NSInteger schoolType;
@property (nonatomic, assign) NSInteger secret;
@property (nonatomic, strong) SDShareInfo * shareInfo;
@property (nonatomic, assign) NSInteger shieldCommentNotice;
@property (nonatomic, assign) NSInteger shieldDiggNotice;
@property (nonatomic, assign) NSInteger shieldFollowNotice;
@property (nonatomic, copy) NSString  * shortId;
@property (nonatomic, assign) BOOL showImageBubble;
@property (nonatomic, copy) NSString  * signature;
@property (nonatomic, assign) NSInteger specialLock;
@property (nonatomic, assign) BOOL starUseNewDownload;
@property (nonatomic, assign) NSInteger storyCount;
@property (nonatomic, assign) BOOL storyOpen;
@property (nonatomic, assign) NSInteger syncToToutiao;
@property (nonatomic, assign) NSInteger totalFavorited;
@property (nonatomic, assign) NSInteger twExpireTime;
@property (nonatomic, copy) NSString  * twitterId;
@property (nonatomic, copy) NSString  * twitterName;
@property (nonatomic, copy) NSString  * uid;
@property (nonatomic, copy) NSString  * uniqueId;
@property (nonatomic, assign) NSInteger uniqueIdModifyTime;
@property (nonatomic, assign) BOOL userCanceled;
@property (nonatomic, copy) NSString  * verifyInfo;
@property (nonatomic, strong) SDVideoIcon * videoIcon;
@property (nonatomic, copy) NSString  * weiboName;
@property (nonatomic, copy) NSString  * weiboSchema;
@property (nonatomic, copy) NSString  * weiboUrl;
@property (nonatomic, copy) NSString  * weiboVerify;
@property (nonatomic, assign) BOOL withCommerceEntry;
@property (nonatomic, assign) BOOL withDouEntry;
@property (nonatomic, assign) BOOL withFusionShopEntry;
@property (nonatomic, assign) BOOL withShopEntry;
@property (nonatomic, copy) NSString  * youtubeChannelId;
@property (nonatomic, copy) NSString  * youtubeChannelTitle;
@property (nonatomic, assign) NSInteger youtubeExpireTime;
@end
