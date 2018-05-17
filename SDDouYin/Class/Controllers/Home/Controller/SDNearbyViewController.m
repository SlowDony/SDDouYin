//
//  SDNearbyViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/15.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDNearbyViewController.h"
#import "SDNearbyCollectionView.h"
#import "SDNearbyListViewController.h"
/**
 附近
 */
@interface SDNearbyViewController ()
<SDNearbyCollectionViewDelegate>
@property (nonatomic, strong)SDNearbyCollectionView   *nearbyCollectionView;

@end

@implementation SDNearbyViewController

#pragma mark - lazy
- (SDNearbyCollectionView *)nearbyCollectionView{
    if (!_nearbyCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _nearbyCollectionView = [[SDNearbyCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kBottomTabbarHeight) collectionViewLayout:layout];
        _nearbyCollectionView.collectionDelegate = self;
    }
    return _nearbyCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor blueColor];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    [self.view addSubview:self.nearbyCollectionView];
}

#pragma mark - SDNearbyCollectionViewDelegat
-(void)SDNearbyCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SDNearbyListViewController *nearbyListVC = [[SDNearbyListViewController alloc]init];
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
