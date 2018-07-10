//
//  SDBaseHandler.h
//  SDInKe
//
//  Created by slowdony on 2018/4/14.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDBaseHandler : NSObject

/**
 *  Handler处理完成后调用的Block
 */
typedef void (^CompleteBlock)(void);

/**
 *  Handler处理成功时调用的Block
 */
typedef void (^SuccessBlock)(id obj);

/**
 *  Handler处理失败时调用的Block
 */
typedef void (^FailedBlock)(id obj);


/**
 假装请求网络数据

 @param jsonName json
 @return 返回json字典
 */
+ (NSDictionary *)getJsonFile:(NSString *)jsonName;
@end
