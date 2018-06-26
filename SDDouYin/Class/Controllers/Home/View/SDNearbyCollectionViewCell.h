//
//  SDNearbyCollectionViewCell.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/16.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDShortVideoModel;
@interface SDNearbyCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)  UIImageView *bgImageView;//背景图片
@property (nonatomic,strong)  UIImageView *headImageView;//头像
@property (nonatomic,strong)  UILabel *nameLabel; //姓名
@property (nonatomic,strong)  UILabel *distanceLabel; //距离

- (void)setValueWithModel:(SDShortVideoModel *)shortVideoModel;
@end
