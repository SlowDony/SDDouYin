//
//  SDBaseTableView.m
//  SDInKe
//
//  Created by slowdony on 2018/4/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseTableView.h"

@implementation SDBaseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource     = self;
        self.delegate       = self;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.separatorColor = KMainBackgroundColor;
        self.backgroundColor = [UIColor clearColor];
#ifdef __IPHONE_11_0
        if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        }
#endif
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.baseDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
    {
        [self.baseDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
    //取消选中状态
    [self deselectRowAtIndexPath:indexPath animated:NO];
    
}
@end
