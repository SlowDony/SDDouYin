//
//  ZFAVPlayerManager.m
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

#import "ZFAVPlayerManager.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/*!
 *  Refresh interval for timed observations of AVPlayer
 */
static float const kTimeRefreshInterval = 0.5;

static NSString *const kStatus                   = @"status";
static NSString *const kLoadedTimeRanges         = @"loadedTimeRanges";
static NSString *const kPlaybackBufferEmpty      = @"playbackBufferEmpty";
static NSString *const kPlaybackLikelyToKeepUp   = @"playbackLikelyToKeepUp";
static NSString *const kPresentationSize         = @"presentationSize";

@interface ZFPlayerPresentView : ZFPlayerView

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) UIImage *placeholder;
/// default is AVLayerVideoGravityResizeAspect.
@property (nonatomic, strong) AVLayerVideoGravity videoGravity;
@property (nonatomic, strong, readonly) UIImageView *placeholderImageView;

@end

@implementation ZFPlayerPresentView

@synthesize placeholderImageView = _placeholderImageView;

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)avLayer {
    return (AVPlayerLayer *)self.layer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self presentSetupView];
    }
    return self;
}

- (void)setPlayer:(AVPlayer *)player {
    if (player == _player) return;
    self.avLayer.player = player;
}

- (void)setPlaceholder:(UIImage *)placeholder {
    if (placeholder == _placeholder) return;
    _placeholder = placeholder;
    _placeholderImageView.image = placeholder;
}

- (void)setVideoGravity:(AVLayerVideoGravity)videoGravity {
    if (videoGravity == self.videoGravity) return;
    [self avLayer].videoGravity = videoGravity;
}

- (AVLayerVideoGravity)videoGravity {
    return [self avLayer].videoGravity;
}

#pragma mark -

- (void)presentSetupView {
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.placeholderImageView];
    self.placeholderImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (UIImageView *)placeholderImageView {
    if (!_placeholderImageView) {
        _placeholderImageView = [UIImageView new];
        _placeholderImageView.contentMode = UIViewContentModeScaleAspectFill;
        _placeholderImageView.clipsToBounds = YES;
    }
    return _placeholderImageView;
}

@end

@interface ZFAVPlayerManager () {
    id _timeObserver;
    id _itemEndObserver;
    ZFKVOController *_playerItemKVO;
}
@property (nonatomic, strong, readonly) AVURLAsset *asset;
@property (nonatomic, strong, readonly) AVPlayerItem *playerItem;
@property (nonatomic, strong, readonly) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation ZFAVPlayerManager

@synthesize view                           = _view;
@synthesize currentTime                    = _currentTime;
@synthesize totalTime                      = _totalTime;
@synthesize playerPlayTimeChanged          = _playerPlayTimeChanged;
@synthesize playerBufferTimeChanged        = _playerBufferTimeChanged;
@synthesize playerDidToEnd                 = _playerDidToEnd;
@synthesize bufferTime                     = _bufferTime;
@synthesize playState                      = _playState;
@synthesize loadState                      = _loadState;
@synthesize assetURL                       = _assetURL;
@synthesize playerPrepareToPlay            = _playerPrepareToPlay;
@synthesize playerPlayStatChanged          = _playerPlayStatChanged;
@synthesize playerLoadStatChanged          = _playerLoadStatChanged;
@synthesize seekTime                       = _seekTime;
@synthesize muted                          = _muted;
@synthesize volume                         = _volume;
@synthesize presentationSize               = _presentationSize;
@synthesize isPlaying                      = _isPlaying;
@synthesize rate                           = _rate;
@synthesize isPreparedToPlay               = _isPreparedToPlay;
@synthesize scalingMode                    = _scalingMode;

- (instancetype)init {
    self = [super init];
    if (self) {
        _scalingMode = ZFPlayerScalingModeAspectFit;
    }
    return self;
}

- (void)prepareToPlay {
    if (!_assetURL) return;
    _isPreparedToPlay = YES;
    [self initializePlayer];
    self.loadState = ZFPlayerLoadStatePrepare;
    if (_playerPrepareToPlay) _playerPrepareToPlay(self, self.assetURL);
    [self play];
}

- (void)reloadPlayer {
    [self prepareToPlay];
}

- (void)play {
    if (!_isPreparedToPlay) {
        [self prepareToPlay];
    } else {
        [self.player play];
        self.player.rate = self.rate;
        _isPlaying = YES;
        self.playState = ZFPlayerPlayStatePlaying;
    }
}

- (void)pause {
    [self.player pause];
    _isPlaying = NO;
    self.playState = ZFPlayerPlayStatePaused;
}

- (void)stop {
    [_playerItemKVO safelyRemoveAllObservers];
    self.playState = ZFPlayerPlayStatePlayStopped;
    if (self.player.rate != 0) [self.player pause];
    [self.player removeTimeObserver:_timeObserver];
    _timeObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:_itemEndObserver name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    _itemEndObserver = nil;
    _isPlaying = NO;
    _player = nil;
    _assetURL = nil;
}

- (void)replay {
    __weak typeof(self) weakSelf = self;
    [self seekToTime:0 completionHandler:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = self;
        [strongSelf play];
    }];
}

/// Replace the current playback address
- (void)replaceCurrentAssetURL:(NSURL *)assetURL {
    if (self.player) [self stop];
    _assetURL = assetURL;
    [self prepareToPlay];
}

- (void)seekToTime:(NSTimeInterval)time completionHandler:(void (^ __nullable)(BOOL finished))completionHandler {
    CMTime seekTime = CMTimeMake(time, 1); //kCMTimeZero
    [_playerItem cancelPendingSeeks];
    [_player seekToTime:seekTime toleranceBefore:CMTimeMake(1,1) toleranceAfter:CMTimeMake(1,1) completionHandler:completionHandler];
}

- (UIImage *)thumbnailImageAtCurrentTime {
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:_asset];
    CMTime expectedTime = _playerItem.currentTime;
    CGImageRef cgImage = NULL;
    
    imageGenerator.requestedTimeToleranceBefore = kCMTimeZero;
    imageGenerator.requestedTimeToleranceAfter = kCMTimeZero;
    cgImage = [imageGenerator copyCGImageAtTime:expectedTime actualTime:NULL error:NULL];
    
    if (!cgImage) {
        imageGenerator.requestedTimeToleranceBefore = kCMTimePositiveInfinity;
        imageGenerator.requestedTimeToleranceAfter = kCMTimePositiveInfinity;
        cgImage = [imageGenerator copyCGImageAtTime:expectedTime actualTime:NULL error:NULL];
    }
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    return image;
}

#pragma mark - private method

/// Calculate buffer progress
- (NSTimeInterval)availableDuration {
    NSArray *timeRangeArray = _playerItem.loadedTimeRanges;
    CMTime currentTime = [_player currentTime];
    BOOL foundRange = NO;
    CMTimeRange aTimeRange = {0};
    if (timeRangeArray.count) {
        aTimeRange = [[timeRangeArray objectAtIndex:0] CMTimeRangeValue];
        if (CMTimeRangeContainsTime(aTimeRange, currentTime)) {
            foundRange = YES;
        }
    }
    
    if (foundRange) {
        CMTime maxTime = CMTimeRangeGetEnd(aTimeRange);
        NSTimeInterval playableDuration = CMTimeGetSeconds(maxTime);
        if (playableDuration > 0) {
            return playableDuration;
        }
    }
    return 0;
}

- (void)initializePlayer {
    _asset = [AVURLAsset assetWithURL:self.assetURL];
    _playerItem = [AVPlayerItem playerItemWithAsset:_asset automaticallyLoadedAssetKeys:@[@"duration"]];
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    _player.actionAtItemEnd = AVPlayerActionAtItemEndPause;
    [self enableAudioTracks:YES inPlayerItem:_playerItem];
    
    ZFPlayerPresentView *presentView = (ZFPlayerPresentView *)self.view;
    presentView.player = _player;
    self.scalingMode = _scalingMode;
    if (@available(iOS 9.0, *)) {
        _playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = NO;
    }
    if (@available(iOS 10.0, *)) {
        _playerItem.preferredForwardBufferDuration = 1;
        _player.automaticallyWaitsToMinimizeStalling = NO;
    }
    [self itemObserving];
}

/// Playback speed switching method
- (void)enableAudioTracks:(BOOL)enable inPlayerItem:(AVPlayerItem*)playerItem {
    for (AVPlayerItemTrack *track in playerItem.tracks){
        if ([track.assetTrack.mediaType isEqual:AVMediaTypeVideo]) {
            track.enabled = enable;
        }
    }
}

/**
 *  缓冲较差时候回调这里
 */
- (void)bufferingSomeSecond {
    // playbackBufferEmpty会反复进入，因此在bufferingOneSecond延时播放执行完之前再调用bufferingSomeSecond都忽略
    __block BOOL isBuffering = NO;
    if (isBuffering) return;
    isBuffering = YES;
    
    // 需要先暂停一小会之后再播放，否则网络状况不好的时候时间在走，声音播放不出来
    [self.player pause];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 如果此时用户已经暂停了，则不再需要开启播放了
        if (!self.isPlaying) {
            isBuffering = NO;
            return;
        }
        [self play];
        // 如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
        isBuffering = NO;
        if (!self.playerItem.isPlaybackLikelyToKeepUp) { [self bufferingSomeSecond]; }
    });
}

- (void)itemObserving {
    [_playerItemKVO safelyRemoveAllObservers];
    _playerItemKVO = [[ZFKVOController alloc] initWithTarget:_playerItem];
    [_playerItemKVO safelyAddObserver:self
                           forKeyPath:kStatus
                              options:NSKeyValueObservingOptionNew
                              context:nil];
    [_playerItemKVO safelyAddObserver:self
                           forKeyPath:kPlaybackBufferEmpty
                              options:NSKeyValueObservingOptionNew
                              context:nil];
    [_playerItemKVO safelyAddObserver:self
                           forKeyPath:kPlaybackLikelyToKeepUp
                              options:NSKeyValueObservingOptionNew
                              context:nil];
    [_playerItemKVO safelyAddObserver:self
                           forKeyPath:kLoadedTimeRanges
                              options:NSKeyValueObservingOptionNew
                              context:nil];
    [_playerItemKVO safelyAddObserver:self
                           forKeyPath:kPresentationSize
                              options:NSKeyValueObservingOptionNew
                              context:nil];

    CMTime interval = CMTimeMakeWithSeconds(kTimeRefreshInterval, NSEC_PER_SEC);
    @weakify(self)
    _timeObserver = [self.player addPeriodicTimeObserverForInterval:interval queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        @strongify(self)
        if (!self) return;
        NSArray *loadedRanges = self.playerItem.seekableTimeRanges;
        if (loadedRanges.count > 0 && self.playerItem.duration.timescale != 0) {
            self->_currentTime = CMTimeGetSeconds(time);
            self->_totalTime = CMTimeGetSeconds(self.playerItem.duration);
            if (self.playerPlayTimeChanged) self.playerPlayTimeChanged(self, self.currentTime, self.totalTime);
        }
    }];
    
    _itemEndObserver = [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        @strongify(self)
        if (!self) return;
        self.playState = ZFPlayerPlayStatePlayStopped;
        if (self.playerDidToEnd) self.playerDidToEnd(self);
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_async(dispatch_get_main_queue(), ^{
         if ([keyPath isEqualToString:kStatus]) {
             if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
                 self.loadState = ZFPlayerLoadStatePlaythroughOK;
                 if (self.seekTime) [self seekToTime:self.seekTime completionHandler:nil];
                 [self play];
                 self.player.muted = self.muted;
             } else if (self.player.currentItem.status == AVPlayerItemStatusFailed) {
                 self.playState = ZFPlayerPlayStatePlayFailed;
             }
         } else if ([keyPath isEqualToString:kPlaybackBufferEmpty]) {
             // When the buffer is empty
             if (self.playerItem.playbackBufferEmpty) {
                 self.loadState = ZFPlayerLoadStateStalled;
                 [self bufferingSomeSecond];
             }
         } else if ([keyPath isEqualToString:kPlaybackLikelyToKeepUp]) {
             // When the buffer is good
             if (self.playerItem.playbackLikelyToKeepUp) {
                 self.loadState = ZFPlayerLoadStatePlayable;
             }
         } else if ([keyPath isEqualToString:kLoadedTimeRanges]) {
             NSTimeInterval bufferTime = [self availableDuration];
             self->_bufferTime = bufferTime;
             if (self.playerBufferTimeChanged) {
                 self.playerBufferTimeChanged(self, bufferTime);
             }
         } else if ([keyPath isEqualToString:kPresentationSize]) {
             self->_presentationSize = self.playerItem.presentationSize;
         } else {
             [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
         }
    });
}

#pragma mark - getter

- (UIView *)view {
    if (!_view) {
        _view = [[ZFPlayerPresentView alloc] init];
    }
    return _view;
}

- (float)rate {
    return _rate == 0 ?1:_rate;
}

#pragma mark - setter

- (void)setPlayState:(ZFPlayerPlaybackState)playState {
    _playState = playState;
    if (self.playerPlayStatChanged) self.playerPlayStatChanged(self, playState);
}

- (void)setLoadState:(ZFPlayerLoadState)loadState {
    _loadState = loadState;
    if (self.playerLoadStatChanged) self.playerLoadStatChanged(self, loadState);
}

- (void)setAssetURL:(NSURL *)assetURL {
    _assetURL = assetURL;
    [self replaceCurrentAssetURL:assetURL];
}

- (void)setRate:(float)rate {
    _rate = rate;
    if (self.player && fabsf(_player.rate) > 0.00001f) {
        self.player.rate = rate;
    }
}

- (void)setMuted:(BOOL)muted {
    _muted = muted;
    self.player.muted = muted;
}

- (void)setScalingMode:(ZFPlayerScalingMode)scalingMode {
    _scalingMode = scalingMode;
    ZFPlayerPresentView *presentView = (ZFPlayerPresentView *)self.view;
    switch (scalingMode) {
        case ZFPlayerScalingModeNone:
            presentView.videoGravity = AVLayerVideoGravityResizeAspect;
            break;
        case ZFPlayerScalingModeAspectFit:
            presentView.videoGravity = AVLayerVideoGravityResizeAspect;
            break;
        case ZFPlayerScalingModeAspectFill:
            presentView.videoGravity = AVLayerVideoGravityResizeAspectFill;
            break;
        case ZFPlayerScalingModeFill:
            presentView.videoGravity = AVLayerVideoGravityResize;
            break;
        default:
            break;
    }
}

- (void)setVolume:(float)volume {
    _volume = MIN(MAX(0, volume), 1);
    self.player.volume = volume;
}

@end
