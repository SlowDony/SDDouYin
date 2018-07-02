//
//  SDMeCollectionView.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDMeCollectionView.h"
#import "SDMeCollectionViewCell.h"


#define SDMeCollectionCell @"SDMeCollectionCellId"
#define SDHeaderView @"SDHeaderViewId"
@interface SDMeCollectionView ()
<UICollectionViewDelegate,
UICollectionViewDataSource>

@end
@implementation SDMeCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self setBackgroundColor:[UIColor clearColor]];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = NO;
        //注册
        [self registerClass:[SDMeCollectionViewCell class] forCellWithReuseIdentifier:SDMeCollectionCell];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SDHeaderView];  //  一定要设置
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        self.mj_footer = self.footer;
        
        self.footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [self.footer setTitle:@"" forState:MJRefreshStateIdle];
        [self.footer setTitle:@"" forState:MJRefreshStatePulling];
        [self.footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
        
    }
    return self;
}


- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SDHeaderView forIndexPath:indexPath];
    return headerView;
}


- (void)loadMoreData{
    
    if ([self.personDateDelegate respondsToSelector:@selector(sdMeCollectionViewLoadMoreData)]) {
        [self.personDateDelegate sdMeCollectionViewLoadMoreData];
    }
    DLog(@"加载更多");
}

#pragma mark - UICollectionViewDataSource
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-2)/3,SCREEN_WIDTH/3/124*165);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDMeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDMeCollectionCell forIndexPath:indexPath];
    SDAweme *aweme = self.dataArr[indexPath.row];
    [cell setValueWithModel:aweme];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.personDateDelegate respondsToSelector:@selector(sdMeCollectionView:didSelectItemAtIndexPath:)]) {
        [self.personDateDelegate sdMeCollectionView:self didSelectItemAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat pointY = scrollView.contentOffset.y;
    NSDictionary *userInfo = @{SDScrollViewOffSetKey:@(pointY)};
    [[NSNotificationCenter defaultCenter]postNotificationName:SDScrollViewOffSetNotification object:nil userInfo:userInfo];
}
@end
