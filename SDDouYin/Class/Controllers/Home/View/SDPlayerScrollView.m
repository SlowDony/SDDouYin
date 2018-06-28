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
#import "SDAnimationTool.h"
@interface SDPlayerScrollView()
<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong)  NSMutableArray *dataArrs;
@property (nonatomic,strong)  SDShortVideoModel  *currentVideoModel;
@property (nonatomic,strong)  SDShortVideoModel  *topVideoModel,*middleVideoModel,*bottomVideoModel;
@property (nonatomic,strong)  SDHomeBtnView
    *topBtnView,*middleBtnView,*bottomBtnView;
@property (nonatomic,assign) NSTimeInterval timestamp;
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
        self.userInteractionEnabled = YES;
        if (@available(iOS 11.0, *)) {
         self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    KSYMoviePlayerController *middlePlayer = [[KSYMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@""]];
     [middlePlayer.view setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    middlePlayer.view.backgroundColor = [UIColor clearColor];
    middlePlayer.view.tag = 1002;
    [middlePlayer setBufferSizeMax:1];
    middlePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    middlePlayer.view.autoresizesSubviews = YES;
    middlePlayer.shouldAutoplay = YES;
    middlePlayer.videoDecoderMode = MPMovieVideoDecoderMode_AUTO;
    middlePlayer.scalingMode = MPMovieScalingModeAspectFit;
    [self addSubview:middlePlayer.view];
    [middlePlayer prepareToPlay];
    self.middlePlayer = middlePlayer;

    //顶部图片
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.topImageView = topImageView;
    [self addSubview:topImageView];
    
    //播放当前图片
    UIImageView *middleImageView = [[UIImageView alloc] init];
    middleImageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    middleImageView.backgroundColor = UIColorFormRandom;
    self.middleImageView = middleImageView;
    [self addSubview:middleImageView];
    
    //底部图片
    UIImageView *bottomImageView = [[UIImageView alloc] init];
    bottomImageView.frame = CGRectMake(0, SCREEN_HEIGHT*2, SCREEN_WIDTH, SCREEN_HEIGHT);
    bottomImageView.backgroundColor = UIColorFormRandom;
    self.bottomImageView = bottomImageView;
    [self addSubview:bottomImageView];
    
    //顶部图片
    SDHomeBtnView *topBtnView = [[SDHomeBtnView alloc] init];
    topBtnView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    topBtnView.backgroundColor = [UIColor clearColor];
    self.topBtnView = topBtnView;
    [self addSubview:topBtnView];
    
    //播放当前图片
    SDHomeBtnView *middleBtnView = [[SDHomeBtnView alloc] init];
    middleBtnView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    middleBtnView.backgroundColor = [UIColor clearColor];
    self.middleBtnView = middleBtnView;
middleBtnView.headItem.headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImagePanClick:)];
    [middleBtnView.headItem.headImageView addGestureRecognizer:pan];
    [middleBtnView.headItem.focusBtn  addTarget:self action:@selector(focusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:middleBtnView];
    
    //底部图片
    SDHomeBtnView *bottomBtnView = [[SDHomeBtnView alloc] init];
    bottomBtnView.frame = CGRectMake(0, SCREEN_HEIGHT*2, SCREEN_WIDTH, SCREEN_HEIGHT);
    bottomBtnView.backgroundColor = [UIColor clearColor];
    self.bottomBtnView = bottomBtnView;
    [self addSubview:bottomBtnView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
        
    if ((event.timestamp - self.timestamp <= 0.40) &&(event.timestamp - self.timestamp != 0)){
         [[SDAnimationTool shareAnimationTool] showLargeLikeAnimationWithTouch:touches withEvent:event];
        ///取消单击手势
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playerSingleClick:) object:nil];
        ///添加双击手势
        [self performSelector:@selector(playerDoubleClick:) withObject:nil afterDelay:0.3];
    }else {
        ///取消双击手势
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playerDoubleClick:) object:nil];
        [self performSelector:@selector(playerSingleClick:) withObject:nil afterDelay:0.3];
    }
    self.timestamp = event.timestamp;
}

#pragma mark - clicks


///播放视频(单机)
- (void)playerSingleClick:(id )sender{
    if ([self.middlePlayer isPlaying]) {
        [self.middlePlayer pause];
        self.middleBtnView.playImageView.hidden = NO;
    }else{
        [self.middlePlayer play];
        self.middleBtnView.playImageView.hidden = YES;
    }
}

///双击以上点赞
- (void)playerDoubleClick:(id )sender{
    
}


///点击头像
- (void)headImagePanClick:(UIGestureRecognizer *)gesture{
    
    if([self.playerDelegate respondsToSelector:@selector(playerScrollViewHeadBtnClick:)]){
        [self.playerDelegate playerScrollViewHeadBtnClick:self];
    }
}
- (void)focusBtnClick:(UIButton *)sender{
    DLog(@"关注按钮点击");
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
    [self prepareForImageView:self.topImageView btnView:self.topBtnView shortVideoModel:self.topVideoModel];
    [self prepareForImageView:self.middleImageView btnView:self.middleBtnView shortVideoModel:self.middleVideoModel];
    [self prepareForImageView:self.bottomImageView btnView:self.bottomBtnView shortVideoModel:self.bottomVideoModel];

    /** 设置视频数据 */
    [self prepareForVideo:self.middlePlayer shortVideoModel:self.middleVideoModel];
}

/**
 设置图片

 @param imageView 图片
 @param btnView 按钮
 @param shortVideoModel shortVideoModel
 */
- (void)prepareForImageView:(UIImageView *)imageView btnView:(SDHomeBtnView *)btnView shortVideoModel:(SDShortVideoModel *)shortVideoModel{
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:shortVideoModel.imageUrl]];
    [btnView setValueWithModel:shortVideoModel];
}


/**
 设置视频资源

 @param player 播放器
 @param shortVideoModel 视频资源
 */
- (void)prepareForVideo:(KSYMoviePlayerController *)player shortVideoModel:(SDShortVideoModel *)shortVideoModel
{
    [self.middlePlayer reset:NO];
    [self.middlePlayer setUrl:[NSURL URLWithString:shortVideoModel.videoUrl]];
//    [player setShouldAutoplay:YES];
//    [player setBufferSizeMax:1];
//    [player setShouldLoop:YES];
    self.middlePlayer.view.backgroundColor = [UIColor clearColor];
    [self.middlePlayer prepareToPlay];
    self.middleImageView.hidden = NO;
}

                                                                                               
                                                                                               
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self changeCurrentPlayer:scrollView];
}

///滚动滑动
-(void)changeCurrentPlayer:(UIScrollView *)scrollView{
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    if(currentOffsetY>=2*SCREEN_HEIGHT){
        self.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
        self.currentIndex++;
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
