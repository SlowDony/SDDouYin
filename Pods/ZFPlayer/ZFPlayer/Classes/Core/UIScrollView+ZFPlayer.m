//
//  UIScrollView+ZFPlayer.m
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

#import "UIScrollView+ZFPlayer.h"
#import <objc/runtime.h>
#import "ZFReachabilityManager.h"
#import "ZFPlayer.h"
#import "ZFKVOController.h"
#import <WebKit/WebKit.h>

UIKIT_STATIC_INLINE void Hook_Method(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL noneSel){
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    if (!originalMethod) {
        Method noneMethod = class_getInstanceMethod(replacedClass, noneSel);
        class_addMethod(originalClass, originalSel, method_getImplementation(noneMethod), method_getTypeEncoding(noneMethod));
        return;
    }
    BOOL addMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (addMethod) {
        /// 如果父类实现，但是当前类未实就崩溃。以下两行的代码是把当前类加进去这个方法，并取到当前类的originalMethod。
        /// The following two lines of code add the current class to the method and take it to the originalMethod of the current class if the superclass implements it, but the current class fails to implement it.
        class_addMethod(originalClass, originalSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

@interface UIScrollView ()

@property (nonatomic, assign) CGFloat offsetY_last;

@end

@implementation UIScrollView (ZFPlayer)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(setDelegate:)
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

- (void)zf_setDelegate:(id<UIScrollViewDelegate>)delegate {
    if (([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) && [delegate conformsToProtocol:@protocol(UIScrollViewDelegate)]) {
        SEL originalSelectors[] = {
            @selector(scrollViewDidEndDecelerating:),
            @selector(scrollViewDidEndDragging:willDecelerate:),
            @selector(scrollViewDidScrollToTop:),
            @selector(scrollViewWillBeginDragging:),
            @selector(scrollViewDidScroll:)
        };
        
        SEL replacedSelectors[] = {
            @selector(zf_scrollViewDidEndDecelerating:),
            @selector(zf_scrollViewDidEndDragging:willDecelerate:),
            @selector(zf_scrollViewDidScrollToTop:),
            @selector(zf_scrollViewWillBeginDragging:),
            @selector(zf_scrollViewDidScroll:)
        };
        
        SEL noneSelectors[] = {
            @selector(add_scrollViewDidEndDecelerating:),
            @selector(add_scrollViewDidEndDragging:willDecelerate:),
            @selector(add_scrollViewDidScrollToTop:),
            @selector(add_scrollViewWillBeginDragging:),
            @selector(add_scrollViewDidScroll:)
        };
        
        for (NSInteger index = 0; index < sizeof(originalSelectors) / sizeof(SEL); ++index) {
            Hook_Method([delegate class], originalSelectors[index], [self class], replacedSelectors[index], noneSelectors[index]);
        }
    }
    [self zf_setDelegate:delegate];
}

#pragma mark - Replace_Method

- (void)zf_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView add_scrollViewDidEndDecelerating:scrollView];
    [self zf_scrollViewDidEndDecelerating:scrollView];
}

- (void)zf_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView add_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    [self zf_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)zf_scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView add_scrollViewDidScrollToTop:scrollView];
    [self zf_scrollViewDidScrollToTop:scrollView];
}

- (void)zf_scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView add_scrollViewDidScroll:scrollView];
    [self zf_scrollViewDidScroll:scrollView];
}

- (void)zf_scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView add_scrollViewWillBeginDragging:scrollView];
    [self zf_scrollViewWillBeginDragging:scrollView];
}

#pragma mark - Add_Method

- (void)add_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [scrollView zf_scrollViewStopScroll];
    }
}

- (void)add_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [scrollView zf_scrollViewStopScroll];
        }
    }
}

- (void)add_scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewStopScroll];
}

- (void)add_scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView scrollViewScrolling];
}

- (void)add_scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView scrollViewBeginDragging];
}

#pragma mark - scrollView did stop scroll

- (void)zf_scrollViewStopScroll {
    if (!self.enableScrollHook) return;
    @weakify(self)
    [self zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath * _Nonnull indexPath) {
        @strongify(self)
        if (self.scrollViewDidStopScroll) self.scrollViewDidStopScroll(indexPath);
    }];
}

- (void)scrollViewBeginDragging {
    if (!self.enableScrollHook) return;
    self.offsetY_last = self.contentOffset.y;
}

- (void)scrollViewScrolling {
    if (!self.enableScrollHook) return;
    CGFloat offsetY = self.contentOffset.y;
    self.scrollDerection = (offsetY - self.offsetY_last > 0) ? ZFPlayerScrollDerectionUp : ZFPlayerScrollDerectionDown;
    self.offsetY_last = offsetY;
    
    // Avoid being paused the first time you play it.
    if (self.contentOffset.y < 0) return;
    if (self.playingIndexPath) {
        UIView *cell = [self zf_getCellForIndexPath:self.playingIndexPath];
        if (!cell) {
            if (self.playerDidDisappearInScrollView) self.playerDidDisappearInScrollView(self.playingIndexPath);
            return;
        }
        UIView *playerView = [cell viewWithTag:self.containerViewTag];
        CGRect rect1 = [playerView convertRect:playerView.frame toView:self];
        CGRect rect = [self convertRect:rect1 toView:self.superview];
        CGFloat topSpacing = rect.origin.y - CGRectGetMinY(self.frame) - CGRectGetMinY(playerView.frame) - self.contentInset.bottom;
        CGFloat bottomSpacing = CGRectGetMaxY(self.frame) - CGRectGetMaxY(rect) + CGRectGetMinY(self.frame) + self.contentInset.top;
        
        if (self.scrollDerection == ZFPlayerScrollDerectionUp) { /// Scroll up
            /// Top area
            if (topSpacing <= 0 && topSpacing > -CGRectGetHeight(rect)/2) {
                /// When the player will disappear.
                if (self.playerWillDisappearInScrollView) self.playerWillDisappearInScrollView(self.playingIndexPath);
            } else if (topSpacing <= -CGRectGetHeight(rect)/2 && topSpacing > -CGRectGetHeight(rect)) {
                /// When the player did disappeared half.
                if (self.playerDisappearHalfInScrollView) self.playerDisappearHalfInScrollView(self.playingIndexPath);
            } else if (topSpacing <= -CGRectGetHeight(rect)) {
                /// When the player did disappeared.
                if (self.playerDidDisappearInScrollView) self.playerDidDisappearInScrollView(self.playingIndexPath);
            } else if (topSpacing > 0 && topSpacing < CGRectGetHeight(self.frame)) {
                /// In visable area
                /// When the player did appeared.
                if (self.playerDidAppearInScrollView) self.playerDidAppearInScrollView(self.playingIndexPath);
            }
        } else if (self.scrollDerection == ZFPlayerScrollDerectionDown) { /// Scroll Down
            /// Bottom area
            if (bottomSpacing <= 0 && bottomSpacing > -CGRectGetHeight(rect)/2) {
                /// When the player will disappear.
                if (self.playerWillDisappearInScrollView) self.playerWillDisappearInScrollView(self.playingIndexPath);
            } else if (bottomSpacing <= -CGRectGetHeight(rect)/2 && bottomSpacing > -CGRectGetHeight(rect)) {
                /// When the player did disappeared half.
                if (self.playerDisappearHalfInScrollView) self.playerDisappearHalfInScrollView(self.playingIndexPath);
            } else if (bottomSpacing <= -CGRectGetHeight(rect)) {
                /// When the player did disappeared.
                if (self.playerDidDisappearInScrollView) self.playerDidDisappearInScrollView(self.playingIndexPath);
            } else if (bottomSpacing > 0 && bottomSpacing < CGRectGetHeight(self.frame)) {
                /// In visable area
                /// When the player did appeared.
                if (self.playerDidAppearInScrollView) self.playerDidAppearInScrollView(self.playingIndexPath);
            }
        }
    }
}

- (void)zf_filterShouldPlayCellWhileScrolling:(void (^ __nullable)(NSIndexPath *indexPath))handler {
    if (!self.shouldAutoPlay) return;
    if ([ZFReachabilityManager sharedManager].isReachableViaWWAN && !self.WWANAutoPlay) return;
    NSArray *cellsArray = nil;
    NSArray *visiableCells = nil;
    NSIndexPath *indexPath = nil;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        visiableCells = [tableView visibleCells];
        // Top
        indexPath = tableView.indexPathsForVisibleRows.firstObject;
        if (self.contentOffset.y <= 0 && (!self.playingIndexPath || [indexPath compare:self.playingIndexPath] == NSOrderedSame)) {
            if (handler) handler(indexPath);
            self.shouldPlayIndexPath = indexPath;
            return;
        }
        
        // Bottom
        indexPath = tableView.indexPathsForVisibleRows.lastObject;
        if (self.contentOffset.y + self.frame.size.height >= self.contentSize.height && (!self.playingIndexPath || [indexPath compare:self.playingIndexPath] == NSOrderedSame)) {
            if (handler) handler(indexPath);
            self.shouldPlayIndexPath = indexPath;
            return;
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        visiableCells = [collectionView visibleCells];
        // Top
        indexPath = collectionView.indexPathsForVisibleItems.firstObject;
        if (self.contentOffset.y <= 0 && (!self.playingIndexPath || [indexPath compare:self.playingIndexPath] == NSOrderedSame)) {
            if (handler) handler(indexPath);
            self.shouldPlayIndexPath = indexPath;
            return;
        }
        
        // Bottom
        indexPath = collectionView.indexPathsForVisibleItems.lastObject;
        if (self.contentOffset.y + self.frame.size.height >= self.contentSize.height && (!self.playingIndexPath || [indexPath compare:self.playingIndexPath] == NSOrderedSame)) {
            if (handler) handler(indexPath);
            self.shouldPlayIndexPath = indexPath;
            return;
        }
    }
    
    if (self.scrollDerection == ZFPlayerScrollDerectionUp) {
        cellsArray = visiableCells;
    } else {
        cellsArray = [visiableCells reverseObjectEnumerator].allObjects;
    }
    
    [cellsArray enumerateObjectsUsingBlock:^(UIView *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *playerView = [cell viewWithTag:self.containerViewTag];
        CGRect rect1 = [playerView convertRect:playerView.frame toView:self];
        CGRect rect = [self convertRect:rect1 toView:self.superview];
        CGFloat topSpacing = rect.origin.y - CGRectGetMinY(self.frame) - CGRectGetMinY(playerView.frame) - self.contentInset.bottom;
        CGFloat bottomSpacing = CGRectGetMaxY(self.frame) - CGRectGetMaxY(rect) + CGRectGetMinY(self.frame) + self.contentInset.top;
        NSIndexPath *indexPath = [self zf_getIndexPathForCell:cell];
        /// Play when the video playback section is visible.
        if ((topSpacing >= -CGRectGetHeight(rect)/2) && (bottomSpacing >= -CGRectGetHeight(rect)/2)) {
            if (self.playingIndexPath) {
                indexPath = self.playingIndexPath;
            }
            if (handler) handler(indexPath);
            self.shouldPlayIndexPath = indexPath;
            *stop = YES;
        }
    }];
}

- (void)zf_filterShouldPlayCellWhileScrolled:(void (^ __nullable)(NSIndexPath *indexPath))handler {
    if (!self.shouldAutoPlay) return;
    if ([ZFReachabilityManager sharedManager].isReachableViaWWAN && !self.WWANAutoPlay) return;
    @weakify(self)
    [self zf_filterShouldPlayCellWhileScrolling:^(NSIndexPath *indexPath) {
        @strongify(self)
        if ([ZFReachabilityManager sharedManager].isReachableViaWWAN) return;
        if (!self.playingIndexPath) {
            if (handler) handler(indexPath);
            self.playingIndexPath = indexPath;
        }
    }];
}

- (UIView *)zf_getCellForIndexPath:(NSIndexPath *)indexPath {
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        return cell;
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (NSIndexPath *)zf_getIndexPathForCell:(UIView *)cell {
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        NSIndexPath *indexPath = [tableView indexPathForCell:(UITableViewCell *)cell];
        return indexPath;
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        NSIndexPath *indexPath = [collectionView indexPathForCell:(UICollectionViewCell *)cell];
        return indexPath;
    }
    return nil;
}

- (void)zf_scrollToRowAtIndexPath:(NSIndexPath *)indexPath completionHandler:(void (^ __nullable)(void))completionHandler {
    [UIView animateWithDuration:0.5 animations:^{
        if ([self isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)self;
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        } else if ([self isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)self;
            [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        }
    } completion:^(BOOL finished) {
        if (completionHandler) completionHandler();
    }];
}

#pragma mark - getter

- (BOOL)enableScrollHook {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (BOOL)isPlaying {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (NSIndexPath *)playingIndexPath {
    return objc_getAssociatedObject(self, _cmd);
}

- (NSIndexPath *)shouldPlayIndexPath {
    return objc_getAssociatedObject(self, _cmd);
}

- (NSInteger)containerViewTag {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (ZFPlayerScrollDerection)scrollDerection {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (BOOL)stopWhileNotVisible {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (BOOL)isWWANAutoPlay {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (BOOL)shouldAutoPlay {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) return number.boolValue;
    self.shouldAutoPlay = YES;
    return YES;
}

- (void (^)(NSIndexPath * _Nonnull))playerDidAppearInScrollView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void (^)(NSIndexPath * _Nonnull))playerWillDisappearInScrollView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void (^)(NSIndexPath * _Nonnull))playerDisappearHalfInScrollView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void (^)(NSIndexPath * _Nonnull))playerDidDisappearInScrollView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void (^)(NSIndexPath * _Nonnull))scrollViewDidStopScroll {
    return objc_getAssociatedObject(self, _cmd);
}

- (CGFloat)offsetY_last {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

#pragma mark - setter

- (void)setEnableScrollHook:(BOOL)enableScrollHook {
    objc_setAssociatedObject(self, @selector(enableScrollHook), @(enableScrollHook), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPlaying:(BOOL)playing {
    objc_setAssociatedObject(self, @selector(isPlaying), @(playing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPlayingIndexPath:(NSIndexPath *)playingIndexPath {
    objc_setAssociatedObject(self, @selector(playingIndexPath), playingIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShouldPlayIndexPath:(NSIndexPath *)shouldPlayIndexPath {
    objc_setAssociatedObject(self, @selector(shouldPlayIndexPath), shouldPlayIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setContainerViewTag:(NSInteger)containerViewTag {
    objc_setAssociatedObject(self, @selector(containerViewTag), @(containerViewTag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setScrollDerection:(ZFPlayerScrollDerection)scrollDerection {
    objc_setAssociatedObject(self, @selector(scrollDerection), @(scrollDerection), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setStopWhileNotVisible:(BOOL)stopWhileNotVisible {
    objc_setAssociatedObject(self, @selector(stopWhileNotVisible), @(stopWhileNotVisible), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setWWANAutoPlay:(BOOL)WWANAutoPlay {
    objc_setAssociatedObject(self, @selector(isWWANAutoPlay), @(WWANAutoPlay), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShouldAutoPlay:(BOOL)shouldAutoPlay {
    objc_setAssociatedObject(self, @selector(shouldAutoPlay), @(shouldAutoPlay), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPlayerDidAppearInScrollView:(void (^)(NSIndexPath * _Nonnull))playerDidAppearInScrollView {
    objc_setAssociatedObject(self, @selector(playerDidAppearInScrollView), playerDidAppearInScrollView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setPlayerWillDisappearInScrollView:(void (^)(NSIndexPath * _Nonnull))playerWillDisappearInScrollView {
    objc_setAssociatedObject(self, @selector(playerWillDisappearInScrollView), playerWillDisappearInScrollView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setPlayerDisappearHalfInScrollView:(void (^)(NSIndexPath * _Nonnull))playerDisappearHalfInScrollView {
    objc_setAssociatedObject(self, @selector(playerDisappearHalfInScrollView), playerDisappearHalfInScrollView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setPlayerDidDisappearInScrollView:(void (^)(NSIndexPath * _Nonnull))playerDidDisappearInScrollView {
    objc_setAssociatedObject(self, @selector(playerDidDisappearInScrollView), playerDidDisappearInScrollView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setScrollViewDidStopScroll:(void (^)(NSIndexPath * _Nonnull))scrollViewDidStopScroll {
    objc_setAssociatedObject(self, @selector(scrollViewDidStopScroll), scrollViewDidStopScroll, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setOffsetY_last:(CGFloat)offsetY_last {
    objc_setAssociatedObject(self, @selector(offsetY_last), @(offsetY_last), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
