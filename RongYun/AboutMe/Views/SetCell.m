//
//  SetCell.m
//  CNMilitary
//
//  Created by apple on 15/4/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SetCell.h"

@implementation SetCell

- (void)awakeFromNib {
    // Initialization code
    _lab1.backgroundColor = LineColor;
    _lab2.backgroundColor = LineColor;
    
    UIView *v1 = _lab1;
    UIView *v2 = _lab2;
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v1(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v1)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v2(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v2)]];

//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[v1(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v1)]];
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v2(0.5)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(v2)]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
