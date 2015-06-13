//
//  BBSDetail_postCell.m
//  RongYun
//
//  Created by apple on 15/5/22.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BBSDetail_postCell.h"
#import "UIImageView+WebCache.h"
@implementation BBSDetail_postCell

- (void)awakeFromNib {
    // Initialization code
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height-1, self.frame.size.width, 0.5f);
    bottomBorder.backgroundColor = [LineColor CGColor];
    [self.contentView.layer addSublayer:bottomBorder];
}

- (void)setPostModel:(PostModel *)postModel{
   // NSLog(@"%@",[postModel.t_photo class]);
    [_imageV sd_setImageWithURL:[NSURL URLWithString:postModel.t_photo] placeholderImage:[UIImage imageNamed:@"b_ima_t_people"]];
    _accountLab.text = postModel.u_name;
    _contentLab.text = postModel.t_content;
    _dateLab.text = postModel.t_create_date;
    _replyCountLab.text = [NSString stringWithFormat:@"%d",[postModel.t_reply_num intValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)set:(id)sender {
    if (_setView.hidden) {
        _setView.hidden = NO;

    }else{
        _setView.hidden = YES;

    }
    
}
- (IBAction)settop:(id)sender {
    
    
    
}
- (IBAction)forbid:(id)sender {
}
@end
