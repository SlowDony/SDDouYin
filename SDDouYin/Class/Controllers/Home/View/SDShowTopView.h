//
//  SDShowTopView.h
//  SDInKe
//
//  Created by slowdony on 2018/1/31.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SDShowTitleView :UIView

///标题数组
@property (nonatomic,strong) NSMutableArray *btnsArr;
///当前选择哪一个
@property (nonatomic,assign) CGFloat selectIndex;
///标题按钮点击
@property (nonatomic,copy) void (^selectBtnBlock)(UIButton * selectBtn);

@end

@interface SDShowTopView : UIView

///当前选择哪一个
@property (nonatomic,assign) CGFloat selectIndex;

///标题按钮点击
@property (nonatomic,copy) void (^selectBtnBlock)(UIButton * selectBtn);
///搜索按钮点击
@property (nonatomic,copy) void (^searchBtnBlock)(UIButton * searchBtn);
///头像按钮点击
@property (nonatomic,copy) void (^headImageBtnBlock)(void);


///设置标题
- (void)setTopTitleArr:(NSArray *)titleArr;
@end
