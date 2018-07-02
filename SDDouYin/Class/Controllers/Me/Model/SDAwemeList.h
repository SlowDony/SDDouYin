//
//  SDAwemeList.h
//  SDDouYin
//
//  Created by slowdony on 2018/7/2.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseModel.h"
#import "SDAweme.h"
@interface SDAwemeList : SDBaseModel
@property (nonatomic, strong) NSArray <SDAweme *>* awemeList;
@end
