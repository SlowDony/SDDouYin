//
//  SDHomeListViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/8/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDHomeListViewController.h"
#import "SDHomeListTableView.h"
#import "SDHomeTool.h"


//#import "ZFDouYinControlView.h"


#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
@interface SDHomeListViewController ()
@property (nonatomic,strong) SDHomeListTableView *tableView;

@property (nonatomic, strong) ZFPlayerController *player;
//@property (nonatomic, strong) ZFDouYinControlView *controlView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *urls;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@end

@implementation SDHomeListViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player.currentPlayerManager pause];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.player.currentPlayerManager play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
//    [self refreshTableView];
    [self setNetWork];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    [self.view addSubview:self.tableView];
    /// playerManager
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// player,tag值必须在cell里设置
    self.player = [ZFPlayerController playerWithScrollView:self.tableView playerManager:playerManager containerViewTag:100];
    self.player.assetURLs = self.urls;
    self.player.disableGestureTypes = ZFPlayerDisableGestureTypesDoubleTap | ZFPlayerDisableGestureTypesPan | ZFPlayerDisableGestureTypesPinch;
    self.player.controlView = self.controlView;
//    self.player.allowOrentitaionRotation = NO;
    self.player.WWANAutoPlay = YES;
    
    /// 1.0是完全消失时候
//    self.player.playerDisapperaPercent = 1.0;
    
    @weakify(self)
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player.currentPlayerManager replay];
    };
}


- (void)refreshTableView{

    self.tableView.dataArray = self.dataSource;
    [self.tableView reloadData];
    /// 找到可以播放的视频并播放
    @xWeakify
    [self.tableView zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
        @xStrongify
        [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
    }];
}

/// play the video
- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop {
    [self.player.currentPlayerManager playerPrepareToPlay];
    [self.player playTheIndexPath:indexPath scrollToTop:scrollToTop];
    
//    [self.controlView resetControlView];
    SDAweme *data = self.dataSource[indexPath.row];
//    [self.controlView showCoverViewWithUrl:[data.video.originCover.urlList firstObject]];
    [self.controlView showTitle:data.title coverURLString:[data.video.originCover.urlList firstObject] fullScreenMode:ZFFullScreenModeLandscape];
    
}


#pragma mark - network

- (void)setNetWork{
    self.urls = @[].mutableCopy;
    [SDHomeTool getAwemeFeedTaskSuccess:^(id obj) {
        SDAwemeFeedModel *feedModel = (SDAwemeFeedModel *)obj;
        self.dataSource = [NSMutableArray arrayWithArray:feedModel.awemeList];
        
        for (SDAweme *aweme in self.dataSource){
            NSString *URLString = [[aweme.video.playAddr.urlList firstObject] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *url = [NSURL URLWithString:URLString];
            [self.urls addObject:url];
        }
        
        self.player.assetURLs = self.urls;
        [self refreshTableView];
        
    } failed:^(id obj) {
        DLog(@"obj%@",obj);
    }];
}

#pragma mark - lazy
- (SDHomeListTableView *)tableView{
    if(!_tableView){
        _tableView = [[SDHomeListTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        /// 停止的时候找出最合适的播放
        @xWeakify
        _tableView.scrollViewDidStopScroll = ^(NSIndexPath * _Nonnull indexPath) {
            @xStrongify
            if (indexPath.row == self.dataSource.count-1) {
                            /// 加载下一页数据
                            [self setNetWork];
                            self.player.assetURLs = self.urls;
                            [self.tableView reloadData];
            }
            [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
        };
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
//
//- (ZFDouYinControlView *)controlView {
//    if (!_controlView) {
//        _controlView = [ZFDouYinControlView new];
//    }
//    return _controlView;
//}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
    }
    return _controlView;
}

- (NSMutableArray *)urls {
    if (!_urls) {
        _urls = @[].mutableCopy;
    }
    return _urls;
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
