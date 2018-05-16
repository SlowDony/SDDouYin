//
//  SDNearbyCollectionView.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/16.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  SDNearbyCollectionViewDelegate<NSObject>

///点击
- (void)SDNearbyCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SDNearbyCollectionView : UICollectionView
@property (nonatomic,weak)  id <SDNearbyCollectionViewDelegate> collectionDelegate;

@end
