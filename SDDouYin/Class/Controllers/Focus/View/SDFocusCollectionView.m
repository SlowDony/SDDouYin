//
//  SDFocusCollectionView.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDFocusCollectionView.h"
#import "SDFocusCollectionViewCell.h"
#import "SDShortVideoModel.h"
#define focusCell @"focusCell"
@interface SDFocusCollectionView()
<UICollectionViewDelegate,
UICollectionViewDataSource>

@end
@implementation SDFocusCollectionView

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
        self.alwaysBounceVertical = YES;
        //注册
        [self registerClass:[SDFocusCollectionViewCell class] forCellWithReuseIdentifier:focusCell];
        if (@available(iOS 11.0, *)) {
         self.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}



#pragma mark - UICollectionViewDataSource
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArrs.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-1)/2,SCREEN_WIDTH/2/187*298);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDFocusCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:focusCell forIndexPath:indexPath];
    SDShortVideoModel *shortVideoModel = self.dataArrs[indexPath.row];
    [cell setValueWithModel:shortVideoModel];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.collectionDelegate respondsToSelector:@selector(SDFocusCollectionView:didSelectItemAtIndexPath:)])
    {
        [self.collectionDelegate SDFocusCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}


@end
