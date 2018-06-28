//
//  SDAnimationTool.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/28.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDAnimationTool.h"

@implementation SDAnimationTool

+(instancetype)shareAnimationTool{
    static SDAnimationTool *animationTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animationTool = [[SDAnimationTool alloc]init];
    });
    return animationTool;
}

/**
 点击屏幕点赞动画
 
 @param touches 触摸点
 @param event 事件
 */
- (void)showLargeLikeAnimationWithTouch:(NSSet<UITouch *>*)touches withEvent:(UIEvent *)event{
    NSSet *allTouchs = [event allTouches];
    UITouch *touch = [allTouchs anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    //
    UIImage *likeImage = [UIImage imageNamed:@"image_bigLike"];
    UIImageView *likeImageView = [[UIImageView alloc] init];
    likeImageView.frame = CGRectMake(0, 0, likeImage.size.width, likeImage.size.height);
    likeImageView.image = likeImage;
    likeImageView.center = point;
   
    
    int angle = arc4random()%2;
    angle = angle ? angle :-1;
    likeImageView.transform = CGAffineTransformRotate(likeImageView.transform, M_PI/9*angle);
    [[touch view] addSubview:likeImageView];
    __block UIImageView *bgImageView = likeImageView;
    
    [UIView animateWithDuration:0.2 animations:^{
        bgImageView.transform = CGAffineTransformScale(bgImageView.transform, 1.2, 1.2);
    } completion:^(BOOL finished) {
        bgImageView.transform = CGAffineTransformScale(bgImageView.transform, 0.8,0.8);
        [self performSelector:@selector(animationFlyTop:) withObject:bgImageView afterDelay:1.1];
    }];
}

- (void)animationFlyTop:(UIImageView *)imageView{
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect orginImageFrame = imageView.frame;
        orginImageFrame.origin.y -=100;
        imageView.frame = orginImageFrame;
        imageView.transform = CGAffineTransformScale(imageView.transform, 1.8,1.8);
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
         [imageView removeFromSuperview];
    }];
    
   
}

/**
 点击先变大在缩回原来尺寸
 
 @param view view
 */
- (void)showMakeScaleAnimationWithView:(UIView *)view{
    
    [UIView animateWithDuration:0.2 animations:^{
        view.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformIdentity;
        }];
    }];
}

@end
