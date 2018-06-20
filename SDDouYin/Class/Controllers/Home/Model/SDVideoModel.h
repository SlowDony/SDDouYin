//
//  SDVideoModel.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/20.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDUrl :NSObject
@property (nonatomic,strong) NSArray *urlList;
@property (nonatomic,copy) NSString *uri;
@end

@interface SDVideoModel : NSObject

@property (nonatomic,strong)SDUrl * cover;
@property (nonatomic,strong)SDUrl * playAddr;

@end
