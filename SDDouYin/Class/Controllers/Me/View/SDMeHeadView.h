//
//  SDMeHeadView.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDUser.h"

#pragma mark - SDMeHeadBottomView
///获赞,粉丝,关注view
@interface SDMeHeadBottomView :UIView

/**
 设置按钮数量
 
 @param count 数量
 @param tag 100 获赞 ,101 粉丝数  102 关注数
 */
- (void)setBtnValue:(NSInteger )count withTag:(NSInteger )tag;

@property (nonatomic,copy) void (^btnClickBlock)(UIButton *sender);


@end
#pragma mark - SDMeHeadTagsView
///年龄星座地址
@interface SDMeHeadTagsView :UIView

@property (nonatomic,strong) NSMutableArray *titleArr;

@end

#pragma mark - SDMeHeadView

@class  SDMeHeadTopView,SDMeHeadView;
@protocol  SDMeHeadViewDelegate<NSObject>

///头像点击
- (void)sdMeHeadViewHeadBtnClick;

/**
 自己为邀请好友.钱包.设置  别人 是否关注,是否添加好友,举报
 
 @param headView headView
 @param sender tag ==1000(...) tag ==2000.(聊天,钱包.加好友) tag ==3000 (添加关注,已关注,邀请好友,)
 */
- (void)sdMeHeadView:(SDMeHeadView *)headView topViewBtnClick:(UIButton *)sender;

/**
 获赞,粉丝,关注点击
 
 @param headView headView
 @param sender tag==100 获赞 ,101 粉丝数  102 关注数
 */
- (void)sdMeHeadView:(SDMeHeadView *)headView bottomViewBtnClick:(UIButton *)sender;

@end

@interface SDMeHeadView : UIView
typedef NS_ENUM(NSInteger,HeadViewType){
    HeadViewTypeMe, //我的
    HeadViewTypeOther //别人
};

///头部view类型
@property (nonatomic,assign) HeadViewType headViewType;

@property (nonatomic,strong) SDMeHeadTagsView *tagsView;
@property (nonatomic,strong) SDMeHeadBottomView *bottomView;
@property (nonatomic,strong) SDMeHeadTopView *topView;
@property (nonatomic,strong) UILabel *signatureLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,weak) id<SDMeHeadViewDelegate>headViewDelegate; //


- (void)setHeadValueModel:(SDUser *)user;
@end
