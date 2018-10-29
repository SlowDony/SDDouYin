//
//  SDRecommendViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/15.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDRecommendViewController.h"
#import "SDHomeBtnView.h"
#import "SDPlayerScrollView.h"
#import "SDShortVideoModel.h"
#import <KSYMediaPlayer/KSYMediaPlayer.h>
#import "SDMeViewController.h"
#import "SDHomeTool.h"
#import "SDAwemeFeedModel.h"
/**
 推荐
 */
@interface SDRecommendViewController ()
<SDPlayerScrollViewDelegate>

@property (nonatomic,strong) SDHomeBtnView *homeBtnView;

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation SDRecommendViewController

- (BOOL)prefersStatusBarHidden{
    return YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

- (void)setupUI{
    [self.view addSubview:self.playerScrollView];
    [self.playerScrollView addSubview:self.homeBtnView];
//    [self.playerScrollView updateCurrentPlayerDatas:self.dataArr currentIndex:0];
    [self setNetWork];
}

- (void)refreshCollectionView{
    [self.playerScrollView updateVideoNotCyclePlayer:self.dataArr currentIndex:0];
}

- (void)videoPlay{
    [self.playerScrollView playVideo];
}
- (void)videoPause{
    [self.playerScrollView pauseVideo];
}

- (BOOL)pushPersonalInfoViewController {
    
    BOOL isPush = YES;
        SDMeViewController *meVC = [[SDMeViewController alloc]init];
        meVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:meVC animated:YES];
    return isPush;
}



#pragma mark - addNotification
- (void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handlePlayerNotify:) name:MPMoviePlayerFirstVideoFrameRenderedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handlePlayerPreparedToPlayNotify:) name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handlePlaybackDidFinishNotify:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
}
- (void)removeNotification{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerFirstVideoFrameRenderedNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
}


#pragma mark - NSNotification

- (void)handlePlaybackDidFinishNotify:(NSNotification *)notify{
    [self videoPlay];
}

- (void)handlePlayerNotify:(NSNotification *)notify{
 if(self.playerScrollView.middlePlayer.view.frame.origin.y==SCREEN_HEIGHT) {
       [self videoPlay];
    }
}

- (void)handlePlayerPreparedToPlayNotify:(NSNotification *)notify{
//    KSYMoviePlayerController *playerController =notify.object;
// if(self.playerScrollView.middlePlayer.view.frame.origin.y==SCREEN_HEIGHT){
//        if ([self.playerScrollView.middlePlayer isPreparedToPlay]) {
//            if (self.playerScrollView.middlePlayer.currentPlaybackTime >  0.1) {
//                [self.playerScrollView.middlePlayer.view setHidden:false];
//            }
//        }
//    }
    
}

#pragma mark - SDPlayerScrollViewDelegate
-(void)playerScrollViewHeadBtnClick:(SDPlayerScrollView *)playerScrollView{
    SDMeViewController *meVC = [[SDMeViewController alloc]init];
    meVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:meVC animated:YES];
}

- (void)setNetWork{
    [SDHomeTool getAwemeFeedTaskSuccess:^(id obj) {
        SDAwemeFeedModel *feedModel = (SDAwemeFeedModel *)obj;
        self.dataArr = [NSMutableArray arrayWithArray:feedModel.awemeList];
        [self refreshCollectionView];
        
    } failed:^(id obj) {
        DLog(@"obj%@",obj);
    }];
}


#pragma mark - lazy
-(SDPlayerScrollView *)playerScrollView{
    if(!_playerScrollView){
        _playerScrollView = [[SDPlayerScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _playerScrollView.playerDelegate = self;
    }
    return _playerScrollView;
}

-(SDHomeBtnView *)homeBtnView{
    if(!_homeBtnView){
        _homeBtnView = [[SDHomeBtnView alloc]initWithFrame:self.view.bounds];
    }
    return _homeBtnView;
}

-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
