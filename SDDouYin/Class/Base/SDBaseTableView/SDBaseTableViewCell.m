//
//  SDBaseTableViewCell.m
//  SDInKe
//
//  Created by slowdony on 2018/4/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDBaseTableViewCell.h"

@implementation SDBaseTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifier = [classname stringByAppendingString:@"CellID"];
    [tableView registerClass:[self class] forCellReuseIdentifier:identifier];
    
    SDBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell =[[SDBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        self.backgroundColor = KNavigationBarBackgroundColor;
        self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.bounds];
        self.selectedBackgroundView.backgroundColor = KMainBackgroundColor;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
}

@end
