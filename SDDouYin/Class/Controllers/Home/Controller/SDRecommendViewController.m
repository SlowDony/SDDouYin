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
/**
 推荐
 */
@interface SDRecommendViewController ()
@property (nonatomic,strong)  SDHomeBtnView *homeBtnView;
@property (nonatomic,strong)  SDPlayerScrollView *playerScrollView;
@end

@implementation SDRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.playerScrollView];
    
    [self.playerScrollView addSubview:self.homeBtnView];
    [self addNotification];
    [self.playerScrollView prepareForVideo:self.playerScrollView.topPlayer];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.playerScrollView.topPlayer play];
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

- (void)dealloc{
    [self removeNotification];
}

- (void)handlePlayerNotify:(NSNotification *)notify{
    KSYMoviePlayerController *playerController = notify.object;
    switch (playerController.view.tag) {
        case 1001:
        {
        if(self.playerScrollView.topPlayer.view.frame.origin.y ==0) {
            [self.playerScrollView.topPlayer play];
            }
        }
            break;
        case 1002:{
            if (self.playerScrollView.middlePlayer.view.frame.origin.y==SCREEN_HEIGHT) {
                [self.playerScrollView.middlePlayer play];
            }
        }
          break;
        case 1003:{
            if (self.playerScrollView.bottomPlayer.view.frame.origin.y==SCREEN_HEIGHT) {
                [self.playerScrollView.bottomPlayer play];
            }
        }
            break;
        default:
            break;
    }
}

- (void)handlePlayerPreparedToPlayNotify:(NSNotification *)notify{
    KSYMoviePlayerController *playerController =notify.object;
    switch (playerController.view.tag) {
        case 1001:
            {
                if(self.playerScrollView.topPlayer.view.frame.origin.y==0){
                    [self.playerScrollView.topPlayer.view setHidden:NO];
                }
            }
            break;
        case 1002:
        {
            if(self.playerScrollView.middlePlayer.view.frame.origin.y==SCREEN_HEIGHT){
                [self.playerScrollView.middlePlayer.view setHidden:NO];
            }
        }
            break;
        case 1003:
        {
            if(self.playerScrollView.bottomPlayer.view.frame.origin.y==SCREEN_HEIGHT){
                [self.playerScrollView.bottomPlayer.view setHidden:NO];
                
            }
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - lazy
-(SDPlayerScrollView *)playerScrollView{
    if(!_playerScrollView){
        _playerScrollView = [[SDPlayerScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
