//
//  SDNearbyViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/15.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDNearbyViewController.h"
#import "SDNearbyCollectionView.h"
#import "SDVideoDetailViewController.h"
#import "SDShortVideoModel.h"
/**
 附近
 */
@interface SDNearbyViewController ()
<SDNearbyCollectionViewDelegate>
@property (nonatomic, strong)SDNearbyCollectionView   *nearbyCollectionView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation SDNearbyViewController

#pragma mark - lazy

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


- (SDNearbyCollectionView *)nearbyCollectionView{
    if (!_nearbyCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _nearbyCollectionView = [[SDNearbyCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight) collectionViewLayout:layout];
        _nearbyCollectionView.collectionDelegate = self;
        if (@available(iOS 11.0, *)) {
            _nearbyCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _nearbyCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    [self.view addSubview:self.nearbyCollectionView];
    
    
    [self refreshCollectionView];
}

- (void)refreshCollectionView{
    self.nearbyCollectionView.dataArrs = [NSMutableArray arrayWithArray:self.dataArr];
    [self.nearbyCollectionView reloadData];
}

#pragma mark - SDNearbyCollectionViewDelegat
-(void)SDNearbyCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SDVideoDetailViewController *nearbyListVC = [[SDVideoDetailViewController alloc]init];
    [nearbyListVC updateVideoDetailDatas:self.dataArr currentIndex:indexPath.row];
    nearbyListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nearbyListVC animated:YES];
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
