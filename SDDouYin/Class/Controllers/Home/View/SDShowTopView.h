//
//  SDShowTopView.h
//  SDInKe
//
//  Created by slowdony on 2018/1/31.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDShowTopView : UIView

@property (nonatomic,strong) NSMutableArray *btnsArr;//
@property (nonatomic,assign) CGFloat selectIndex;//当前选择哪一个;

@property (nonatomic,copy) void (^selectBtnBlock)(UIButton * selectBtn);
@end
