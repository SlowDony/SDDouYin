//
//  SDFocusCollectionViewCell.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDFocusCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)  UIImageView *bgImageView;//背景图片
@property (nonatomic,strong)  UIImageView *headImageView;//头像
@property (nonatomic,strong)  UILabel *nameLabel; //姓名
@property (nonatomic,strong)  UILabel *timeLabel; //时间
@property (nonatomic,strong)  UILabel *contentLabel; //内容
@end
