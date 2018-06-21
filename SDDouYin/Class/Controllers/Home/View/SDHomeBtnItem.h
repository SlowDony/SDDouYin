//
//  SDHomeBtnItem.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/7.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HomeBtnItemWidth 70
#define HomeBtnItemHeight 70
#define HomeHeadImageViewWidth 50
#define HomeHandleBtnWidth 42



@interface SDHomeMusicView :UIView

@property (nonatomic,strong)  UIButton *musicImageBtn;

@end

typedef NS_ENUM(NSInteger ,HomeBtnItemType){
    HomeBtnItemHead = 100, //头像试图
    HomeBtnItemBtns = 101, //按钮试图
    HomeBtnItemMusic = 102, //音乐封面转动
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
