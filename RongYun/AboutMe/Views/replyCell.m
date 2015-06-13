//
//  replyCell.m
//  RongYun
//
//  Created by apple on 15/6/9.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "replyCell.h"

@implementation replyCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineView(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lineView)]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
