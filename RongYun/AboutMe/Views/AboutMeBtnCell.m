//
//  AboutMeBtnCell.m
//  RongYun
//
//  Created by apple on 15/5/12.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "AboutMeBtnCell.h"

@implementation AboutMeBtnCell

- (void)awakeFromNib {
    // Initialization code
    _bgView.layer.borderColor = [LineColor CGColor];
    _bgView.layer.borderWidth = 1;
    
    _lineView1.backgroundColor = LineColor;
    _lineView2.backgroundColor = LineColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showInfoVC:(id)sender {
    [_mydelegate pushMyInfo];
}
- (IBAction)showPhoto:(id)sender {
    [_mydelegate pushMyPhoto];
}

- (IBAction)showPhone:(id)sender {
    [_mydelegate pushMyContact];
}
@end
