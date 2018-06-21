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
        [self setupSubviews1];
    }
    return self;
}

- (void)setupSubviews{
    SDPlayerScrollItem *topItem = [[SDPlayerScrollItem alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    topItem.videoPlayer.view.tag =1001;
    [self addSubview:topItem];
    self.topItem = topItem;
    
    SDPlayerScrollItem *middleItem = [[SDPlayerScrollItem alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    middleItem.videoPlayer.view.tag =1002;
    [self addSubview:middleItem];
    self.middleItem = middleItem;
    
    SDPlayerScrollItem *bottomItem = [[SDPlayerScrollItem alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*2, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bottomItem.videoPlayer.view.tag =1003;
    [self addSubview:bottomItem];
    self.bottomItem = bottomItem;
    
}


- (void)setupSubviews1{

    
    
    
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
    [self addSubview:middleBtnView];
    
    //底部图片
    SDHomeBtnView *bottomBtnView = [[SDHomeBtnView alloc] init];
    bottomBtnView.frame = CGRectMake(0, SCREEN_HEIGHT*2, SCREEN_WIDTH, SCREEN_HEIGHT);
    bottomBtnView.backgroundColor = [UIColor clearColor];
    self.bottomBtnView = bottomBtnView;
    [self addSubview:bottomBtnView];
    
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
//
//    [self prepareForScrollItem:self.topItem shortVideoModel:self.topVideoModel];
//    [self prepareForScrollItem:self.middleItem shortVideoModel:self.middleVideoModel];
//    [self prepareForScrollItem:self.bottomItem shortVideoModel:self.bottomVideoModel];
}



/**
 设置scrollItem

 @param scrollItem scrollItem
 @param shortVideoModel shortVideoModel
 */
- (void)prepareForScrollItem:(SDPlayerScrollItem *)scrollItem shortVideoModel:(SDShortVideoModel *)shortVideoModel{
    
    [self prepareForImageView:scrollItem.bgImageView btnView:scrollItem.homeBtnView shortVideoModel:shortVideoModel];
    [self prepareForVideo:scrollItem.videoPlayer shortVideoModel:shortVideoModel];
    
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

- (void)changeCurrentVideoPlayer:(UIScrollView *)scrollView{
     CGFloat currentOffsetY = scrollView.contentOffset.y;
    if (currentOffsetY>=2*SCREEN_HEIGHT) {
        self.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
        if(self.topItem.frame.origin.y==0){
            self.topItem.frame = CGRectMake(0, SCREEN_HEIGHT*2, SCREEN_WIDTH, SCREEN_HEIGHT);
        }else{
            self.topItem.frame = CGRectMake(0, self.topItem.frame.origin.y-SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        
        if(self.middleItem.frame.origin.y==0){
            self.middleItem.frame = CGRectMake(0, SCREEN_HEIGHT*2, SCREEN_WIDTH, SCREEN_HEIGHT);
        }else{
            self.middleItem.frame = CGRectMake(0, self.middleItem.frame.origin.y-SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
        
        if(self.bottomItem.frame.origin.y==0){
            self.bottomItem.frame = CGRectMake(0, SCREEN_HEIGHT*2, SCREEN_WIDTH, SCREEN_HEIGHT);
        }else{
            self.bottomItem.frame = CGRectMake(0, self.bottomItem.frame.origin.y-SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        }
  
    }else if (currentOffsetY<=0){
        self.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
    }
    
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
