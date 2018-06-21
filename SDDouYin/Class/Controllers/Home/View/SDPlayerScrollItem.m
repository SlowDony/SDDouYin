//
//  SDPlayerScrollItem.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/21.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDPlayerScrollItem.h"

@implementation SDPlayerScrollItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    //顶部图片
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.bgImageView = topImageView;
    [self addSubview:topImageView];
    
    KSYMoviePlayerController *videoPlayer = [[KSYMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"http://v1-hs.ixigua.com/1e821625ec5523773686c449efbeeb21/5b1e4bfe/video/m/220ba53aef558c947c1b6e2d03064b0228911514d450000684f1976db7f/"]];
    videoPlayer.view.backgroundColor = [UIColor clearColor];
    [videoPlayer setBufferSizeMax:1];
    videoPlayer.view.autoresizesSubviews = YES;
    [videoPlayer.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    videoPlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    videoPlayer.shouldAutoplay = YES;
    videoPlayer.scalingMode = MPMovieScalingModeAspectFit;
    [self addSubview:videoPlayer.view];
    self.videoPlayer = videoPlayer;
    
    /** 按钮view */
    SDHomeBtnView *homeBtnView = [[SDHomeBtnView alloc] init];
    homeBtnView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    homeBtnView.backgroundColor = [UIColor clearColor];
    self.homeBtnView = homeBtnView;
    [self addSubview:homeBtnView];
   
}

@end
