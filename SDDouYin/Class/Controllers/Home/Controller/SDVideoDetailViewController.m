//
//  SDVideoDetailViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/22.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDVideoDetailViewController.h"
#import "SDPlayerScrollView.h"
#import "SDShortVideoModel.h"
#import "SDMeViewController.h"
@interface SDVideoDetailViewController ()
@property (nonatomic,strong) SDPlayerScrollView *playerScrollView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation SDVideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addNotification];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    [self.view addSubview:self.playerScrollView];
    ///返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"alimember_navbar_left"] forState:UIControlStateNormal];
    [leftBtn  addTarget:self action:@selector(popViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    
    
}

- (void)updateVideoDetailDatas:(NSMutableArray *)datas currentIndex:(NSInteger )index{
    self.dataArr = datas;
    [self.playerScrollView updateCurrentPlayerDatas:self.dataArr currentIndex:index];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(![self.playerScrollView.middlePlayer isPlaying]){
        [self.playerScrollView.middlePlayer play];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    if([self.playerScrollView.middlePlayer isPlaying]){
        [self.playerScrollView.middlePlayer stop];
    }
}

- (BOOL)pushPersonalInfoViewController {
    
    BOOL isPush = YES;
    SDMeViewController *meVC = [[SDMeViewController alloc]init];
    [self.navigationController pushViewController:meVC animated:YES];
    return isPush;
}


#pragma mark - action
- (void)popViewClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)dealloc{
    [self removeNotification];
}

#pragma mark - NSNotification

- (void)handlePlaybackDidFinishNotify:(NSNotification *)notify{
    
    if(![self.playerScrollView.middlePlayer isPlaying]){
        [self.playerScrollView.middlePlayer play];
    }
}
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
#pragma mark - lazy
-(SDPlayerScrollView *)playerScrollView{
    if(!_playerScrollView){
        _playerScrollView = [[SDPlayerScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _playerScrollView;
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
