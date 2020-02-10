//
//  SDHomeListTableViewCell.m
//  SDDouYin
//
//  Created by slowdony on 2018/8/27.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDHomeListTableViewCell.h"

@implementation SDHomeListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//+(instancetype)cellWithTableView:(UITableView *)tableView{
//    static NSString *cellId = @"SDHomeListTableViewCell";
//    SDHomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell == nil) {
//        
//        cell =[[SDHomeListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
//    
//    return cell;
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    //顶部图片
    [self.contentView addSubview:self.topImageView];
    
    [self.contentView addSubview:self.btnView];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setValueAweme:(SDAweme *)aweme{
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:[aweme.video.originCover.urlList firstObject]]];
    [self.btnView setValueWithAwemeModel:aweme];
    
}

- (UIImageView *)topImageView{
    if(!_topImageView){
        _topImageView = [[UIImageView alloc] init];
        _topImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _topImageView.contentMode = UIViewContentModeScaleAspectFit;
        _topImageView.tag = 100;
    }
    return _topImageView;
}

-(SDHomeBtnView *)btnView{
    if(!_btnView)
    {
        _btnView = [[SDHomeBtnView alloc]init];
    }
    return _btnView;
}
@end
