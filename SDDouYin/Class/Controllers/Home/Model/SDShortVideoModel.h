//
//  SDShortVideoModel.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/20.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseModel.h"

@interface SDShortVideoModel : SDBaseModel

@property (nonatomic,copy)  NSString *videoUrl;
@property (nonatomic,copy)  NSString *imageUrl;
@property (nonatomic,assign)  NSInteger likeNum;
@property (nonatomic,assign)  NSInteger commentNum;
@property (nonatomic,assign)  NSInteger shareNum;
@end
