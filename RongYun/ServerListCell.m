//
//  ServerListCell.m
//  RongYun
//
//  Created by 乐米科技 on 5/10/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "ServerListCell.h"
#import "WHDefine.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
@implementation ServerListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (UINib *)serverListCellNib
{
    return [UINib nibWithNibName:@"ServerListCell" bundle:nil];
}
- (void)awakeFromNib {
    // Initialization code
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2;
    [self.headImageView.layer setMasksToBounds:YES];
    self.nameLB.textColor = COLOR_REDWINE;
}
- (void)setModel:(ServerListEntity *)model
{
    [self.headImageView setImageWithURL:[NSURL URLWithString:model.s_ico] placeholderImage:ImageFile(@"family_ima", @"png")];
    
    self.typeImageView.image = [UIImage imageNamed:@"s_type"];
    self.typeLB.text = model.s_type;
    self.nameLB.text = model.s_name;
    [self.briefLB setTitle:model.s_desc forState:UIControlStateNormal];
    if ([model.s_valida_state integerValue]==0) {
        self.flagLB.backgroundColor = [UIColor lightGrayColor];
        self.flagLB.text =@"过期";
    }else
    {
        self.flagLB.backgroundColor = [UIColor blueColor];
        self.flagLB.text =@"认证";
    }
//    self.flagLB.text = model.s_info;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
