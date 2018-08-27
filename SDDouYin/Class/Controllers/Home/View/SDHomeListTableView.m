//
//  SDHomeListTableView.m
//  SDDouYin
//
//  Created by slowdony on 2018/8/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDHomeListTableView.h"

@implementation SDHomeListTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self =[super initWithFrame:frame style:style];
    if (self) {
        self.dataSource=self;
        self.delegate=self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.pagingEnabled = YES;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
}
#pragma mark ----------UITabelViewDataSource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDHomeListTableViewCell *cell = [SDHomeListTableViewCell cellWithTableView:self];
    SDAweme *aweme = self.dataArray[indexPath.row];
    [cell setValueAweme:aweme];
    return cell;
}


#pragma mark ----------UITabelViewDelegate----------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT;
}

@end
