//
//  SDPlayerScrollView.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/11.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KSYMediaPlayer/KSYMediaPlayer.h>

@class SDShortVideoModel ,SDPlayerScrollView;

@protocol  SDPlayerScrollViewDelegate<NSObject>
@optional
//头像点击
- (void)playerScrollViewHeadBtnClick:(SDPlayerScrollView *)playerScrollView ;


@end

@interface SDPlayerScrollView : UIScrollView
@property (nonatomic,strong) KSYMoviePlayerController *topPlayer ,*middlePlayer ,*bottomPlayer;
@property (nonatomic,assign)  NSInteger currentIndex , previousIndex;
@property (nonatomic,strong)  UIImageView  *topImageView,*middleImageView,*bottomImageView;
/**
 更新数据

 @param videoDataArrs 数据源
 @param index idnex
 */
- (void)updateCurrentPlayerDatas:(NSMutableArray <SDShortVideoModel *>*)videoDataArrs currentIndex:(NSInteger )index;


@property (nonatomic,weak) id<SDPlayerScrollViewDelegate>playerDelegate;

- (void)playVideo;
- (void)pauseVideo;
- (void)stopVideo;
@end
