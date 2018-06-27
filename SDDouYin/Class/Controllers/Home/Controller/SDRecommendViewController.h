//
//  SDRecommendViewController.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/15.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseLeftSlidingViewController.h"

///推荐
@class SDPlayerScrollView;
@interface SDRecommendViewController :SDBaseLeftSlidingViewController
@property (nonatomic,strong)  SDPlayerScrollView *playerScrollView;

- (void)videoPlay;
- (void)videoPause;

- (void)removeNotification;
- (void)addNotification;
@end

