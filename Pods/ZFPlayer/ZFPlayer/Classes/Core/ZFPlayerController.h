//
//  ZFPlayer.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZFPlayerMediaPlayback.h"
#import "ZFOrientationObserver.h"
#import "ZFPlayerMediaControl.h"
#import "ZFPlayerGestureControl.h"
#import "ZFFloatView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZFPlayerController : NSObject

/// The video contrainerView in normal model.
@property (nonatomic, readonly) UIView *containerView;

/// The currentPlayerManager must conform `ZFPlayerMediaPlayback` protocol.
@property (nonatomic, readonly) id<ZFPlayerMediaPlayback> currentPlayerManager;

/// The custom controlView must conform `ZFPlayerMediaControl` protocol.
@property (nonatomic, strong) UIView<ZFPlayerMediaControl> *controlView;

/*!
 @method            playerWithPlayerManager:
 @abstract          Create an ZFPlayerController that plays a single audiovisual item.
 @param             playerManager must conform `ZFPlayerMediaPlayback` protocol.
 @param             containerView to see the video frames must set the contrainerView.
 @result            An instance of ZFPlayerController.
 */
+ (instancetype)playerWithPlayerManager:(id<ZFPlayerMediaPlayback>)playerManager containerView:(UIView *)containerView;

/*!
 @method            playerWithPlayerManager:
 @abstract          Create an ZFPlayerController that plays a single audiovisual item.
 @param             playerManager must conform `ZFPlayerMediaPlayback` protocol.
 @param             containerView to see the video frames must set the contrainerView.
 @result            An instance of ZFPlayerController.
 */
- (instancetype)initWithPlayerManager:(id<ZFPlayerMediaPlayback>)playerManager containerView:(UIView *)containerView;

/*!
 @method            playerWithScrollView:playerManager:
 @abstract          Create an ZFPlayerController that plays a single audiovisual item. Use in `tableView` or `collectionView`.
 @param             scrollView is `tableView` or `collectionView`.
 @param             playerManager must conform `ZFPlayerMediaPlayback` protocol.
 @param             containerViewTag to see the video at scrollView must set the contrainerViewTag.
 @result            An instance of ZFPlayerController.
 */
+ (instancetype)playerWithScrollView:(UIScrollView *)scrollView playerManager:(id<ZFPlayerMediaPlayback>)playerManager containerViewTag:(NSInteger)containerViewTag;

/*!
 @method            playerWithScrollView:playerManager:
 @abstract          Create an ZFPlayerController that plays a single audiovisual item. Use in `tableView` or `collectionView`.
 @param             scrollView is `tableView` or `collectionView`.
 @param             playerManager must conform `ZFPlayerMediaPlayback` protocol.
 @param             containerViewTag to see the video at scrollView must set the contrainerViewTag.
 @result            An instance of ZFPlayerController.
 */
- (instancetype)initWithScrollView:(UIScrollView *)scrollView playerManager:(id<ZFPlayerMediaPlayback>)playerManager containerViewTag:(NSInteger)containerViewTag;

@end

@interface ZFPlayerController (ZFPlayerTimeControl)

/// The player current play time.
@property (nonatomic, readonly) NSTimeInterval currentTime;

/// The player total time.
@property (nonatomic, readonly) NSTimeInterval totalTime;

/// The player buffer time.
@property (nonatomic, readonly) NSTimeInterval bufferTime;

/// The player progress, 0...1
@property (nonatomic, readonly) float progress;

/// The player bufferProgress, 0...1
@property (nonatomic, readonly) float bufferProgress;

/// Use this method to seek to a specified time for the current player and to be notified when the seek operation is complete.
- (void)seekToTime:(NSTimeInterval)time completionHandler:(void (^ __nullable)(BOOL finished))completionHandler;

@end

@interface ZFPlayerController (ZFPlayerPlaybackControl)

/// 0...1.0
/// Only affects audio volume for the device instance and not for the player.
/// You can change device volume or player volume as needed,change the player volume you can folllow the `ZFPlayerMediaPlayback` protocol.
@property (nonatomic) float volume;

/// Only affects audio muting for the device instance and not for the player.
/// You can change device mute or player mute as needed,change the player mute you can folllow the `ZFPlayerMediaPlayback` protocol.
@property (nonatomic, getter=isMuted) BOOL muted;

// 0...1.0, where 1.0 is maximum brightness. Only supported by main screen.
@property (nonatomic) float brightness;

/// WWAN network auto play, default is NO.
@property (nonatomic, getter=isWWANAutoPlay) BOOL WWANAutoPlay;

/// The currently playing index,limited to one-dimensional arrays.
@property (nonatomic) NSInteger currentPlayIndex;

/// If Yes, player will be called pause method When Received `UIApplicationWillResignActiveNotification` notification.
/// default is YES.
@property (nonatomic) BOOL pauseWhenAppResignActive;

/// When the player is play end.
@property (nonatomic, copy, nullable) void(^playerDidToEnd)(id asset);

/// Play the next url ,while the `assetURLs` is not NULL.
- (void)playTheNext;

/// Play the previous url ,while the `assetURLs` is not NULL.
- (void)playThePrevious;

/// Play the index of url ,while the `assetURLs` is not NULL.
- (void)playTheIndex:(NSInteger)index;

/// Player stop and playerView remove from super view,remove other notification.
- (void)stop;

/*!
 @method           replaceCurrentPlayerManager:
 @abstract         Replaces the player's current playeranager with the specified player item.
 @param            manager must conform `ZFPlayerMediaPlayback` protocol
 @discussion       The playerManager that will become the player's current playeranager.
 */
- (void)replaceCurrentPlayerManager:(id<ZFPlayerMediaPlayback>)manager;

@end

@interface ZFPlayerController (ZFPlayerOrientationRotation)

@property (nonatomic, readonly) ZFOrientationObserver *orientationObserver;

/// When ZFFullScreenMode is ZFFullScreenModeLandscape the orientation is LandscapeLeft or LandscapeRight, this value is YES.
/// When ZFFullScreenMode is ZFFullScreenModePortrait, while the player fullSceen this value is YES.
@property (nonatomic, readonly) BOOL isFullScreen;

/// Lock the screen orientation.
@property (nonatomic, getter=isLockedScreen) BOOL lockedScreen;

/// The statusbar hidden.
@property (nonatomic, getter=isStatusBarHidden) BOOL statusBarHidden;

/// The current orientation of the player.
/// Default is UIInterfaceOrientationPortrait.
@property (nonatomic, readonly) UIInterfaceOrientation currentOrientation;

/// The block invoked When player will rotate.
@property (nonatomic, copy, nullable) void(^orientationWillChange)(ZFPlayerController *player, BOOL isFullScreen);

/// The block invoked when player rotated.
@property (nonatomic, copy, nullable) void(^orientationDidChanged)(ZFPlayerController *player, BOOL isFullScreen);

/// Add the device orientation observer.
- (void)addDeviceOrientationObserver;

/// Remove the device orientation observer.
- (void)removeDeviceOrientationObserver;

/// Enter the fullScreen while the ZFFullScreenMode is ZFFullScreenModeLandscape.
- (void)enterLandscapeFullScreen:(UIInterfaceOrientation)orientation animated:(BOOL)animated;

/// Enter the fullScreen while the ZFFullScreenMode is ZFFullScreenModePortrait.
- (void)enterPortraitFullScreen:(BOOL)fullScreen animated:(BOOL)animated;

// FullScreen mode is determined by ZFFullScreenMode
- (void)enterFullScreen:(BOOL)fullScreen animated:(BOOL)animated;

@end

@interface ZFPlayerController (ZFPlayerViewGesture)

/// An instance of ZFPlayerGestureControl.
@property (nonatomic, readonly) ZFPlayerGestureControl *gestureControl;

/// The gesture types that the player not support.
@property (nonatomic, assign) ZFPlayerDisableGestureTypes disableGestureTypes;

@end

@interface ZFPlayerController (ZFPlayerScrollView)

/// The scroll view is `tableView` or `collectionView`.
@property (nonatomic, readonly, nullable) UIScrollView *scrollView;

/// The scrollView player should auto player,default is YES.
@property (nonatomic) BOOL shouldAutoPlay;

/// The list plays the container view of the player when the window is small after the player has slid off the screen.
@property (nonatomic, readonly, nullable) ZFFloatView *smallFloatView;

/// The indexPath is playing.
@property (nonatomic, nullable) NSIndexPath *playingIndexPath;

/// The view tag that the player display in scrollView.
@property (nonatomic) NSInteger containerViewTag;

/// Does the currently playing cell stop playing when the cell has slid off the screen，defalut is YES.
@property (nonatomic) BOOL stopWhileNotVisible;

/// Whether the small window is displayed.
@property (nonatomic, readonly) BOOL isSmallFloatViewShow;

/// if tableView or collectionView has only one section , use sectionAssetURLs.
/// if normal model set this can use `playTheNext` `playThePrevious` `playTheIndex:`.
@property (nonatomic, copy, nullable) NSArray <NSURL *>*assetURLs;

/// if tableView or collectionView has more section, use sectionAssetURLs.
@property (nonatomic, copy, nullable) NSArray <NSArray <NSURL *>*>*sectionAssetURLs;

/// stop the current playing video on cell.
- (void)stopCurrentPlayingCell;

/// Play the indexPath of url ,while the `assetURLs` or `sectionAssetURLs` is not NULL.
/// `scrollToTop` scroll to top with animations.
- (void)playTheIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop;

/// Play the indexPath of url ,while the `assetURLs` or `sectionAssetURLs` is not NULL.
/// `scrollToTop` scroll to top with animations.
/// Scroll completion callback.
- (void)playTheIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop completionHandler:(void (^ __nullable)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
