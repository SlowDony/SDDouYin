//
//  SDMeHeadTitleView.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDMeHeadTitleView : UIView
///作品
@property (nonatomic,strong)  UIButton *productionBtn;
///喜欢
@property (nonatomic,strong)  UIButton *likeBtn;

@property (nonatomic,copy)  void (^titleBtnClickBlock)(UIButton *sender);
@end
