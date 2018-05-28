//
//  SDBaseNavigationView.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDBaseNavigationView : UIView

@property (nonatomic,strong)  UIButton *rightBtn;
@property (nonatomic,strong)  UIButton *leftBtn;
@property (nonatomic,strong)  UILabel  *titleLabel;

@property (nonatomic,copy)  void (^leftBtnClickBlock)(UIButton *sender);
@property (nonatomic,copy)  void (^rightBtnClickBlock)(UIButton *sender);

@end
