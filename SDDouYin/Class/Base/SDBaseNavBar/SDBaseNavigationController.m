//
//  SDBaseNavigationController.m
//  miaohu
//
//  Created by Megatron Joker on 2017/3/3.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDBaseNavigationController.h"

@interface SDBaseNavigationController ()

@end

@implementation SDBaseNavigationController


- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        
        [self setBackImage:nil];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count>0){
        
        viewController.navigationItem.leftBarButtonItem= [UIBarButtonItem itemTarget:self WithAction:@selector(backItem) andImage:@"alimember_navbar_left" andSelectImage:@""];
        viewController.hidesBottomBarWhenPushed=YES;
        
    }
    
    [super pushViewController:viewController animated:YES];
}

-(void)backItem{
    [self popViewControllerAnimated:YES];
}

#pragma mark - title
- (void )setupTitle:(NSString *)title
{
    [self setupTitle:title badge:NO];
}

- (void )setupTitle:(NSString *)title badge:(BOOL) hasBadge
{
    float titleWhidth = 0;
    if (title && title.length > 0)
    {
        titleWhidth =  [SDHelper longFloatWithstring:title andHeight:44 andSize:20] + 10;
    }
    self.titleLabel = [SDHelper labelBulidWithText:title
                                       andFontSize:17
                                      andTextColor:KNavigationTitleColor
                                andBackgroundColor:nil
                                           andFram:CGRectMake((SCREEN_WIDTH - titleWhidth)/2, 0,titleWhidth, 44)
                                      andAlignment:NSTextAlignmentCenter
                                   testBorderWidth:NO];
    self.titleLabel.font =[UIFont systemFontOfSize:17];
    if([self.viewControllers lastObject])
    {
        UIViewController * vc = [self.viewControllers lastObject];
        vc.navigationItem.titleView = self.titleLabel;
        [vc.navigationItem setTitle:title];
    }
    
}

- (void )setupTitle:(NSString *)title action:(SEL) selector target:(id) target
{
    UIButton *button = [self buttonBuilder:CGRectMake(0, 0, 120, 44) title:title alignment:NSTextAlignmentCenter target:(id)target action:(SEL)selector normalImage:nil highlightImage:nil];
    
    if([self.viewControllers lastObject])
    {
        UIViewController * vc = [self.viewControllers lastObject];
        vc.navigationItem.titleView = button;
    }
}

#pragma mark - left button
- (void)LeftButton:(id)sender
{
    if ([_customdelegate respondsToSelector:@selector(LeftButtonPress:)])
    {
        [_customdelegate LeftButtonPress:sender];
    }
}
- (void )leftButtonWithImage:(UIImage *)image action:(SEL) selector onTarget:(id) target
{
    if (image)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 20, 20);
        btn.backgroundColor = [UIColor clearColor];
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        self.leftNavButton = btn;
        
        UIBarButtonItem *sendButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.leftNavButton];
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            vc.navigationItem.leftBarButtonItem = sendButtonItem;
        }
    }
    else
    {
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            [vc.navigationItem.leftBarButtonItem.customView setHidden:YES];
        }
    }
    
}


- (void )leftButtonWithImage:(UIImage *)image size:(CGSize) size action:(SEL) selector target:(id) target
{
    if (image)
    {
        self.leftNavButton = [self buttonBuilder:CGRectMake(0,0,size.width, size.height) title:nil alignment:NSTextAlignmentCenter target:(id)target action:(SEL)selector normalImage:image highlightImage:nil];
        
        UIBarButtonItem *sendButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.leftNavButton];
        
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            vc.navigationItem.leftBarButtonItem = sendButtonItem;
        }
    }
    else
    {
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            [vc.navigationItem.leftBarButtonItem.customView setHidden:YES];
        }
    }
}

- (void )leftButtonWithTitle:(NSString *)title action:(SEL) selector onTarget:(id) target
{
    if (title)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, -1, 60, 44);
        btn.backgroundColor = [UIColor clearColor];
        UIImage *bgimg =  [[UIImage imageNamed:@"topbar_l_pressed.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        [bgimg drawInRect:CGRectMake(0, 0, 42, 44)];
        [btn setBackgroundImage:bgimg forState:UIControlStateHighlighted];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.frame = CGRectMake(42, -1, 3, 50);
        line.backgroundColor = [UIColor clearColor];
        line.image = [UIImage imageNamed:@"topbar_line.png"];
        [btn addSubview:line];
        self.leftNavButton = btn;
        UIBarButtonItem *sendButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.leftNavButton];
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            vc.navigationItem.leftBarButtonItem = sendButtonItem;
        }
    }
    else
    {
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            [vc.navigationItem.leftBarButtonItem.customView setHidden:YES] ;
        }
    }
}

- (void) leftButtonWithImage:(UIImage *)image highlightImage:(UIImage *)hlImage size:(CGSize) size action:(SEL) selector target:(id) target
{
    if (image)
    {
        self.leftNavButton = [self buttonBuilder:CGRectMake(0,0,size.width, size.height) title:nil alignment:NSTextAlignmentCenter target:(id)target action:(SEL)selector normalImage:image highlightImage:hlImage];
        UIBarButtonItem *sendButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.leftNavButton];
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            vc.navigationItem.leftBarButtonItem = sendButtonItem;
        }
    }
    else
    {
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            [vc.navigationItem.leftBarButtonItem.customView setHidden:YES];
        }
    }
}

#pragma mark - right button

- (void )rightButtonWithTitle:(NSString *)title action:(SEL)selector onTarget:(id)target
{
    if (title)
    {
        UIButton *btn = [SDHelper buttonBuildWithTitle:title
                                             textColor:[UIColor whiteColor]
                                             tintColor:nil
                                       backgroundColor:nil
                                                 frome:CGRectMake(0, 0, 40, 30)
                                       testBorderWidth:NO];
        
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        self.rightNavButton = btn;
        UIBarButtonItem *sendButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightNavButton];
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            vc.navigationItem.rightBarButtonItem = sendButtonItem;
        }
        
    }
    else
    {
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            [vc.navigationItem.rightBarButtonItem.customView setHidden:YES];
        }
    }
}
- (void )rightButtonWithImage:(UIImage *)image size:(CGSize) size action:(SEL) selector target:(id) target
{
    if (image)
    {
        self.rightNavButton = [self buttonBuilder:CGRectMake(0,0,size.width, size.height) title:nil alignment:NSTextAlignmentCenter target:(id)target action:(SEL)selector normalImage:image highlightImage:nil];
        
        UIBarButtonItem *sendButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightNavButton];
        
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            vc.navigationItem.rightBarButtonItem = sendButtonItem;
        }
    }
    else
    {
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            [vc.navigationItem.rightBarButtonItem.customView setHidden:YES];
        }
    }
}

- (void )rightButtonWithImage:(UIImage *)image action:(SEL) selector onTarget:(id) target
{
    if (image)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, -1, 30, 44);
        btn.backgroundColor = [UIColor clearColor];
        
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        
        self.rightNavButton = btn;
        UIBarButtonItem *sendButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightNavButton];
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            vc.navigationItem.rightBarButtonItem = sendButtonItem;
        }
    }
    else
    {
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            [vc.navigationItem.rightBarButtonItem.customView setHidden:YES] ;
        }
    }
}

- (void) rightButtonWithImage:(UIImage *)image highlightImage:(UIImage *)hlImage size:(CGSize) size action:(SEL) selector target:(id) target
{
    if (image)
    {
        self.rightNavButton = [self buttonBuilder:CGRectMake(0,0,size.width, size.height) title:nil alignment:NSTextAlignmentCenter target:(id)target action:(SEL)selector normalImage:image highlightImage:hlImage];
        
        UIBarButtonItem *sendButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightNavButton];
        
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            vc.navigationItem.rightBarButtonItem = sendButtonItem;
        }
    }
    else
    {
        if([self.viewControllers lastObject])
        {
            UIViewController * vc = [self.viewControllers lastObject];
            [vc.navigationItem.rightBarButtonItem.customView setHidden:YES];
        }
    }
}


- (void)RightButton:(id)sender {
    if ([_customdelegate respondsToSelector:@selector(RightButtonPress:)]) {
        [_customdelegate RightButtonPress:sender];
    }
}

- (UIButton *)buttonBuilder:(CGRect)frame title:title alignment:(NSTextAlignment) alignment target:(id)target action:(SEL)action normalImage:(UIImage*)normalImage highlightImage:(UIImage*)highlightImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (title && [title length] > 0)
    {
        UILabel *lbl = [[UILabel alloc] init];
        lbl.frame = button.bounds;
        //    lbl.center = CGPointMake(160, 25);
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textAlignment = alignment;
        lbl.font = [UIFont systemFontOfSize:20];
        lbl.textColor = KNavigationTitleColor;
        lbl.text = title;
        //    [lbl sizeToFit];
        [button addSubview:lbl];
    }
    
    return button;
}


#pragma mark - setup the background image

-(void) setBackImage:(UIImage *) image
{
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *backgroundImage = nil;
    if(image)
    {
        // backgroundImage =  [self scaleToSize:image size:titleSize];//设置图片的大小与Navigation Bar相同
    }
    else
    {
        backgroundImage = [UIImage sd_imageWithColor:KNavigationBarBackgroundColor];
        backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    }
    
    if (self.backImageView)
    {
        [self.backImageView removeFromSuperview];
    }
    self.backImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    if(systemVersion >= 5.0)
    {
        [self.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];  //设置背景
        self.navigationBar.shadowImage = [UIImage new];
    }
    else
    {
        [self.navigationBar insertSubview:self.backImageView atIndex:1];
    }
    
}


//调整图片大小
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
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
