//
//  SDAwemeFeedModel.h
//  SDDouYin
//
//  Created by slowdony on 2018/7/8.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseModel.h"
#import "SDAweme.h"

@interface SDAwemeFeedModel : SDBaseModel
@property (nonatomic, strong) NSArray <SDAweme *>* awemeList;
@property (nonatomic, assign) NSInteger refreshClear;
@property (nonatomic, strong) NSString * rid;
@property (nonatomic, assign) NSInteger homeModel;

@end
