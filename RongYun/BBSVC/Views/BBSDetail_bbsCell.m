//
//  BBSDetail_postCell.m
//  RongYun
//
//  Created by apple on 15/5/22.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BBSDetail_bbsCell.h"
#import "UIImageView+WebCache.h"
@implementation BBSDetail_bbsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setBbsModel:(UserBBSModel *)bbsModel{

    [_imageV sd_setImageWithURL:[NSURL URLWithString:bbsModel.f_ico] placeholderImage:nil];
    _titleLab.text = bbsModel.f_name;
    [_peopleBtn setTitle:[NSString stringWithFormat:@"%ld",bbsModel.f_user_count] forState:UIControlStateNormal];
    [_postBtn setTitle:[NSString stringWithFormat:@"%ld",bbsModel.f_theme_num] forState:UIControlStateNormal];
    [_replyBtn setTitle:[NSString stringWithFormat:@"%ld",bbsModel.f_reply_num] forState:UIControlStateNormal];

}

- (void)setBbEntity:(BBSEntity *)bbEntity{
    
    [_imageV sd_setImageWithURL:[NSURL URLWithString:bbEntity.f_ico] placeholderImage:nil];
    _titleLab.text = bbEntity.f_name;
//    [_peopleBtn setTitle:[NSString stringWithFormat:@"%ld",bbEntity.f] forState:UIControlStateNormal];
//    [_postBtn setTitle:[NSString stringWithFormat:@"%ld",bbsModel.f_theme_num] forState:UIControlStateNormal];
//    [_replyBtn setTitle:[NSString stringWithFormat:@"%ld",bbsModel.f_reply_num] forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
