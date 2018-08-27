//
//  UIScrollView+ZFPlayer.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 * The scroll derection of scrollView.
 */
typedef NS_ENUM(NSUInteger, ZFPlayerScrollDerection) {
    ZFPlayerScrollDerectionNone = 0,
    ZFPlayerScrollDerectionUp = 1,    // Scroll up
    ZFPlayerScrollDerectionDown = 2   // Scroll Down
};

@interface UIScrollView (ZFPlayer)

/// Rolling direction switch
@property (nonatomic, assign) BOOL enableScrollHook;

/// The indexPath is playing
@property (nonatomic, strong, nullable) NSIndexPath *playingIndexPath;

/// The indexPath that should play, the one that lights up.
@property (nonatomic, strong, nullable) NSIndexPath *shouldPlayIndexPath;

/// WWANA networks play automatically,default NO.
@property (nonatomic, assign, getter=isWWANAutoPlay) BOOL WWANAutoPlay;

/// The player should auto player,default is YES.
@property (nonatomic, assign) BOOL shouldAutoPlay;

/// The view tag that the player display in scrollView.
@property (nonatomic, assign) NSInteger containerViewTag;

/// Is the video playing.
@property (nonatomic, assign, readonly, getter=isPlaying) BOOL playing;

/// The scroll derection of scrollView.
@property (nonatomic, assign) ZFPlayerScrollDerection scrollDerection;

/// Does the currently playing cell stop playing when the cell has slid off the screen，defalut is YES.
@property (nonatomic, assign) BOOL stopWhileNotVisible;

/// The block invoked When the player did appeared.
@property (nonatomic, copy, nullable) void(^playerDidAppearInScrollView)(NSIndexPath *indexPath);

/// The block invoked When the player will disappear.
@property (nonatomic, copy, nullable) void(^playerWillDisappearInScrollView)(NSIndexPath *indexPath);

/// The block invoked When the player did disappeared half.
@property (nonatomic, copy, nullable) void(^playerDisappearHalfInScrollView)(NSIndexPath *indexPath);

/// The block invoked When the player did disappeared.
@property (nonatomic, copy, nullable) void(^playerDidDisappearInScrollView)(NSIndexPath *indexPath);

/// The block invoked When the player did stop scroll.
@property (nonatomic, copy, nullable) void(^scrollViewDidStopScroll)(NSIndexPath *indexPath);

/// Filter the cell that should be played when the scroll is stopped (to play when the scroll is stopped)
- (void)zf_filterShouldPlayCellWhileScrolled:(void (^ __nullable)(NSIndexPath *indexPath))handler;

/// Filter the cell that should be played while scrolling (you can use this to filter the highlighted cell)
- (void)zf_filterShouldPlayCellWhileScrolling:(void (^ __nullable)(NSIndexPath *indexPath))handler;

/// Get the cell according to indexPath
- (UIView *)zf_getCellForIndexPath:(NSIndexPath *)indexPath;

/// Scroll to indexPath with animations.
- (void)zf_scrollToRowAtIndexPath:(NSIndexPath *)indexPath completionHandler:(void (^ __nullable)(void))completionHandler;

- (void)zf_scrollViewStopScroll;

@end

NS_ASSUME_NONNULL_END
