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
   static NSString *cellId = @"SDBaseTableViewCell";
   SDBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell =[[SDBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
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
