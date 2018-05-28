//
//  SDMeCollectionViewCell.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SDNumView :UIView

@property (nonatomic,strong)  UIImageView *iconImageView;
@property (nonatomic,strong)  UILabel *numLabel;


@end


@interface SDMeCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *bgImageView;///背景图片
@property (nonatomic,strong) SDNumView *likeNumView; ///点赞数


@end
