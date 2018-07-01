//
//  SDBaseModel.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/20.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDExtra : NSObject
@property (nonatomic, copy) NSString * logid;
@property (nonatomic, assign) NSInteger now;
@property (nonatomic, strong) NSArray * fatalItemIds;
@end

@interface SDBaseModel : NSObject

@property (nonatomic, strong) SDExtra * extra;
@property (nonatomic, assign) NSInteger statusCode;

@end
