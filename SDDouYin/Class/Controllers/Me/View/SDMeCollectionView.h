//
//  SDMeCollectionView.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SDMeCollectionView;
@protocol SDMeCollectionViewDelegate<NSObject>
///点击
- (void)sdMeCollectionView:(SDMeCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
///加载更多
- (void)sdMeCollectionViewLoadMoreData;

@end

@interface SDMeCollectionView : UICollectionView
@property (nonatomic,strong)  MJRefreshAutoNormalFooter *footer;

///数据源
@property (nonatomic,strong)  NSMutableArray *dataArr;


@property (nonatomic,weak) id<SDMeCollectionViewDelegate>personDateDelegate;
@end
