//
//  ZFVolumeBrightnessView.h
//  ZFPlayer
//
//  Created by 紫枫 on 2018/5/23.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZFVolumeBrightnessType) {
    ZFVolumeBrightnessTypeVolume,       // volume
    ZFVolumeBrightnessTypeumeBrightness // brightness
};

@interface ZFVolumeBrightnessView : UIView

@property (nonatomic, assign, readonly) ZFVolumeBrightnessType volumeBrightnessType;

- (void)updateProgress:(CGFloat)progress withVolumeBrightnessType:(ZFVolumeBrightnessType)volumeBrightnessType;

@end
