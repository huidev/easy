//
//  NoticeCell.m
//  RongYun
//
//  Created by apple on 15/5/13.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "NoticeCell.h"

@implementation NoticeCell

- (void)awakeFromNib {
    // Initialization code
    _lineView1.backgroundColor = LineColor;
    _lineView2.backgroundColor = LineColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
