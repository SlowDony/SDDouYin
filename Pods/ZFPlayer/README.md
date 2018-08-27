
<p align="center">
<img src="https://upload-images.jianshu.io/upload_images/635942-092427e571756309.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" alt="ZFPlayer" title="ZFPlayer" width="557"/>
</p>

<p align="center">
<a href="https://travis-ci.org/renzifeng/ZFPlayer"><img src="https://travis-ci.org/renzifeng/ZFPlayer.svg?branch=master"></a>
<a href="https://img.shields.io/cocoapods/v/ZFPlayer.svg"><img src="https://img.shields.io/cocoapods/v/ZFPlayer.svg"></a>
<a href="https://img.shields.io/cocoapods/v/ZFPlayer.svg"><img src="https://img.shields.io/github/license/renzifeng/ZFPlayer.svg?style=flat"></a>
<a href="http://cocoadocs.org/docsets/ZFPlayer"><img src="https://img.shields.io/cocoapods/p/ZFPlayer.svg?style=flat"></a>
<a href="http://weibo.com/zifeng1300"><img src="https://img.shields.io/badge/weibo-@%E4%BB%BB%E5%AD%90%E4%B8%B0-yellow.svg?style=flat"></a>
</p>

[中文说明](https://www.jianshu.com/p/90e55deb4d51)

Before this, you used ZFPlayer, are you worried about encapsulating avplayer instead of using or modifying the source code to support other players, the control layer is not easy to customize, and so on? In order to solve these problems, I have wrote this player template, for player SDK you can conform the `ZFPlayerMediaPlayback` protocol, for control view you can conform the `ZFPlayerMediaControl` protocol, can custom the player and control view.

在此之前你使用ZFPlayer，是不是在烦恼播放器SDK自定义，控制层自定义等等问题。作者公司多个项目分别使用不同播放器SDK和每个项目控制层都不一样，但是为了统一管理、统一调用和各种自定义，我特意写了这个播放器壳子，意在解决各种痛点。播放器SDK只要遵守`ZFPlayerMediaPlayback`协议，控制层只要遵守`ZFPlayerMediaControl`协议，完全可以实现自定义播放器和控制层。

![ZFPlayer.png](https://upload-images.jianshu.io/upload_images/635942-5662bfec6d457cba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Requirements

- iOS 7+
- Xcode 8+

## Installation

ZFPlayer is available through [CocoaPods](https://cocoapods.org). To install it,use player template simply add the following line to your Podfile:

```objc
pod 'ZFPlayer', '~> 3.0.4'
```

Use default controlView simply add the following line to your Podfile:

```objc
pod 'ZFPlayer/ControlView', '~> 3.0.4'
```
Use AVPlayer simply add the following line to your Podfile:

```objc
pod 'ZFPlayer/AVPlayer', '~> 3.0.4'
```
Use KSYMediaPlayer simply add the following line to your Podfile:

```objc
pod 'ZFPlayer/KSYMediaPlayer', '~> 3.0.4'
```

## Usage introduce

####  ZFPlayerController
Main classes, two initialization methods, normal mode initialization and list style initialization (tableView, collection)

Normal style initialization 

```objc
ZFPlayerController *player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:containerView];
ZFPlayerController *player = [[ZFPlayerController alloc] initwithPlayerManager:playerManager containerView:containerView];
```

List style initialization

```objc
ZFPlayerController *player = [ZFPlayerController playerWithScrollView:tableView playerManager:playerManager containerViewTag:containerViewTag];
ZFPlayerController *player = [ZFPlayerController alloc] initWithScrollView:tableView playerManager:playerManager containerViewTag:containerViewTag];
```

#### ZFPlayerMediaPlayback
For the playerMnager,you must conform `ZFPlayerMediaPlayback` protocol,custom playermanager can supports any player SDK，such as `AVPlayer`,`MPMoviePlayerController`,`ijkplayer`,`vlc`,`PLPlayerKit`,`KSYMediaPlayer`and so on，you can reference the `ZFAVPlayerManager`class.

```objc
Class<ZFPlayerMediaPlayback> *playerManager = ...;
```

#### ZFPlayerMediaControl
This class is used to display the control layer, and you must conform the ZFPlayerMediaControl protocol, you can reference the `ZFPlayerControlView` class.

```objc
UIView<ZFPlayerMediaControl> *controlView = ...;
player.controlView = controlView;
```

## Usage

#### Normal Style

```objc
/// Your custom playerManager must conform `ZFPlayerMediaPlayback` protocol.
Class<ZFPlayerMediaPlayback> *playerManager = ...;

/// playerController
ZFPlayerController *player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
player.controlView = controlView<ZFPlayerMediaControl>;
playerManager.assetURL = [NSURL URLWithString:...];
```

#### List style

```objc
/// Your custom playerManager must conform `ZFPlayerMediaPlayback` protocol.
Class<ZFPlayerMediaPlayback> *playerManager = ...;

/// playerController
ZFPlayerController *player = [ZFPlayerController playerWithScrollView:tableView playerManager:playerManager containerViewTag:tag<NSInteger>];
player.controlView = controlView<ZFPlayerMediaControl>;
self.player.assetURLs = array<NSURL *>;
```
### Picture demonstration

![Picture effect](https://upload-images.jianshu.io/upload_images/635942-1b0e23b7f5eabd9e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Reference
- https://github.com/changsanjiang/SJVideoPlayer
- https://github.com/ChangbaDevs/KTVHTTPCache
- https://github.com/ksvc/KSYMediaPlayer_iOS

## Author

- Weibo: [@任子丰](https://weibo.com/zifeng1300)
- Email: zifeng1300@gmail.com
- QQ: 459643690
- QQ Group: 213375947（付费群,提供技术支持）

## License

ZFPlayer is available under the MIT license. See the LICENSE file for more info.


