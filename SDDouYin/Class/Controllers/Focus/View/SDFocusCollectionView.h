//
//  SDFocusCollectionView.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  SDFocusCollectionViewDelegate<NSObject>

///点击
- (void)SDFocusCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SDFocusCollectionView : UICollectionView
@property (nonatomic,weak)  id <SDFocusCollectionViewDelegate> collectionDelegate;
@end
