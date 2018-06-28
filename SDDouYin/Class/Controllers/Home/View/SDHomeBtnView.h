//
//  SDHomeBtnView.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/8.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDHomeBtnItem.h"
@class SDHomeMusicView,SDShortVideoModel;
@interface SDHomeBtnView : UIView

@property (nonatomic,strong) SDHomeMusicView *musicView;
@property (nonatomic,strong) SDHomeBtnItem *shareItem;
@property (nonatomic,strong) SDHomeBtnItem *commentItem;
@property (nonatomic,strong) SDHomeBtnItem *likeItem;
@property (nonatomic,strong) SDHomeBtnItem *headItem;
@property (nonatomic,strong) UIImageView *playImageView;

- (void)setValueWithModel:(SDShortVideoModel *)shortVideoModel;
@end
