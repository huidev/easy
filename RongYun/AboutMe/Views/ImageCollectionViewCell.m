//
//  ImageCollectionViewCell.m
//  RongYun
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(PhotoModel *)model{

    NSLog(@"%@",model.p_src);
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.p_src] placeholderImage:nil];
    _praiseLab.text = [NSString stringWithFormat:@"%ld",(long)model.p_praise_count];
    _commentLab.text = [NSString stringWithFormat:@"%ld",model.p_comment_count];
    

}

@end
