//
//  BBSListCell.m
//  RongYun
//
//  Created by 乐米科技 on 5/10/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BBSListCell.h"
#import "UIImageView+WebCache.h"

@implementation BBSListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setBbsModel:(BBSEntity *)bbsModel
{
    [self.themeImageVIew sd_setImageWithURL:[NSURL URLWithString:bbsModel.f_ico] placeholderImage:nil];
    self.typeLB.text = bbsModel.f_type;
    self.titleLB.text = bbsModel.f_name;
    self.contentLB.text = bbsModel.f_des;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
