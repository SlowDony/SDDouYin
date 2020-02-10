//
//  SDHomeListTableViewCell.h
//  SDDouYin
//
//  Created by slowdony on 2018/8/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseTableViewCell.h"
#import "SDHomeBtnView.h"
#import "SDAweme.h"
@interface SDHomeListTableViewCell : SDBaseTableViewCell
@property (nonatomic,strong) SDHomeBtnView *btnView;
@property (nonatomic,strong) UIImageView *topImageView;
//+(instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setValueAweme:(SDAweme *)aweme;

@end
