//
//  BBSCell.m
//  RongYun
//
//  Created by apple on 15/5/18.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BBSCell.h"
#import "UIImageView+WebCache.h"

@implementation BBSCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setBbsModel:(UserBBSModel *)bbsModel
{

    _nameLab.text = bbsModel.f_name;
    _typeLab.text = bbsModel.f_type;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:bbsModel.f_ico] placeholderImage:[UIImage imageNamed:@"b_ima_t_people"]];
    [_userCountBtn setTitle:[NSString stringWithFormat:@"%ld", (long)bbsModel.f_user_count] forState:UIControlStateNormal];
    [_postCountBtn setTitle:[NSString stringWithFormat:@"%ld",bbsModel.f_theme_num] forState:UIControlStateNormal];
    _briefLab.text = bbsModel.f_des;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
