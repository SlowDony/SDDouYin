//
//  SDNewsTableViewCell.m
//  SDDouYin
//
//  Created by slowdony on 2018/5/17.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDNewsTableViewCell.h"

@implementation SDNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellId = @"SDNewsTableViewCell";
    SDNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell =[[SDNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
       
    }
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        [self setupUI];
        
    }
    return self;
}
-(void)setupUI{
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.image = [UIImage imageNamed:@"imgXiaozhushou80"];
    [self addSubview:headImageView];
    self.headImageView = headImageView;
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kWidth(15)));
        make.width.height.equalTo(@(kWidth(40)));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = KDetailTitleColor;
    timeLabel.text = @"2018-5-10";
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = SDFont(12);
    timeLabel.numberOfLines = 0;
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(kWidth(-15)));
        make.top.equalTo(headImageView.mas_top);
        make.width.equalTo(@(80));
        make.height.equalTo(@(30));
    }];
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = KTitleColor;
    nameLabel.text = @"抖音小助手";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = SDFont(15);
    nameLabel.numberOfLines = 0;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView.mas_right).offset(kWidth(10));
        make.top.equalTo(headImageView.mas_top);
        make.right.equalTo(timeLabel.mas_left);
        make.height.equalTo(@(20));
    }];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor = KTitleColor;
    detailLabel.text = @"#小恶魔";
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.font = SDFont(13);
    detailLabel.numberOfLines = 0;
    [self addSubview:detailLabel];
    self.detailLabel = detailLabel;
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView.mas_right).offset(kWidth(10));
        make.top.equalTo(nameLabel.mas_bottom);
        make.right.equalTo(timeLabel.mas_left);
        make.height.equalTo(@(20));
    }];
    
}
@end
