//
//  SDHeadViewConfig.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDHeadViewConfig : NSObject

typedef NS_ENUM(NSInteger,HeadViewType){
    HeadViewTypeMe, //我的
    HeadViewTypeOther //别人
};
///头部view类型
@property (nonatomic,assign) HeadViewType headViewType;


@end
