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
    
    return cell;
}


#pragma mark ----------UITabelViewDelegate----------


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
    view.backgroundColor = KMainBackgroundColor;
    return view;
}
@end
