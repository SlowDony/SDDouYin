//
//  ZFPlayer.m
//  ZFPlayer
//
// Copyright (c) 2016年 任子丰 ( http://github.com/renzifeng )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ZFPlayerController.h"
#import <objc/runtime.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ZFPlayerNotification.h"
#import "UIScrollView+ZFPlayer.h"
#import "ZFReachabilityManager.h"
#import "ZFPlayer.h"

@interface ZFPlayerController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) ZFPlayerNotification *notification;
@property (nonatomic, strong) id<ZFPlayerMediaPlayback> currentPlayerManager;
@property (nonatomic, strong, nullable) UIScrollView *scrollView;
@property (nonatomic, assign, getter=isPauseByUser) BOOL pauseByUser;
@property (nonatomic, strong) UISlider *volumeViewSlider;
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) NSTimeInterval totalTime;
@property (nonatomic, assign) NSTimeInterval bufferTime;

@end

@implementation ZFPlayerController

- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self)
        [[ZFReachabilityManager sharedManager] startMonitoring];
        [[ZFReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(ZFReachabilityStatus status) {
            @strongify(self)
            if ([self.controlView respondsToSelector:@selector(videoPlayer:reachabilityChanged:)]) {
                [self.controlView videoPlayer:self reachabilityChanged:status];
            }
        }];
        [self configureVolume];
    }
    return self;
}

/// Get system volume
- (void)configureVolume {
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    self.volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            self.volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    // Apps using this category don't mute when the phone's mute button is turned on, but play sound when the phone is silent
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

- (void)dealloc {
    [self.currentPlayerManager stop];
}

+ (instancetype)playerWithPlayerManager:(id<ZFPlayerMediaPlayback>)playerManager containerView:(nonnull UIView *)containerView {
    ZFPlayerController *player = [[self alloc] init];
    player.currentPlayerManager = playerManager;
    player.containerView = containerView;
    return player;
}

+ (instancetype)playerWithScrollView:(UIScrollView *)scrollView playerManager:(id<ZFPlayerMediaPlayback>)playerManager containerViewTag:(NSInteger)containerViewTag {
    ZFPlayerController *player = [[self alloc] init];
    player.scrollView = scrollView;
    player.currentPlayerManager = playerManager;
    player.containerViewTag = containerViewTag;
    return player;
}

- (instancetype)initWithPlayerManager:(id<ZFPlayerMediaPlayback>)playerManager containerView:(nonnull UIView *)containerView {
    ZFPlayerController *player = [self init];
    player.currentPlayerManager = playerManager;
    player.containerView = containerView;
    return player;
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView playerManager:(id<ZFPlayerMediaPlayback>)playerManager containerViewTag:(NSInteger)containerViewTag {
    ZFPlayerController *player = [self init];
    player.scrollView = scrollView;
    player.currentPlayerManager = playerManager;
    player.containerViewTag = containerViewTag;
    return player;
}

- (void)playerManagerCallbcak {
    @weakify(self)
    self.currentPlayerManager.playerPlayTimeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSTimeInterval currentTime, NSTimeInterval duration) {
        @strongify(self)
        self.currentTime = currentTime;
        self.totalTime = duration;
        if ([self.controlView respondsToSelector:@selector(videoPlayer:currentTime:totalTime:)]) {
            [self.controlView videoPlayer:self currentTime:currentTime totalTime:duration];
        }
    };
    
    self.currentPlayerManager.playerBufferTimeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSTimeInterval bufferTime) {
        @strongify(self)
        self.bufferTime = bufferTime;
        if ([self.controlView respondsToSelector:@selector(videoPlayer:bufferTime:)]) {
            [self.controlView videoPlayer:self bufferTime:bufferTime];
        }
    };
    
    self.currentPlayerManager.playerPrepareToPlay = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSURL * _Nonnull assetURL) {
        @strongify(self)
        if ([self.controlView respondsToSelector:@selector(videoPlayer:prepareToPlay:)]) {
            [self.controlView videoPlayer:self prepareToPlay:self.currentPlayerManager.assetURL];
        }
    };
    
    self.currentPlayerManager.playerPlayStatChanged = ^(id  _Nonnull asset, ZFPlayerPlaybackState playState) {
        @strongify(self)
        if ([self.controlView respondsToSelector:@selector(videoPlayer:playStateChanged:)]) {
            [self.controlView videoPlayer:self playStateChanged:playState];
        }
    };
    
    self.currentPlayerManager.playerLoadStatChanged = ^(id  _Nonnull asset, ZFPlayerLoadState loadState) {
        @strongify(self)
        if ([self.controlView respondsToSelector:@selector(videoPlayer:loadStateChanged:)]) {
            [self.controlView videoPlayer:self loadStateChanged:loadState];
        }
    };
    
    self.currentPlayerManager.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        if (self.playerDidToEnd) self.playerDidToEnd(asset);
        if ([self.controlView respondsToSelector:@selector(videoPlayerPlayEnd:)]) {
            [self.controlView videoPlayerPlayEnd:self];
        }
    };
}

- (void)layoutPlayerSubViews {
    self.containerView.userInteractionEnabled = YES;
    [self.containerView addSubview:self.currentPlayerManager.view];
    [self.currentPlayerManager.view addSubview:self.controlView];
    
    self.currentPlayerManager.view.frame = self.controlView.bounds;
    self.currentPlayerManager.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.controlView.frame = self.currentPlayerManager.view.bounds;
    self.controlView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark - getter

- (ZFPlayerNotification *)notification {
    if (!_notification) {
        _notification = [[ZFPlayerNotification alloc] init];
        @weakify(self)
        _notification.willResignActive = ^(ZFPlayerNotification * _Nonnull registrar) {
            @strongify(self)
            if (self.pauseWhenAppResignActive && self.currentPlayerManager.isPlaying) {
                [self.currentPlayerManager pause];
                self.pauseByUser = YES;
            }
        };
        _notification.didBecomeActive = ^(ZFPlayerNotification * _Nonnull registrar) {
            @strongify(self)
            if (self.isPauseByUser) {
                [self.currentPlayerManager play];
                self.pauseByUser = NO;
            }
        };
        _notification.oldDeviceUnavailable = ^(ZFPlayerNotification * _Nonnull registrar) {
            @strongify(self)
            if (self.currentPlayerManager.isPlaying) {
                [self.currentPlayerManager play];
            }
        };
    }
    return _notification;
}

#pragma mark - setter

- (void)setCurrentPlayerManager:(id<ZFPlayerMediaPlayback>)currentPlayerManager {
    if (!currentPlayerManager) return;
    _currentPlayerManager = currentPlayerManager;
    self.gestureControl.disableTypes = self.disableGestureTypes;
    [self.gestureControl addGestureToView:currentPlayerManager.view];
    [self playerManagerCallbcak];
    [self.notification addNotification];
}

- (void)setContainerView:(UIView *)containerView {
    if (!containerView) return;
    _containerView = containerView;
    containerView.userInteractionEnabled = YES;
    [containerView addSubview:self.currentPlayerManager.view];
    self.currentPlayerManager.view.frame = containerView.bounds;
    self.currentPlayerManager.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.orientationObserver addDeviceOrientationObserver];
}

- (void)setControlView:(UIView<ZFPlayerMediaControl> *)controlView {
    if (!controlView) return;
    _controlView = controlView;
    [self.currentPlayerManager.view addSubview:controlView];
    controlView.frame = self.currentPlayerManager.view.bounds;
    controlView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

@end

@implementation ZFPlayerController (ZFPlayerTimeControl)

- (float)progress {
    if (self.totalTime == 0) return 0;
    return self.currentTime/self.totalTime;
}

- (float)bufferProgress {
    if (self.totalTime == 0) return 0;
    return self.bufferTime/self.totalTime;
}

- (void)seekToTime:(NSTimeInterval)time completionHandler:(void (^)(BOOL))completionHandler {
    [self.currentPlayerManager seekToTime:time completionHandler:completionHandler];
}

@end

@implementation ZFPlayerController (ZFPlayerPlaybackControl)

- (void)stop {
    [self.notification removeNotification];
    [self.orientationObserver removeDeviceOrientationObserver];
    [self.currentPlayerManager stop];
    [self.currentPlayerManager.view removeFromSuperview];
}

- (void)replaceCurrentPlayerManager:(id<ZFPlayerMediaPlayback>)manager {
    if (self.currentPlayerManager.isPreparedToPlay) {
        [self.notification removeNotification];
        [self.orientationObserver removeDeviceOrientationObserver];
        [self stop];
    }
    [self.gestureControl removeGestureToView:self.currentPlayerManager.view];
    self.currentPlayerManager = manager;
    [self layoutPlayerSubViews];
}

- (void)playTheNext {
    NSInteger index = self.currentPlayIndex + 1;
    if (index >= self.assetURLs.count) return;
    NSURL *assetURL = [self.assetURLs objectAtIndex:index];
    [self.currentPlayerManager replaceCurrentAssetURL:assetURL];
    self.currentPlayIndex = [self.assetURLs indexOfObject:assetURL];
}

- (void)playThePrevious {
    NSInteger index = self.currentPlayIndex - 1;
    if (index < 0) return;
    NSURL *assetURL = [self.assetURLs objectAtIndex:index];
    [self.currentPlayerManager replaceCurrentAssetURL:assetURL];
    self.currentPlayIndex = [self.assetURLs indexOfObject:assetURL];
}

- (void)playTheIndex:(NSInteger)index {
    if (index >= self.assetURLs.count) return;
    NSURL *assetURL = [self.assetURLs objectAtIndex:index];
    [self.currentPlayerManager replaceCurrentAssetURL:assetURL];
    self.currentPlayIndex = index;
}

#pragma mark - getter

- (BOOL)isWWANAutoPlay {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) return number.boolValue;
    self.WWANAutoPlay = YES;
    return YES;
}

- (float)brightness {
    return [UIScreen mainScreen].brightness;
}

- (float)volume {
    CGFloat volume = self.volumeViewSlider.value;
    if (volume == 0) {
        volume = [[AVAudioSession sharedInstance] outputVolume];
    }
    return volume;
}

- (BOOL)isMuted {
    return self.volume == 0;
}

- (float)lastVolumeValue {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (ZFPlayerPlaybackState)playState {
    return self.currentPlayerManager.playState;
}

- (BOOL)isPlaying {
    return self.currentPlayerManager.isPlaying;
}

- (BOOL)pauseWhenAppResignActive {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) return number.boolValue;
    self.pauseWhenAppResignActive = YES;
    return YES;
}

- (void (^)(id _Nonnull))playerDidToEnd {
    return objc_getAssociatedObject(self, _cmd);
}

- (NSInteger)currentPlayIndex {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

#pragma mark - setter

- (void)setWWANAutoPlay:(BOOL)WWANAutoPlay {
    objc_setAssociatedObject(self, @selector(isWWANAutoPlay), @(WWANAutoPlay), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.scrollView) self.scrollView.WWANAutoPlay = self.isWWANAutoPlay;
}

- (void)setVolume:(float)volume {
    volume = MIN(MAX(0, volume), 1);
    objc_setAssociatedObject(self, @selector(volume), @(volume), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.volumeViewSlider.value = volume;
}

- (void)setMuted:(BOOL)muted {
    if (muted) {
        self.lastVolumeValue = self.volumeViewSlider.value;
        self.volumeViewSlider.value = 0;
    } else {
        self.volumeViewSlider.value = self.lastVolumeValue;
    }
}

- (void)setLastVolumeValue:(float)lastVolumeValue {
    objc_setAssociatedObject(self, @selector(lastVolumeValue), @(lastVolumeValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBrightness:(float)brightness {
    brightness = MIN(MAX(0, brightness), 1);
    objc_setAssociatedObject(self, @selector(brightness), @(brightness), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [UIScreen mainScreen].brightness = brightness;
}

- (void)setPauseWhenAppResignActive:(BOOL)pauseWhenAppResignActive {
    objc_setAssociatedObject(self, @selector(pauseWhenAppResignActive), @(pauseWhenAppResignActive), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPlayerDidToEnd:(void (^)(id _Nonnull))playerDidToEnd {
    objc_setAssociatedObject(self, @selector(playerDidToEnd), playerDidToEnd, OBJC_ASSOCIATION_COPY);
}

- (void)setCurrentPlayIndex:(NSInteger)currentPlayIndex {
    objc_setAssociatedObject(self, @selector(currentPlayIndex), @(currentPlayIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation ZFPlayerController (ZFPlayerOrientationRotation)

- (void)addDeviceOrientationObserver {
    [self.orientationObserver addDeviceOrientationObserver];
}

- (void)removeDeviceOrientationObserver {
    [self.orientationObserver removeDeviceOrientationObserver];
}

- (void)enterLandscapeFullScreen:(UIInterfaceOrientation)orientation animated:(BOOL)animated {
    self.orientationObserver.fullScreenMode = ZFFullScreenModeLandscape;
    [self.orientationObserver enterLandscapeFullScreen:orientation animated:animated];
}

- (void)enterPortraitFullScreen:(BOOL)fullScreen animated:(BOOL)animated {
    self.orientationObserver.fullScreenMode = ZFFullScreenModePortrait;
    [self.orientationObserver enterPortraitFullScreen:fullScreen animated:YES];
}

- (void)enterFullScreen:(BOOL)fullScreen animated:(BOOL)animated {
    if (self.orientationObserver.fullScreenMode == ZFFullScreenModePortrait) {
        [self.orientationObserver enterPortraitFullScreen:fullScreen animated:YES];
    } else {
        UIInterfaceOrientation orientation =  UIInterfaceOrientationUnknown;
        orientation = fullScreen? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationPortrait;
        [self.orientationObserver enterLandscapeFullScreen:orientation animated:animated];
    }
}

#pragma mark - getter

- (ZFOrientationObserver *)orientationObserver {
    if (!self.currentPlayerManager.view && !self.containerView) return nil;
    @weakify(self)
    ZFOrientationObserver *orientationObserver = objc_getAssociatedObject(self, _cmd);
    if (!orientationObserver) {
        orientationObserver = [[ZFOrientationObserver alloc] initWithRotateView:self.currentPlayerManager.view containerView:self.containerView];
        orientationObserver.orientationWillChange = ^(ZFOrientationObserver * _Nonnull observer, BOOL isFullScreen) {
            @strongify(self)
            if (self.orientationWillChange) self.orientationWillChange(self, isFullScreen);
            if ([self.controlView respondsToSelector:@selector(videoPlayer:orientationWillChange:)]) {
                [self.controlView videoPlayer:self orientationWillChange:observer];
            }
            [self.controlView setNeedsLayout];
            [self.controlView layoutIfNeeded];
        };
        orientationObserver.orientationDidChanged = ^(ZFOrientationObserver * _Nonnull observer, BOOL isFullScreen) {
            @strongify(self)
            if (self.orientationDidChanged) self.orientationDidChanged(self, isFullScreen);
            if ([self.controlView respondsToSelector:@selector(videoPlayer:orientationDidChanged:)]) {
                [self.controlView videoPlayer:self orientationDidChanged:observer];
            }
        };
        objc_setAssociatedObject(self, _cmd, orientationObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return orientationObserver;
}

- (void (^)(ZFPlayerController * _Nonnull, BOOL))orientationWillChange {
    return objc_getAssociatedObject(self, _cmd);
}

- (void (^)(ZFPlayerController * _Nonnull, BOOL))orientationDidChanged {
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)isFullScreen {
    return self.orientationObserver.isFullScreen;
}

- (UIInterfaceOrientation)currentOrientation {
    return self.orientationObserver.currentOrientation;
}

- (BOOL)isStatusBarHidden {
    return self.orientationObserver.isStatusBarHidden;
}

- (BOOL)isLockedScreen {
    return self.orientationObserver.isLockedScreen;
}

#pragma mark - setter

- (void)setOrientationWillChange:(void (^)(ZFPlayerController * _Nonnull, BOOL))orientationWillChange {
    objc_setAssociatedObject(self, @selector(orientationWillChange), orientationWillChange, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setOrientationDidChanged:(void (^)(ZFPlayerController * _Nonnull, BOOL))orientationDidChanged {
    objc_setAssociatedObject(self, @selector(orientationDidChanged), orientationDidChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setStatusBarHidden:(BOOL)statusBarHidden {
    objc_setAssociatedObject(self, @selector(isStatusBarHidden), @(statusBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.orientationObserver.statusBarHidden = statusBarHidden;
}

- (void)setLockedScreen:(BOOL)lockedScreen {
    objc_setAssociatedObject(self, @selector(isLockedScreen), @(lockedScreen), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.orientationObserver.lockedScreen = lockedScreen;
    if ([self.controlView respondsToSelector:@selector(lockedVideoPlayer:lockedScreen:)]) {
        [self.controlView lockedVideoPlayer:self lockedScreen:lockedScreen];
    }
}

@end


@implementation ZFPlayerController (ZFPlayerViewGesture)

#pragma mark - getter

- (ZFPlayerGestureControl *)gestureControl {
//    if (!self.currentPlayerManager.view) return nil;
    ZFPlayerGestureControl *gestureControl = objc_getAssociatedObject(self, _cmd);
    if (!gestureControl) {
        gestureControl = [[ZFPlayerGestureControl alloc] init];
        @weakify(self)
        gestureControl.triggerCondition = ^BOOL(ZFPlayerGestureControl * _Nonnull control, ZFPlayerGestureType type, UIGestureRecognizer * _Nonnull gesture, UITouch *touch) {
            @strongify(self)
            if ([self.controlView respondsToSelector:@selector(gestureTriggerCondition:gestureType:gestureRecognizer:touch:)]) {
                return [self.controlView gestureTriggerCondition:control gestureType:type gestureRecognizer:gesture touch:touch];
            }
            return YES;
        };
        
        gestureControl.singleTapped = ^(ZFPlayerGestureControl * _Nonnull control) {
            @strongify(self)
            if ([self.controlView respondsToSelector:@selector(gestureSingleTapped:)]) {
                [self.controlView gestureSingleTapped:control];
            }
        };
        
        gestureControl.doubleTapped = ^(ZFPlayerGestureControl * _Nonnull control) {
            @strongify(self)
            if ([self.controlView respondsToSelector:@selector(gestureDoubleTapped:)]) {
                [self.controlView gestureDoubleTapped:control];
            }
        };
        
        gestureControl.beganPan = ^(ZFPlayerGestureControl * _Nonnull control, ZFPanDirection direction, ZFPanLocation location) {
            @strongify(self)
            if ([self.controlView respondsToSelector:@selector(gestureBeganPan:panDirection:panLocation:)]) {
                [self.controlView gestureBeganPan:control panDirection:direction panLocation:location];
            }
        };
        
        gestureControl.changedPan = ^(ZFPlayerGestureControl * _Nonnull control, ZFPanDirection direction, ZFPanLocation location, CGPoint velocity) {
            @strongify(self)
            if ([self.controlView respondsToSelector:@selector(gestureChangedPan:panDirection:panLocation:withVelocity:)]) {
                [self.controlView gestureChangedPan:control panDirection:direction panLocation:location withVelocity:velocity];
            }
        };
        
        gestureControl.endedPan = ^(ZFPlayerGestureControl * _Nonnull control, ZFPanDirection direction, ZFPanLocation location) {
            @strongify(self)
            if ([self.controlView respondsToSelector:@selector(gestureEndedPan:panDirection:panLocation:)]) {
                [self.controlView gestureEndedPan:control panDirection:direction panLocation:location];
            }
        };
        
        gestureControl.pinched = ^(ZFPlayerGestureControl * _Nonnull control, float scale) {
            @strongify(self)
            if ([self.controlView respondsToSelector:@selector(gesturePinched:scale:)]) {
                [self.controlView gesturePinched:control scale:scale];
            }
        };
        objc_setAssociatedObject(self, _cmd, gestureControl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gestureControl;
}

- (ZFPlayerDisableGestureTypes)disableGestureTypes {
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}

#pragma mark - setter

- (void)setDisableGestureTypes:(ZFPlayerDisableGestureTypes)disableGestureTypes {
    objc_setAssociatedObject(self, @selector(disableGestureTypes), @(disableGestureTypes), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.gestureControl.disableTypes = disableGestureTypes;
}

@end

@implementation ZFPlayerController (ZFPlayerScrollView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            NSSelectorFromString(@"dealloc")
        };
        
        for (NSInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"zf_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            Method originalMethod = class_getInstanceMethod(self, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
            if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    });
}

- (void)zf_dealloc {
    [self.smallFloatView removeFromSuperview];
    self.smallFloatView = nil;
    [self zf_dealloc];
}

//// Add video to the cell
- (void)addPlayerViewToCell {
    self.isSmallFloatViewShow = NO;
    self.smallFloatView.hidden = YES;
    UIView *cell = [self.scrollView zf_getCellForIndexPath:self.scrollView.playingIndexPath];
    self.containerView = [cell viewWithTag:self.containerViewTag];
    [self.containerView addSubview:self.currentPlayerManager.view];
    self.currentPlayerManager.view.frame = self.containerView.bounds;
    self.currentPlayerManager.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.orientationObserver cellModelRotateView:self.currentPlayerManager.view rotateViewAtCell:cell playerViewTag:self.containerViewTag];
}

/// Add to the keyWindow
- (void)addPlayerViewToKeyWindow {
    self.isSmallFloatViewShow = YES;
    self.smallFloatView.hidden = NO;
    [self.smallFloatView addSubview:self.currentPlayerManager.view];
    self.currentPlayerManager.view.frame = self.smallFloatView.bounds;
    [self.orientationObserver cellSmallModelRotateView:self.currentPlayerManager.view containerView:self.smallFloatView];
}

#pragma mark - setter

- (void)setScrollView:(UIScrollView *)scrollView {
    objc_setAssociatedObject(self, @selector(scrollView), scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.scrollView.WWANAutoPlay = self.isWWANAutoPlay;
    @weakify(self)
    scrollView.enableScrollHook = YES;
    scrollView.playerDidAppearInScrollView = ^(NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        if (self.isFullScreen) return;
        if ([self.controlView respondsToSelector:@selector(playerDidAppearInScrollView:)]) {
            [self.controlView playerDidAppearInScrollView:self];
        }
        if (!self.stopWhileNotVisible) {
            [self addPlayerViewToCell];
        }
    };
    
    scrollView.playerWillDisappearInScrollView = ^(NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        if (self.isFullScreen) return;
        if ([self.controlView respondsToSelector:@selector(playerWillDisappearInScrollView:)]) {
            [self.controlView playerWillDisappearInScrollView:self];
        }
    };
    
    scrollView.playerDisappearHalfInScrollView = ^(NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        if (self.isFullScreen) return;
        if ([self.controlView respondsToSelector:@selector(playerDisappearHalfInScrollView:)]) {
            [self.controlView playerDisappearHalfInScrollView:self];
        }
        if (self.stopWhileNotVisible) {
            [self stopCurrentPlayingCell];
        }
    };
    
    scrollView.playerDidDisappearInScrollView = ^(NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        if (self.isFullScreen) return;
        if ([self.controlView respondsToSelector:@selector(playerDidDisappearInScrollView:)]) {
            [self.controlView playerDidDisappearInScrollView:self];
        }
        if (!self.stopWhileNotVisible) {
            [self addPlayerViewToKeyWindow];
        } else {
            [self stopCurrentPlayingCell];
        }
    };
}

- (void)setStopWhileNotVisible:(BOOL)stopWhileNotVisible {
    self.scrollView.stopWhileNotVisible = stopWhileNotVisible;
    objc_setAssociatedObject(self, @selector(stopWhileNotVisible), @(stopWhileNotVisible), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setContainerViewTag:(NSInteger)containerViewTag {
    objc_setAssociatedObject(self, @selector(containerViewTag), @(containerViewTag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.scrollView.containerViewTag = containerViewTag;
}

- (void)setPlayingIndexPath:(NSIndexPath *)playingIndexPath {
    objc_setAssociatedObject(self, @selector(playingIndexPath), playingIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (playingIndexPath) {
        [self stopCurrentPlayingCell];
        UIView *cell = [self.scrollView zf_getCellForIndexPath:playingIndexPath];
        self.containerView = [cell viewWithTag:self.containerViewTag];
        [self.orientationObserver cellModelRotateView:self.currentPlayerManager.view rotateViewAtCell:cell playerViewTag:self.containerViewTag];
        [self.orientationObserver addDeviceOrientationObserver];
        self.scrollView.playingIndexPath = playingIndexPath;
    }
}

- (void)setShouldAutoPlay:(BOOL)shouldAutoPlay {
    self.scrollView.shouldAutoPlay = shouldAutoPlay;
}

- (void)setAssetURLs:(NSArray<NSURL *> * _Nullable)assetURLs {
    objc_setAssociatedObject(self, @selector(assetURLs), assetURLs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSectionAssetURLs:(NSArray<NSArray<NSURL *> *> * _Nullable)sectionAssetURLs {
    objc_setAssociatedObject(self, @selector(sectionAssetURLs), sectionAssetURLs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSmallFloatView:(ZFFloatView * _Nullable)smallFloatView {
    objc_setAssociatedObject(self, @selector(smallFloatView), smallFloatView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIsSmallFloatViewShow:(BOOL)isSmallFloatViewShow {
    objc_setAssociatedObject(self, @selector(isSmallFloatViewShow), @(isSmallFloatViewShow), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (UIScrollView *)scrollView {
    UIScrollView *scrollView = objc_getAssociatedObject(self, _cmd);
    return scrollView;
}

- (BOOL)stopWhileNotVisible {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) return number.boolValue;
    self.stopWhileNotVisible = YES;
    return YES;
}

- (NSInteger)containerViewTag {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (ZFFloatView *)smallFloatView {
    ZFFloatView *smallFloatView = objc_getAssociatedObject(self, _cmd);
    if (!smallFloatView) {
        smallFloatView = [[ZFFloatView alloc] init];
        smallFloatView.parentView = [UIApplication sharedApplication].keyWindow;
        smallFloatView.hidden = YES;
        self.smallFloatView = smallFloatView;
    }
    return smallFloatView;
}

- (BOOL)isSmallFloatViewShow {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (NSIndexPath *)playingIndexPath {
    return objc_getAssociatedObject(self, _cmd);
}

- (NSArray<NSURL *> *)assetURLs {
    return objc_getAssociatedObject(self, _cmd);
}

- (NSArray<NSArray<NSURL *> *> *)sectionAssetURLs {
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)shouldAutoPlay {
    return self.scrollView.shouldAutoPlay;
}

- (void)playTheIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop completionHandler:(void (^ _Nullable)(void))completionHandler {
    NSURL *assetURL;
    if (self.sectionAssetURLs.count) {
        assetURL = self.sectionAssetURLs[indexPath.section][indexPath.row];
    } else if (self.assetURLs.count) {
        assetURL = self.assetURLs[indexPath.row];
        self.currentPlayIndex = indexPath.row;
    }
    if (scrollToTop) {
        @weakify(self)
        [self.scrollView zf_scrollToRowAtIndexPath:indexPath completionHandler:^{
            @strongify(self)
            if (completionHandler) completionHandler();
            self.playingIndexPath = indexPath;
            self.currentPlayerManager.assetURL = assetURL;
            [self.scrollView zf_scrollViewStopScroll];
        }];
    } else {
        if (completionHandler) completionHandler();
        self.playingIndexPath = indexPath;
        self.currentPlayerManager.assetURL = assetURL;
    }
}

- (void)playTheIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop {
    self.playingIndexPath = indexPath;
    NSURL *assetURL;
    if (self.sectionAssetURLs.count) {
        assetURL = self.sectionAssetURLs[indexPath.section][indexPath.row];
    } else if (self.assetURLs.count) {
        assetURL = self.assetURLs[indexPath.row];
        self.currentPlayIndex = indexPath.row;
    }
    self.currentPlayerManager.assetURL = assetURL;
    if (scrollToTop) {
        [self.scrollView zf_scrollToRowAtIndexPath:indexPath completionHandler:nil];
    }
}

- (void)stopCurrentPlayingCell {
    if (self.scrollView.playingIndexPath) {
        [self stop];
        self.isSmallFloatViewShow = NO;
        self.scrollView.playingIndexPath = nil;
        if (self.smallFloatView) self.smallFloatView.hidden = YES;
    }
}

@end
