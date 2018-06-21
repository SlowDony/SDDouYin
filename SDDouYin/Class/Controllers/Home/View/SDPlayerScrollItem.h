//
//  SDPlayerScrollItem.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/21.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDHomeBtnView.h"
#import <KSYMediaPlayer/KSYMediaPlayer.h>
@interface SDPlayerScrollItem : UIView
/** 背景view */
@property (nonatomic,strong) UIImageView *bgImageView;
/** 按钮view */
@property (nonatomic,strong) SDHomeBtnView *homeBtnView;
/** 播放器 */
@property (nonatomic,strong) KSYMoviePlayerController *videoPlayer;
@end
