//
//  SDBaseTableView.h
//  SDInKe
//
//  Created by slowdony on 2018/4/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDBaseTableViewDelegate <NSObject>

- (void)tableView:(id)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface SDBaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

///通用数据源
@property(nonatomic, strong)NSMutableArray *dataArray;

///代理
@property(nonatomic, weak)id <SDBaseTableViewDelegate> baseDelegate;


@end
