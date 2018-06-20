//
//  SDPlayerScrollView.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/11.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDPlayerScrollView.h"
#import "SDShortVideoModel.h"
#import "SDHomeBtnView.h"
@interface SDPlayerScrollView()
<UIScrollViewDelegate>

//@property (nonatomic,strong)  UIImageView  *topImageView,*middleImageView,*bottomImageView;

@property (nonatomic,strong)  NSMutableArray *dataArrs;
@property (nonatomic,strong)  SDShortVideoModel  *currentVideoModel;
@property (nonatomic,assign)  NSInteger currentIndex , previousIndex;
@property (nonatomic,strong)  SDShortVideoModel  *topVideoModel,*middleVideoModel,*bottomVideoModel;
@property (nonatomic,strong) SDHomeBtnView
    *topBtnView,*middleBtnView,*bottomBtnView;
@end
@implementation SDPlayerScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT*3);
        self.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.bounces = YES;
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    
    //顶部图片
    SDHomeBtnView *topImageView = [[SDHomeBtnView alloc] init];
    topImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    topImageView.backgroundColor = UIColorFormRandom;
    self.topBtnView = topImageView;
    [self addSubview:topImageView];
    
    //播放当前图片
    SDHomeBtnView *middleImageView = [[SDHomeBtnView alloc] init];
    middleImageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    middleImageView.backgroundColor = UIColorFormRandom;
    self.middleBtnView = middleImageView;
    [self addSubview:middleImageView];
    
    //底部图片
    SDHomeBtnView *bottomImageView = [[SDHomeBtnView alloc] init];
    bottomImageView.frame = CGRectMake(0, SCREEN_HEIGHT*2, SCREEN_WIDTH, SCREEN_HEIGHT);
    bottomImageView.backgroundColor = UIColorFormRandom;
    self.bottomBtnView = bottomImageView;
    [self addSubview:bottomImageView];
    
    /*
    KSYMoviePlayerController *topPlayer = [[KSYMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"https://api.huoshan.com/hotsoon/item/video/_playback/?video_id=bea0903abb954f58ac0e17c21226a3c3&line=0&app_id=1115&quality=720p"]];
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
    [topPlayer play];
    */
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
    
    /*
    KSYMoviePlayerController *bottomPlayer = [[KSYMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@""]];
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
     */
}

                                                                                               
#pragma mark - funcs
/**
 更新数据
 
 @param videoDataArrs 数据源
 @param index idnex
 */
- (void)updateCurrentPlayerDatas:(NSMutableArray <SDShortVideoModel *>*)videoDataArrs currentIndex:(NSInteger )index{
    if (videoDataArrs.count && [videoDataArrs firstObject]){
        [self.dataArrs removeAllObjects];
        [self.dataArrs addObjectsFromArray:videoDataArrs];
        //当前播放
        self.currentIndex = index;
        //之前播放
        self.previousIndex = index;
        [self updateVideo:index];
    }
}

- (void)updateVideo:(NSInteger )index{
    
    self.topVideoModel = [[SDShortVideoModel alloc]init];
    self.middleVideoModel = (SDShortVideoModel *)self.dataArrs[index];
    self.bottomVideoModel = [[SDShortVideoModel alloc]init];
    
    if (index==0) {
        self.topVideoModel = (SDShortVideoModel *)[self.dataArrs lastObject];
    }else{
        self.topVideoModel = (SDShortVideoModel *) self.dataArrs[index-1];
    }
    if (index == self.dataArrs.count-1) {
        self.bottomVideoModel = (SDShortVideoModel *)[self.dataArrs firstObject];
    }else{
        self.bottomVideoModel = (SDShortVideoModel *)self.dataArrs[index+1];
    }
    /** 设置封面 */
    [self prepareForImageView:self.topBtnView shortVideoModel:self.topVideoModel];
    [self prepareForImageView:self.middleBtnView shortVideoModel:self.middleVideoModel];
    [self prepareForImageView:self.bottomBtnView shortVideoModel:self.bottomVideoModel];
    
    /** 设置视频数据 */
    [self prepareForVideo:self.middlePlayer shortVideoModel:self.middleVideoModel];
}

- (void)prepareForImageView:(SDHomeBtnView *)btnView shortVideoModel:(SDShortVideoModel *)shortVideoModel{
    [btnView.bgImageView sd_setImageWithURL:[NSURL URLWithString:shortVideoModel.imageUrl]];
}

- (void)prepareForVideo:(KSYMoviePlayerController *)player shortVideoModel:(SDShortVideoModel *)shortVideoModel
{
    [player reset:false];
    [player setUrl:[NSURL URLWithString:shortVideoModel.videoUrl]];
    [player setShouldAutoplay:false];
    [player setBufferSizeMax:1];
    [player setShouldLoop:YES];
    player.view.backgroundColor = [UIColor clearColor];
    [player prepareToPlay];
    [player play];
    DLog(@"self.middle:%@",NSStringFromCGRect(player.view.frame));
//    self.middleImageView.hidden = NO;
}

                                                                                               
                                                                                               
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self changeCurrentPlayer:scrollView];
}

///滚动滑动
-(void)changeCurrentPlayer:(UIScrollView *)scrollView{
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    DLog(@"currentOffsetY:%f",currentOffsetY);
    if(currentOffsetY>=2*SCREEN_HEIGHT){
        self.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
        self.currentIndex++;
//        ///替换数据
//        self.topImageView.image = self.middleImageView.image;
//        self.middleImageView.image = self.bottomImageView.image;
//
//        self.middleVideoModel = self.dataArrs[self.currentIndex];
//
//        if(self.currentIndex==0){
//            self.topVideoModel = [self.dataArrs lastObject];
//        }
        if(self.currentIndex==self.dataArrs.count){
            self.currentIndex = 0;
        }
        [self updateVideo:self.currentIndex];
        
    }
    else if(currentOffsetY<=0){
        self.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
        self.currentIndex--;
        if(self.currentIndex==-1){
            self.currentIndex = self.dataArrs.count-1;
        }
        [self updateVideo:self.currentIndex];
        
    }
}




/**
 视频数据源
 */
-(NSMutableArray *)dataArrs{
    if (!_dataArrs) {
        _dataArrs = [NSMutableArray array];
    }
    return _dataArrs;
}

@end
