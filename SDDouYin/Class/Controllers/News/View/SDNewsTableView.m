//
//  SDNewsTableView.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDNewsTableView.h"
#import "SDNewsTableViewCell.h"
@implementation SDNewsTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if(self){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
#pragma mark ----------UITabelViewDataSource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDNewsTableViewCell *cell = [SDNewsTableViewCell cellWithTableView:self];
    cell.textLabel.text = @"哈哈";
    return cell;
}


#pragma mark ----------UITabelViewDelegate----------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
