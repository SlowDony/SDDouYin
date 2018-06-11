//
//  SDPlayerScrollView.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/11.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KSYMediaPlayer/KSYMediaPlayer.h>
@interface SDPlayerScrollView : UIScrollView
@property (nonatomic,strong)  KSYMoviePlayerController *topPlayer ,*middlePlayer ,*bottomPlayer;

- (void) prepareForVideo: (KSYMoviePlayerController *)player;
@end
