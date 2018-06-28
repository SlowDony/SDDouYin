//
//  SDFocusViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/15.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDFocusViewController.h"
#import "SDFocusCollectionView.h"
#import "SDShortVideoModel.h"
#import "SDVideoDetailViewController.h"
@interface SDFocusViewController ()
<SDFocusCollectionViewDelegate>
@property (nonatomic,strong) SDFocusCollectionView  *focusCollectionView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation SDFocusViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    [self.view addSubview:self.focusCollectionView];
    [self refreshCollectionView];
}

- (void)refreshCollectionView{
    self.focusCollectionView.dataArrs = [NSMutableArray arrayWithArray:self.dataArr];
    [self.focusCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SDFocusCollectionViewDelegate
- (void)SDFocusCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SDVideoDetailViewController *nearbyListVC = [[SDVideoDetailViewController alloc]init];
    [nearbyListVC updateVideoDetailDatas:self.dataArr currentIndex:indexPath.row];
    nearbyListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nearbyListVC animated:YES];
}


#pragma mark - lazy
- (SDFocusCollectionView *)focusCollectionView{
    if(!_focusCollectionView){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _focusCollectionView = [[SDFocusCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        _focusCollectionView.collectionDelegate = self;
        
    }
    return _focusCollectionView;
}

-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
        NSArray *arr = @[
  @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200ff70000bboodf534q13tind0g50&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p9.pstatp.com/large/81ad00114c93d16a568d.jpeg",@"likeNum":@1,@"commentNum":@20,@"shareNum":@30},
  @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=2d7fb4601a224b0ca3d3209b812b2213&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p1.pstatp.com/large/79be000156405c72ea6d.jpeg",@"likeNum":@2,@"commentNum":@20,@"shareNum":@30},
  @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=4d2cd55055d74c1e821252b5cf326f61&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p3.pstatp.com/large/7ac9000678050b059d9a.jpeg",@"likeNum":@3,@"commentNum":@20,@"shareNum":@30},
  @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=120b8947e786462eb50bbb260214ae83&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p3.pstatp.com/large/7c18000afe77c1414248.jpeg",@"likeNum":@4,@"commentNum":@20,@"shareNum":@30},
  @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200f970000bcks2l0858lmn4qmh7qg&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p1.pstatp.com/large/8ff10004c9eeff1f9044.jpeg",@"likeNum":@5,@"commentNum":@20,@"shareNum":@30},
  @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200f180000bci0kkrd82dj0u4fadj0&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p3.pstatp.com/large/8ebd000fe09637445df0.jpeg",@"likeNum":@6,@"commentNum":@10,@"shareNum":@1000},
  @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=v0200f660000bcfu1ot1mikeotn5i7ng&line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p3.pstatp.com/large/8d0f0006f571436ea78d.jpeg",@"likeNum":@7,@"commentNum":@40,@"shareNum":@21},
  @{@"videoUrl":@"https://aweme.snssdk.com/aweme/v1/play/?video_id=v02001560000bckaiup75rdmqh4q9sug&line=0&ratio=default&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0",@"imageUrl":@"http://p1.pstatp.com/large/8d41000f687968170788.jpeg",@"likeNum":@8,@"commentNum":@21,@"shareNum":@333},
                         ];
        _dataArr = [SDShortVideoModel mj_objectArrayWithKeyValuesArray:arr];
    }
    return _dataArr;
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
