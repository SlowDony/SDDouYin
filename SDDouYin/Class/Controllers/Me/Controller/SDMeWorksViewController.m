//
//  SDMeWorksViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDMeWorksViewController.h"
#import "SDVideoDetailViewController.h"
#import "SDMeCollectionView.h"
#import "SDUserTool.h"
#import "SDAwemeList.h"
/**
 个人作品
 */
@interface SDMeWorksViewController ()
<SDMeCollectionViewDelegate>

@property (nonatomic,strong)  NSMutableArray  *dataArr;

@end

@implementation SDMeWorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self setNetWork];
    // Do any additional setup after loading the view.
}

- (void)refreshCollectionView{
    self.collectionView.dataArr = self.dataArr;
    [self.collectionView reloadData];
}


#pragma mark - SDMeCollectionViewDelegate
- (void)sdMeCollectionView:(SDMeCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SDVideoDetailViewController *detailVC = [[SDVideoDetailViewController alloc]init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [detailVC updateVideoNotCyclePlayer:self.dataArr currentIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)sdMeCollectionViewLoadMoreData {
    DLog(@"geng'duo");
}

- (void)setNetWork{
    [SDUserTool getAwemeListTaskSuccess:^(id obj) {
        self.dataArr = (NSMutableArray *)obj;
        
        [self refreshCollectionView];
    } failed:^(id obj) {
        DLog(@"error:ojb");
    }];
}


#pragma mark - lazy
-(SDMeCollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.headerReferenceSize = CGSizeMake(0, (kWidth(130)+170)+44);
        _collectionView = [[SDMeCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        _collectionView.personDateDelegate = self;
    }
    return _collectionView;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
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
