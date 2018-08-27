//
//  ZFSmallFloatControlView.h
//  ZFPlayer
//
//  Created by 紫枫 on 2018/5/16.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFSmallFloatControlView : UIView

@property (nonatomic, copy, nullable) void(^closeClickCallback)(void);

- (void)showControlView;

- (void)hideControlView;

@end
