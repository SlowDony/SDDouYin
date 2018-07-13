//
//  SDFocusTool.h
//  
//
//  Created by slowdony on 2018/7/13.
//

#import "SDBaseHandler.h"
#import "SDFollowFeedModel.h"
@interface SDFocusTool : SDBaseHandler


+ (void)getFollowFeedSuccess:(SuccessBlock)success failed:(FailedBlock )failed;
@end
