//
//  PostCell.m
//  RongYun
//
//  Created by apple on 15/5/16.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "PostListCell.h"
#import "UIImageView+WebCache.h"
@implementation PostListCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setPostModel:(PostModel *)postModel
{

    _titleLab.text = postModel.t_title;
    [_porImageV sd_setImageWithURL:[NSURL URLWithString:postModel.u_ico] placeholderImage:nil];
    if (postModel.f_name.length) {
        _fromLab.text = [NSString stringWithFormat:@"来自于:%@",postModel.f_name];

    }
    _phoneLab.text = postModel.u_name;
    _dateLab.text = postModel.t_create_date;
    if ([postModel.t_reply_num isKindOfClass:[NSNumber class]]) {
        _replyLab.text = [NSString stringWithFormat:@"%@",postModel.t_reply_num];

    }else{
        _replyLab.text = postModel.t_reply_num;

    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
