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
/**
 推荐
 */
@interface SDRecommendViewController ()
<SDPlayerScrollViewDelegate>

@property (nonatomic,strong) SDHomeBtnView *homeBtnView;

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation SDRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
   
}

- (void)setupUI{
    [self.view addSubview:self.playerScrollView];
    [self.playerScrollView addSubview:self.homeBtnView];
    [self.playerScrollView updateCurrentPlayerDatas:self.dataArr currentIndex:0];
}

- (void)videoPlay{
    if(![self.playerScrollView.middlePlayer isPlaying]){
        [self.playerScrollView.middlePlayer play];
    }
}
- (void)videoPause{
    if([self.playerScrollView.middlePlayer isPlaying]){
        [self.playerScrollView.middlePlayer pause];
    }
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
}
- (void)removeNotification{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerFirstVideoFrameRenderedNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
}


#pragma mark - NSNotification

- (void)handlePlayerNotify:(NSNotification *)notify{
 if(self.playerScrollView.middlePlayer.view.frame.origin.y==SCREEN_HEIGHT) {
        self.playerScrollView.middleImageView.hidden = YES;
        [self.playerScrollView.middlePlayer play];
    }
}

- (void)handlePlayerPreparedToPlayNotify:(NSNotification *)notify{
    KSYMoviePlayerController *playerController =notify.object;
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

#pragma mark - lazy
-(SDPlayerScrollView *)playerScrollView{
    if(!_playerScrollView){
        _playerScrollView = [[SDPlayerScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _playerScrollView.playerDelegate = self;
        if (@available(iOS 11.0, *)) {
            _playerScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
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
        NSArray *arr = @[
                         @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200f970000bcks2l0858lmn4qmh7qg&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p1.pstatp.com/large/8ff10004c9eeff1f9044.jpeg",@"likeNum":@1,@"commentNum":@20,@"shareNum":@30},
                         @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200f180000bci0kkrd82dj0u4fadj0&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p3.pstatp.com/large/8ebd000fe09637445df0.jpeg",@"likeNum":@2,@"commentNum":@10,@"shareNum":@1000},
                         @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200f660000bcfu1ot1mikeotn5i7ng&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p3.pstatp.com/large/8d0f0006f571436ea78d.jpeg",@"likeNum":@3,@"commentNum":@40,@"shareNum":@21},
                         @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=v02001560000bckaiup75rdmqh4q9sug&line=0&ratio=default&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p1.pstatp.com/large/8d41000f687968170788.jpeg",@"likeNum":@4,@"commentNum":@21,@"shareNum":@333},
                         ];
        _dataArr = [SDShortVideoModel mj_objectArrayWithKeyValuesArray:arr];
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
