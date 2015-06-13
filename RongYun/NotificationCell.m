//
//  NotificationCell.m
//  RongYun
//
//  Created by 乐米科技 on 5/26/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "NotificationCell.h"

@implementation NotificationCell

- (void)awakeFromNib {
    // Initialization code
    self.iconImageView.layer.cornerRadius = 2;
    self.iconImageView.layer.masksToBounds = YES;
}
- (void)setEntity:(NotificationEntity *)entity
{
    _entity = entity;
    self.titleLB.text = entity.m_title;
    self.dateLB.text = entity.m_date;
    self.contentLB.text = entity.m_content_des;
    self.iconImageView.image = [UIImage imageNamed:@"notice_ima"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
