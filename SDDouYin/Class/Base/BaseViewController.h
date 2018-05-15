//
//  BaseViewController.h
//  SDDouYin
//
//  Created by slowdony on 2018/5/15.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/* ------------------  分页相关  ------------------ */
@property(nonatomic, assign)int pageSize;               //每页显示数量
@property(nonatomic, strong)NSString *pageLastID;       //下次请求起始id


- (void) setupTitleView:(NSString*) title;
- (void) setupTitle:(NSString *)title action:(SEL)selector target:(id) target;
- (void) setupTitle:(NSString *)title badge:(BOOL) hasBadge;

- (void) setupLeftButton:(UIButton*) btn;
- (void) setupRightButton:(UIButton*) btn;

- (void) setupSecondTitleView:(NSString*) title;
- (void) didTapBackButton:(id)sender;

- (void) setupTitle:(NSString *)title;

- (void) rightButtonWithTitle:(NSString *)title action:(SEL) selector onTarget:(id) target;
- (void) rightButtonWithImage:(UIImage *)image action:(SEL) selector onTarget:(id) target;
- (void) rightButtonWithImage:(UIImage *)image hlImage:(UIImage *) hlImage action:(SEL) selector onTarget:(id) target;

- (void) leftButtonWithTitle:(NSString *)title action:(SEL) selector onTarget:(id) target;
- (void) leftButtonWithImage:(UIImage *)image action:(SEL) selector onTarget:(id) target;
- (void) leftButtonWithImage:(UIImage *)image hlImage:(UIImage *) hlImage action:(SEL) selector onTarget:(id) target;
@end
