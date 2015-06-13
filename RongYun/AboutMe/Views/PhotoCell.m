//
//  PhotoCell.m
//  RongYun
//
//  Created by apple on 15/5/13.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "PhotoCell.h"
#import "UIImageView+WebCache.h"
@implementation PhotoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(PhotoAlbumModel *)model{

    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.a_cover_ico] placeholderImage:[UIImage imageNamed:@"b_ima_t_people"]];
    _nameLab.text = model.a_name;
    _numCountLab.text = [NSString stringWithFormat:@"(%ld)",(long)model.a_photo_count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
