//
//  SDPlayerScrollView.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/11.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDPlayerScrollView.h"
@interface SDPlayerScrollView()
<UIScrollViewDelegate>

@property (nonatomic,strong)  UIImageView  *topImageView,*middleImageView,*bottomImageView;

@end
@implementation SDPlayerScrollView

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
        self.delegate = self;
        self.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT*3);
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = YES;
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    
    //
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    topImageView.backgroundColor = UIColorFormRandom;
    self.topImageView = topImageView;
    [topImageView sd_setImageWithURL:[NSURL URLWithString:@"http://p1.pstatp.com/large/3ade000cbe377c23e37c.jpg"]];
    [self addSubview:topImageView];
    
    UIImageView *middleImageView = [[UIImageView alloc] init];
    middleImageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    middleImageView.backgroundColor = UIColorFormRandom;
    self.middleImageView = middleImageView;
    [self addSubview:middleImageView];
    
    UIImageView *bottomImageView = [[UIImageView alloc] init];
    bottomImageView.frame = CGRectMake(0, SCREEN_HEIGHT*2, SCREEN_WIDTH, SCREEN_HEIGHT);
    bottomImageView.backgroundColor = UIColorFormRandom;
    self.bottomImageView = bottomImageView;
    [self addSubview:bottomImageView];
    
    KSYMoviePlayerController *topPlayer = [[KSYMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"http://v1-hs.ixigua.com/1e821625ec5523773686c449efbeeb21/5b1e4bfe/video/m/220ba53aef558c947c1b6e2d03064b0228911514d450000684f1976db7f/"]];
    topPlayer.view.backgroundColor = [UIColor clearColor];
    topPlayer.view.tag = 1001;
    [topPlayer setBufferSizeMax:1];
    topPlayer.view.autoresizesSubviews = YES;
    [topPlayer.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    topPlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    topPlayer.shouldAutoplay = YES;
    topPlayer.scalingMode = MPMovieScalingModeAspectFit;
    [self addSubview:topPlayer.view];
    self.topPlayer = topPlayer;
    [topPlayer prepareToPlay];
    
    KSYMoviePlayerController *middlePlayer = [[KSYMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"http://v1-hs.ixigua.com/1e821625ec5523773686c449efbeeb21/5b1e4bfe/video/m/220ba53aef558c947c1b6e2d03064b0228911514d450000684f1976db7f/"]];
    middlePlayer.view.backgroundColor = [UIColor clearColor];
    middlePlayer.view.tag = 1002;
    [middlePlayer setBufferSizeMax:1];
    middlePlayer.view.autoresizesSubviews = YES;
    [middlePlayer.view setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    middlePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    middlePlayer.shouldAutoplay = YES;
    middlePlayer.scalingMode = MPMovieScalingModeAspectFit;
    [self addSubview:middlePlayer.view];
    self.middlePlayer = middlePlayer;
    
    KSYMoviePlayerController *bottomPlayer = [[KSYMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"http://v1-hs.ixigua.com/1e821625ec5523773686c449efbeeb21/5b1e4bfe/video/m/220ba53aef558c947c1b6e2d03064b0228911514d450000684f1976db7f/"]];
    bottomPlayer.view.backgroundColor = [UIColor clearColor];
    bottomPlayer.view.tag = 1003;
    [bottomPlayer setBufferSizeMax:1];
    bottomPlayer.view.autoresizesSubviews = YES;
    [bottomPlayer.view setFrame:CGRectMake(0, SCREEN_HEIGHT*2, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bottomPlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    bottomPlayer.shouldAutoplay = YES;
    bottomPlayer.scalingMode = MPMovieScalingModeAspectFit;
    self.bottomPlayer = bottomPlayer;
    [self addSubview:bottomPlayer.view];
}

                                                                                               
                                                                                               

- (void) prepareForVideo: (KSYMoviePlayerController *)player
{
    [player reset:false];
    [player setUrl:[NSURL URLWithString:@"http://v1-hs.ixigua.com/1e821625ec5523773686c449efbeeb21/5b1e4bfe/video/m/220ba53aef558c947c1b6e2d03064b0228911514d450000684f1976db7f/"]];
    [player setShouldAutoplay:false];
    [player setBufferSizeMax:1];
    [player setShouldLoop:YES];
    player.view.backgroundColor = [UIColor clearColor];
    [player prepareToPlay];
    [player play];
}
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
                                                                                               
@end
