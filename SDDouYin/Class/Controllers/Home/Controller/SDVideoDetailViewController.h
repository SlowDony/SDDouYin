//
//  SDVideoDetailViewController.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/22.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseLeftSlidingViewController.h"
#import "SDAweme.h"
@interface SDVideoDetailViewController : SDBaseLeftSlidingViewController

///指定视频播放
- (void)updateVideoDetailAweme:(SDAweme *)aweme;

///不循环播放
- (void)updateVideoNotCyclePlayer:(NSMutableArray *)lists currentIndex:(NSInteger )index;


@end
