//
//  SDBaseLeftSlidingViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/6/26.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseLeftSlidingViewController.h"
#import "SDLeftSlidingAnimation.h"
@interface SDBaseLeftSlidingViewController ()
<UINavigationControllerDelegate,
UIGestureRecognizerDelegate
>


/**
 这个类的对象会根据我们的手势，来决定我们的自定义过渡的完成度
 */
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;
@end

@implementation SDBaseLeftSlidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureClick:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    self.navigationController.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)panGestureClick:(UIPanGestureRecognizer *)gestureRecognizer{
    /*调用UIPercentDrivenInteractiveTransition的updateInteractiveTransition:方法可以控制转场动画进行到哪了，
     当用户的下拉手势完成时，调用finishInteractiveTransition或者cancelInteractiveTransition，UIKit会自动执行剩下的一半动画，
     或者让动画回到最开始的状态。*/
    if ([gestureRecognizer translationInView:self.view].x < 0) {
        //手势滑动的比例
        double progress = [gestureRecognizer translationInView:self.view].x / (self.view.bounds.size.width);
        progress = MIN(1.0,(MAX(0.0, fabs(progress))));
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            [self.interactiveTransition updateInteractiveTransition:0];
            if ([self pushPersonalInfoViewController]) {
                //                if (![self.navigationController.delegate isEqual:self]) {
                //                    self.navigationController.delegate = self;
                //                }
            }
        } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
            [self.interactiveTransition updateInteractiveTransition:progress];
        } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled){
            if([gestureRecognizer translationInView:self.view].x == 0){
                [self.interactiveTransition cancelInteractiveTransition];
                _interactiveTransition = nil;
            }else if (progress > 0.5) {
                
                [self.interactiveTransition finishInteractiveTransition];
                
            }else{
                
                [self.interactiveTransition cancelInteractiveTransition];
            }
            _interactiveTransition = nil;
            //            if ([self.navigationController.delegate isEqual:self]) {
            //                self.navigationController.delegate = nil;
            //            }
        }
        
        
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        [self.interactiveTransition updateInteractiveTransition:0];
        [self.interactiveTransition cancelInteractiveTransition];
    } else if ((gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled)){
        _interactiveTransition = nil;
    }
    
}

- (BOOL)pushPersonalInfoViewController{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation ==UINavigationControllerOperationPush){
        return [SDLeftSlidingAnimation new];
    }
    return nil;
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if(_interactiveTransition){
        return _interactiveTransition;
    }else{
        return nil;
    }
}

#pragma mark - UIGestureRecognizerDelegate
//开始进行手势识别时调用的方法，返回NO则结束识别，不再触发手势，用处：可以在控件指定的位置使用手势识别
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer velocityInView:gestureRecognizer.view];
    if (translation.x < 0) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - lazy
- (UIPercentDrivenInteractiveTransition *)interactiveTransition{
    if (!_interactiveTransition){
        _interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        _interactiveTransition.completionCurve = UIViewAnimationCurveEaseInOut;
    }
    return _interactiveTransition;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
