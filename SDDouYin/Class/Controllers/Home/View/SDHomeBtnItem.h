//
//  SDHomeBtnItem.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/7.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HomeBtnItemWidth 70
#define HomeBtnItemHeight 80
#define HomeHeadImageViewWidth 50
#define HomeHandleBtnWidth 42

typedef NS_ENUM(NSInteger ,HomeBtnItemType){
    HomeBtnItemHead = 0, //头像试图
    HomeBtnItemOther ,   //其他试图
};

@interface SDHomeBtnItem : UIView

@property (nonatomic,assign) HomeBtnItemType homeBtnType;


///头像
@property (nonatomic,strong)  UIImageView *headImageView;
///关注按钮
@property (nonatomic,strong)  UIButton *focusBtn;


///按钮
@property (nonatomic,strong)  UIButton *handleBtn;
///数量
@property (nonatomic,strong)  UILabel  *numLabel;

- (instancetype)initWithType:(HomeBtnItemType )itemType;
@end
