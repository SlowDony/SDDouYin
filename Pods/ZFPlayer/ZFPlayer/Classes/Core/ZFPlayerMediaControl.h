//
//  ZFPlayerMediaControl.h
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
#import "ZFPlayerMediaPlayback.h"
#import "ZFOrientationObserver.h"
#import "ZFPlayerGestureControl.h"
#import "ZFReachabilityManager.h"
@class ZFPlayerController;

NS_ASSUME_NONNULL_BEGIN

@protocol ZFPlayerMediaControl <NSObject>

@optional

#pragma mark - Playback state

/// When the player prepare to play the video.
- (void)videoPlayer:(ZFPlayerController *)videoPlayer prepareToPlay:(NSURL *)assetURL;

/// When th player playback state changed.
- (void)videoPlayer:(ZFPlayerController *)videoPlayer playStateChanged:(ZFPlayerPlaybackState)state;

/// When th player loading state changed.
- (void)videoPlayer:(ZFPlayerController *)videoPlayer loadStateChanged:(ZFPlayerLoadState)state;

#pragma mark - progress

/**
 When the playback changed.
 
 @param videoPlayer the player.
 @param currentTime the current play time.
 @param totalTime the video total time.
 */
- (void)videoPlayer:(ZFPlayerController *)videoPlayer
        currentTime:(NSTimeInterval)currentTime
          totalTime:(NSTimeInterval)totalTime;

/**
 When buffer progress changed.
 */
- (void)videoPlayer:(ZFPlayerController *)videoPlayer
         bufferTime:(NSTimeInterval)bufferTime;

/**
 When you are dragging to change the video progress.
 */
- (void)videoPlayer:(ZFPlayerController *)videoPlayer
       draggingTime:(NSTimeInterval)seekTime
          totalTime:(NSTimeInterval)totalTime;

/**
 When play end.
 */
- (void)videoPlayerPlayEnd:(ZFPlayerController *)videoPlayer;

#pragma mark - lock screen

/**
 When set `videoPlayer.lockedScreen`.
 */
- (void)lockedVideoPlayer:(ZFPlayerController *)videoPlayer lockedScreen:(BOOL)locked;

#pragma mark - Screen rotation

/**
 When the fullScreen maode will changed.
 */
- (void)videoPlayer:(ZFPlayerController *)videoPlayer orientationWillChange:(ZFOrientationObserver *)observer;

/**
 When the fullScreen maode did changed.
 */
- (void)videoPlayer:(ZFPlayerController *)videoPlayer orientationDidChanged:(ZFOrientationObserver *)observer;

#pragma mark - The network changed

/**
 When the network changed
 */
- (void)videoPlayer:(ZFPlayerController *)videoPlayer reachabilityChanged:(ZFReachabilityStatus)status;

#pragma mark - Gesture

/**
 When the gesture condition
 */
- (BOOL)gestureTriggerCondition:(ZFPlayerGestureControl *)gestureControl
                    gestureType:(ZFPlayerGestureType)gestureType
              gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
                          touch:(UITouch *)touch;

/**
 When the gesture single tapped
 */
- (void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl;

/**
 When the gesture double tapped
 */
- (void)gestureDoubleTapped:(ZFPlayerGestureControl *)gestureControl;

/**
 When the gesture begin panGesture
 */
- (void)gestureBeganPan:(ZFPlayerGestureControl *)gestureControl
           panDirection:(ZFPanDirection)direction
            panLocation:(ZFPanLocation)location;

/**
 When the gesture paning
 */
- (void)gestureChangedPan:(ZFPlayerGestureControl *)gestureControl
             panDirection:(ZFPanDirection)direction
              panLocation:(ZFPanLocation)location
             withVelocity:(CGPoint)velocity;

/**
 When the end panGesture
 */
- (void)gestureEndedPan:(ZFPlayerGestureControl *)gestureControl
           panDirection:(ZFPanDirection)direction
            panLocation:(ZFPanLocation)location;

/**
 When the pinchGesture changed
 */
- (void)gesturePinched:(ZFPlayerGestureControl *)gestureControl
                 scale:(float)scale;

#pragma mark - scrollview

/**
 When `tableView` or` collectionView` is about to appear. Because scrollview may be scrolled.
 */
- (void)playerDidAppearInScrollView:(ZFPlayerController *)videoPlayer;

/**
 When `tableView` or` collectionView` is about to disappear. Because scrollview may be scrolled.
 */
- (void)playerWillDisappearInScrollView:(ZFPlayerController *)videoPlayer;

/**
 When `tableView` or` collectionView` is about to disappear. Because scrollview may be scrolled.
 */
- (void)playerDisappearHalfInScrollView:(ZFPlayerController *)videoPlayer;

/**
 When `tableView` or` collectionView` is about to disappear. Because scrollview may be scrolled.
 */
- (void)playerDidDisappearInScrollView:(ZFPlayerController *)videoPlayer;

@end

NS_ASSUME_NONNULL_END

