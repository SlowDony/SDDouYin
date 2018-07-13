//
//  SDBaseNavigationController.h
//  miaohu
//
//  Created by Megatron Joker on 2017/3/3.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol SDBaseNavigationControllerDelegate <NSObject>
@optional
- (void)LeftButtonPress:(id)sender;
- (void)RightButtonPress:(id)sender;

@end
@interface SDBaseNavigationController : UINavigationController<UIGestureRecognizerDelegate>
@property (nonatomic,retain) id<SDBaseNavigationControllerDelegate> customdelegate;
@property (nonatomic,retain) UIImageView * backImageView;
@property (nonatomic,retain) UIButton * leftNavButton;
@property (nonatomic,retain) UIButton * rightNavButton;
@property (nonatomic,retain) UILabel * titleLabel;

- (UIStatusBarStyle)preferredStatusBarStyle;

- (id)initWithRootViewController:(UIViewController *)rootViewController;
- (void )setupTitle:(NSString *)title;
- (void )setupTitle:(NSString *)title action:(SEL)selector target:(id) target;
- (void )setupTitle:(NSString *)title badge:(BOOL) hasBadge;

- (void) leftButtonWithTitle:(NSString *)title action:(SEL) selector onTarget:(id) target;
- (void) leftButtonWithImage:(UIImage *)image action:(SEL) selector onTarget:(id) target;
- (void) leftButtonWithImage:(UIImage *)image size:(CGSize) size action:(SEL) selector target:(id) target;
- (void) leftButtonWithImage:(UIImage *)image highlightImage:(UIImage *)hlImage size:(CGSize) size action:(SEL) selector target:(id) target;

- (void) rightButtonWithTitle:(NSString *)title action:(SEL) selector onTarget:(id) target;
- (void) rightButtonWithImage:(UIImage *)image action:(SEL) selector onTarget:(id) target;
- (void) rightButtonWithImage:(UIImage *)image size:(CGSize) size action:(SEL) selector target:(id) target;
- (void) rightButtonWithImage:(UIImage *)image highlightImage:(UIImage *)hlImage size:(CGSize) size action:(SEL) selector target:(id) target;

- (void) setBackImage:(UIImage *) image;

@end
