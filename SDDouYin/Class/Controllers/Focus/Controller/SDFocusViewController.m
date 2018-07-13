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
#import "SDFocusTool.h"
@interface SDFocusViewController ()
<SDFocusCollectionViewDelegate>
@property (nonatomic,strong) SDFocusCollectionView  *focusCollectionView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation SDFocusViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setNetWork];
    // Do any additional setup after loading the view.
}

- (void)setNetWork{
    @xWeakify
    [SDFocusTool getFollowFeedSuccess:^(id obj) {
        @xStrongify
        NSArray *arr  = [NSMutableArray arrayWithArray:(NSArray *)obj];
        NSMutableArray *emptyArr = [NSMutableArray array];
        for (SDData *data in arr){
            if (data.feedType ==1){
                [emptyArr addObject:data];
            }
        }
        self.dataArr = emptyArr;
        [self refreshCollectionView];
    } failed:^(id obj) {
        
    }];
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
    SDData *data = self.dataArr[indexPath.row];
    [nearbyListVC updateVideoDetailAweme:data.aweme];
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
