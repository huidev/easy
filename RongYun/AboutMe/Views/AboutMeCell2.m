//
//  AboutMeCell2.m
//  RongYun
//
//  Created by apple on 15/5/11.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "AboutMeCell2.h"

@implementation AboutMeCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
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
