//
//  SDMeLikeViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDMeLikeViewController.h"
#import "SDMeCollectionView.h"

/**
 个人喜欢
 */
@interface SDMeLikeViewController ()
<SDMeCollectionViewDelegate>

@end

@implementation SDMeLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SDMeCollectionViewDelegate
- (void)sdMeCollectionView:(SDMeCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"点击");
}

- (void)sdMeCollectionViewLoadMoreData {
    DLog(@"geng'duo");
}


#pragma mark - lazy
-(SDMeCollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.headerReferenceSize = CGSizeMake(0, (kWidth(130)+170)+44);
        _collectionView = [[SDMeCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
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
