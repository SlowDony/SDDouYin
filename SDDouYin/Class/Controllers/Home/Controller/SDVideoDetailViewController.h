//
//  SDVideoDetailViewController.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/22.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseLeftSlidingViewController.h"

@interface SDVideoDetailViewController : SDBaseLeftSlidingViewController

///循环播放
- (void)updateVideoDetailDatas:(NSMutableArray *)datas currentIndex:(NSInteger )index;

///不循环播放
- (void)updateVideoNotCyclePlayer:(NSMutableArray *)lists currentIndex:(NSInteger )index;
@end
