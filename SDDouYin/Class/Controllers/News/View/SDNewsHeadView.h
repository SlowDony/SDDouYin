//
//  SDNewsHeadView.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SDNewsHeadItem : UIButton
///图标
@property (nonatomic,strong)  UIImageView *iconImageView;
///小红点
@property (nonatomic,strong)  UILabel *redLabel;
///内容
@property (nonatomic,strong)  UILabel *nameLable;

@end
@interface SDNewsHeadView : UIView

@end
