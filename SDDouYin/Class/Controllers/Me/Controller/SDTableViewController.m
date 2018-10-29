//
//  SDTableViewController.m
//  SDDouYin
//
//  Created by slowdony on 2018/10/29.
//  Copyright © 2018 slowdony. All rights reserved.
//

#import "SDTableViewController.h"
#import "SDMeHeadTitleView.h"
@interface SDTableViewController ()
<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic,strong) SDMeHeadTitleView *titleView;
@property (nonatomic,assign) BOOL isLeftTable;

@end

@implementation SDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

#pragma mark ----------UITabelViewDataSource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    //配置数据
    if(self.isLeftTable){
       cell.textLabel.text = [NSString stringWithFormat:@"哈哈哈%ld",indexPath.row];
    }else{
       cell.textLabel.text = [NSString stringWithFormat:@"哦哦哦%ld",indexPath.row];
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat pointY = scrollView.contentOffset.y;
    NSDictionary *userInfo = @{SDScrollViewOffSetKey:@(pointY)};
    [[NSNotificationCenter defaultCenter]postNotificationName:SDScrollViewOffSetNotification object:nil userInfo:userInfo];
}

#pragma mark ----------UITabelViewDelegate----------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isLeftTable){
       return 100;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    view.backgroundColor = [UIColor redColor];
    [view addSubview:self.titleView];
    
    return view;
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}
-(UITableView *)tableView{
    if(!_tableView){
        
        CGFloat width =  [UIScreen mainScreen].bounds.size.width;
        CGFloat height =  [UIScreen mainScreen].bounds.size.height;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        UIView *headview = [[UIView alloc] init];
        headview.frame = CGRectMake(0, 0, SCREEN_WIDTH, (kWidth(130)+170));
        headview.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = headview;
    }
    return _tableView;
}

-(SDMeHeadTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[SDMeHeadTitleView alloc]initWithFrame:CGRectMake(0,40, SCREEN_WIDTH, 44)];
        @xWeakify
        _titleView.titleBtnClickBlock = ^(UIButton *sender) {
            @xStrongify
            NSInteger index =  sender.tag-10;
//            [self.childVCScrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0)];
            [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
            if(index==0){
                self.isLeftTable = YES;
                [self.tableView reloadData];
            }else{
                self.isLeftTable = NO;
                [self.tableView reloadData];
            }
        };
    }
    return _titleView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
