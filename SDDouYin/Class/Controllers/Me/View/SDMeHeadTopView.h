//
//  SDMeHeadTopView.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger ,TopViewType){
    TopViewTypeMe, //我的
    TopViewTypeOther //别人的
};

@interface SDMeHeadTopView : UIView


@property (nonatomic,assign)  TopViewType topViewType;
@property (nonatomic,strong)  UIButton *pointBtn;
@property (nonatomic,strong)  UIButton *addBtn;
@property (nonatomic,strong)  UIButton *followBtn;

///sendertag ==1000.获赞 tag ==2000.粉丝 tag ==3000关注
@property (nonatomic,copy)  void (^topViewBtnClickBlock) (UIButton *sender);
@end
